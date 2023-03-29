package CPU.PiplineComponts

import chisel3._
import chisel3.util._
import CPU.CPUConfig._
import CPU._

/**
 * <b>[[数据写回控制器]]</b>
 * <p>
 * 针对流水线 CPU 设计的组件，用于解决数据冒险。(无旁路转发功能, 单纯进行气泡插入, 控制流水线的暂停和继续)
 * <p>
 * [[input]]
 * <p>
 * [[output]]
 */
class DataControlUnit extends Module {
  val io = IO(new Bundle {
    /* input */
    val inWriteEnable = Input(Bool())
    val inRd = Input(UInt(5.W))
    val inData = Input(UInt(XLEN.W))

    val pcRs1ToAlu = Input(Bool())
    val rs1 = Input(UInt(5.W))

    val memWrite = Input(Bool()) // 内存写入也会用到 rs2
    val immRs2ToAlu = Input(Bool())
    val rs2 = Input(UInt(5.W))

    val exeWriteEnable = Input(Bool())
    val exeRd = Input(UInt(5.W))

    val memWriteEnable = Input(Bool())
    val memRd = Input(UInt(5.W))

    val exePC = Input(UInt(XLEN.W)) // EXE 阶段的 PC
    val memPC = Input(UInt(XLEN.W)) // MEM 阶段的 PC
    val wbPC = Input(UInt(XLEN.W)) // WB 阶段的 PC

    /* output */
    val writeEnable = Output(Bool())
    val rd = Output(UInt(5.W))
    val data = Output(UInt(XLEN.W))

    val keep = Output(Bool()) // 控制 BranchControlUnit
    val stall = Output(Bool()) // 连 IF/ID 的寄存器组
    val flush = Output(Bool()) // 连 ID/EXE 的寄存器组
  })

  /**
    * FSM 的状态
    * Normal : 正常
    * EXE : 在 EXE 检测到对应的数据源, 等待数据源继续按流水线前进
    * MEM : 在 MEM 检测到对应的数据源, 等到数据源进入 WB 阶段
    * 由于流水线对于寄存器组设置了读写转发, 所以可以节省一个将结果写入寄存器组的状态
    */
  val sNormal :: sEXE :: sMEM :: Nil = Enum(3)

  val stateReg = RegInit(sNormal) // 状态寄存器
  val pcRecordReg = RegInit(0.U(XLEN.W)) // PC 记录寄存器

  val keep = WireDefault(false.B) // 是否让 PC 保持不动
  val stall = WireDefault(false.B) // 是否让 ID 保持不动
  val flush = WireDefault(false.B) // 是否让 EXE 为 0.U

  // 默认为寄存器 zero
  val useRs1 = WireDefault(0.U(5.W)) // 将读出的寄存器 rs1
  val useRs2 = WireDefault(0.U(5.W)) // 将读出的寄存器 rs2
  val exeWriteRd = WireDefault(0.U(5.W)) // exe 会写入的寄存器
  val memWriteRd = WireDefault(0.U(5.W)) // mem 会写入的寄存器

  /* 组合电路生成对应的寄存器, 简化状态机的判断 */
  when(io.pcRs1ToAlu === false.B) { useRs1 := io.rs1 }
  when(io.immRs2ToAlu === false.B || io.memWrite === true.B) {
    useRs2 := io.rs2
  }
  when(io.exeWriteEnable === true.B) { exeWriteRd := io.exeRd }
  when(io.memWriteEnable === true.B) { memWriteRd := io.memRd }

  /* 状态机 */
  switch(stateReg) {
    is(sNormal) { // 一般状态下
      keep := false.B
      stall := false.B
      flush := false.B

      when(
        (exeWriteRd =/= 0.U) && (useRs1 === exeWriteRd || useRs2 === exeWriteRd)
      ) { // 和 EXE 阶段存在数据冒险
        pcRecordReg := io.exePC // 记录数据源
        keep := true.B // 使 PC 不动
        stall := true.B // 使 ID 不动
        stateReg := sEXE // 进入对应状态
      }.otherwise {
        when(
          (memWriteRd =/= 0.U) && (useRs1 === memWriteRd || useRs2 === memWriteRd)
        ) { // 和 MEM 阶段存在数据冒险
          pcRecordReg := io.memPC // 记录数据源
          keep := true.B // 使 PC 不动
          stall := true.B // 使 ID 不动
          stateReg := sMEM // 进入对应状态
        }
      }
    }

    is(sEXE) { // 源来自于 EXE 的情况下
      keep := true.B // 使 PC 不动
      stall := true.B // 使 ID 不动
      flush := true.B // 冲刷 EXE

      when(io.memPC === pcRecordReg) { // 当数据源进入到 MEM 阶段
        stateReg := sMEM // 进入对应状态
      }
    }

    is(sMEM) { // 源来自于 MEM 的情况下
      keep := true.B // 使 PC 不动
      stall := true.B // 使 ID 不动
      flush := true.B // 冲刷 EXE

      when(io.wbPC === pcRecordReg) { // 当数据源进入到 WB 阶段
        pcRecordReg := 0.U // 清空 pcRecord
        keep := false.B // 使 PC 重新流动
        stall := false.B // 使 ID 重新流动
        stateReg := sNormal // 回到原本状态
      }
    }
  }

  io.keep := keep
  io.stall := stall
  io.flush := flush

  // 这三个保持不变
  io.writeEnable := io.inWriteEnable
  io.rd := io.inRd
  io.data := io.inData

  // **************** print **************** //
  val needBinary = List[Data]()
  val needDec =
    List[Data](io.inData, io.rs1, io.rs2, io.exeRd, io.memRd, io.data)
  val needHex = List[Data](io.exePC, io.memPC, io.wbPC, pcRecordReg)
  val needBool = List[Bool]()
    .appendedAll(io.getElements.filter(data => data.isInstanceOf[Bool]))

  val needDelete = List[Data]()
  val needAdd = List[Data](stateReg, pcRecordReg)

  if (DebugControl.DataControlUnitIOPrint) {
    CPUPrintf.printfIO(
      "INFO",
      this,
      io.getElements
        .filterNot(data => needDelete.contains(data))
        .toList
        .appendedAll(needAdd),
      needBinary,
      needDec,
      needHex,
      needBool
    )
  }
}
