package CPU.PiplineComponts

import chisel3._
import chisel3.util._
import CPU.CPUConfig._
import CPU._

/**
 * <b>[[数据冒险判断器]]</b>
 * <p>
 * 用组合电路判断是否存在数据冒险, 将判断的逻辑从旁路转发器中提取出来, 符合模块化设计
 * <p>
 * [[input]]
 * <p>
 * [[output]]
 */
class HazardJudgement extends Module {
  val io = IO(new Bundle {
    /* input */
    val pcRs1ToAlu = Input(Bool())
    val rs1 = Input(UInt(5.W))

    val memWrite = Input(Bool()) // 内存写入也会用到 rs2
    val immRs2ToAlu = Input(Bool())
    val rs2 = Input(UInt(5.W))

    val exeWriteEnable = Input(Bool())
    val exeRd = Input(UInt(5.W))

    val memWriteEnable = Input(Bool())
    val memRd = Input(UInt(5.W))
    /* output */
    val ifRs1EXE = Output(Bool())
    val ifRs2EXE = Output(Bool())
    val ifRs1MEM = Output(Bool())
    val ifRs2MEM = Output(Bool())
  })
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

  val ifRs1EXE =
    (exeWriteRd =/= 0.U) && (useRs1 === exeWriteRd) // EXE 阶段和 rs1 数据冲突
  val ifRs2EXE =
    (exeWriteRd =/= 0.U) && (useRs2 === exeWriteRd) // EXE 阶段和 rs2 数据冲突

  val ifRs1MEM =
    (memWriteRd =/= 0.U) && (useRs1 === memWriteRd) // MEM 阶段和 rs1 数据冲突
  val ifRs2MEM =
    (memWriteRd =/= 0.U) && (useRs2 === memWriteRd) // MEM 阶段和 rs1 数据冲突

  io.ifRs1EXE := ifRs1EXE
  io.ifRs2EXE := ifRs2EXE
  io.ifRs1MEM := ifRs1MEM
  io.ifRs2MEM := ifRs2MEM
}

/**
 * <b>[[数据转发器]]</b>
 * <p>
 * 旁路转发中的数据转发模块
 * <p>
 * [[input]]
 * <p>
 * [[output]]
 */
class DataForwarding extends Module {
  val io = IO(new Bundle {
    /* input */
    val ifRs1EXE = Input(Bool())
    val ifRs2EXE = Input(Bool())
    val ifRs1MEM = Input(Bool())
    val ifRs2MEM = Input(Bool())

    val exeIsJump = Input(Bool())
    val exeImmALUToReg = Input(Bool())
    val exeMemRead = Input(Bool())
    val exeALUResult = Input(UInt(XLEN.W))
    val exeImm = Input(UInt(XLEN.W))

    val memIsJump = Input(Bool())
    val memImmALUToReg = Input(Bool())
    val memMemRead = Input(Bool())
    val memReadData = Input(UInt(XLEN.W))
    val memALUResult = Input(UInt(XLEN.W))
    val memImm = Input(UInt(XLEN.W))

    val exePC = Input(UInt(XLEN.W)) // EXE 阶段的 PC
    val memPC = Input(UInt(XLEN.W)) // MEM 阶段的 PC

    /* output */
    val keep = Output(Bool()) // 控制 BranchControlUnit
    val stall = Output(Bool()) // 连 IF/ID 的寄存器组
    val flush = Output(Bool()) // 连 ID/EXE 的寄存器组

    val forwardRs1 = Output(Bool()) // 是否将输出转发到 rs1
    val forwardRs2 = Output(Bool()) // 是否将输出转发到 rs2
    val forwardData1 = Output(UInt(XLEN.W)) // 转发到 rs1 的输出
    val forwardData2 = Output(UInt(XLEN.W)) // 转发到 rs2 的输出
  })

  /**
    * FSM 的状态
    * Normal : 正常
    * EXE : 在 EXE 检测到对应的数据源, 等待 MEM 阶段获取对应的数据
    */
  val sNormal :: sEXE :: Nil = Enum(2)

  val stateReg = RegInit(sNormal) // 状态寄存器
  val pcRecordReg = RegInit(0.U(XLEN.W)) // PC 记录寄存器
  val ifNeedRs1 = RegInit(false.B) // 记录 rs1 是否需要转发 (用于 EXE 状态)
  val ifNeedRs2 = RegInit(false.B) // 记录 rs2 是否需要转发 (用于 EXE 状态)

  val keep = WireDefault(false.B) // 是否让 PC 保持不动
  val stall = WireDefault(false.B) // 是否让 ID 保持不动
  val flush = WireDefault(false.B) // 是否让 EXE 为 0.U

  val forwardRs1 = WireDefault(false.B) // 默认不转发
  val forwardRs2 = WireDefault(false.B) // 默认不转发
  val forwardData1 = WireDefault(0.U(XLEN.W))
  val forwardData2 = WireDefault(0.U(XLEN.W))

  val exeResWire = WireDefault(io.exeALUResult)
  when(io.exeIsJump === true.B) {
    exeResWire := io.exePC + 4.U
  }.elsewhen(io.exeImmALUToReg === true.B) {
    exeResWire := io.exeImm
  }

  val memResWire = WireDefault(io.memALUResult)
  when(io.memMemRead === true.B) {
    memResWire := io.memReadData
  }.elsewhen(io.memIsJump === true.B) {
    memResWire := io.memPC + 4.U
  }.elsewhen(io.memImmALUToReg === true.B) {
    memResWire := io.memImm
  }

  /* 状态机 */
  switch(stateReg) {
    is(sNormal) { // 在一般状态下
      keep := false.B
      stall := false.B
      flush := false.B
      ifNeedRs1 := false.B
      ifNeedRs2 := false.B

      when(io.ifRs1EXE === true.B) {
        when(io.exeMemRead === true.B) { // 得等到 MEM 阶段才能得到数据
          ifNeedRs1 := true.B // 记录 rs1 需要转发
          pcRecordReg := io.exePC // 记录数据源 PC
          keep := true.B // 使 PC 不动
          stall := true.B // 使 ID 不动
          stateReg := sEXE // 进入下一个状态

        }.otherwise { // 可以直接拿到数据
          forwardData1 := exeResWire
          forwardRs1 := true.B // 表示将数据转发到 rs1
        }
      }.otherwise { // EXE 阶段比 MEM 阶段优先级更高
        when(io.ifRs1MEM === true.B) {
          forwardData1 := memResWire
          forwardRs1 := true.B // 表示将数据转发到 rs1
        }
      }

      when(io.ifRs2EXE === true.B) {
        when(io.exeMemRead === true.B) { // 得等到 MEM 阶段才能得到数据
          ifNeedRs2 := true.B // 记录 rs2 需要转发
          pcRecordReg := io.exePC // 记录数据源 PC
          keep := true.B // 使 PC 不动
          stall := true.B // 使 ID 不动
          stateReg := sEXE // 进入下一个状态

        }.otherwise {
          forwardData2 := exeResWire
          forwardRs2 := true.B // 表示将数据转发到 rs2
        }
      }.otherwise { // EXE 阶段比 MEM 阶段优先级更高
        when(io.ifRs2MEM === true.B) {
          forwardData2 := memResWire
          forwardRs2 := true.B // 表示将数据转发到 rs1
        }
      }
    }

    is(sEXE) {
      keep := true.B // 使 PC 不动
      stall := true.B // 使 ID 不动
      flush := true.B // 冲刷 EXE

      when(io.memPC === pcRecordReg) { // 当数据源进入到 MEM 阶段
        when(ifNeedRs1 === true.B) {
          forwardData1 := memResWire
          forwardRs1 := true.B // 表示将数据转发到 rs1
        }
        when(ifNeedRs2 === true.B) {
          forwardData2 := memResWire
          forwardRs2 := true.B // 表示将数据转发到 rs1
        }

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

  io.forwardRs1 := forwardRs1
  io.forwardRs2 := forwardRs2
  io.forwardData1 := forwardData1
  io.forwardData2 := forwardData2
}

/**
 * <b>[[数据旁路转发组]]</b>
 * <p>
 * 用旁路转发的方式解决流水线 CPU 的数据冒险问题。
 * 分为 数据冒险判断器 和 数据转发器 两个模块。
 * <p>
 * [[input]]
 * <p>
 * [[output]]
 */
class DataForwardingUnit extends Module {
  val io = IO(new Bundle {
    /* input */
    val pcRs1ToAlu = Input(Bool())
    val rs1 = Input(UInt(5.W))

    val memWrite = Input(Bool()) // 内存写入也会用到 rs2
    val immRs2ToAlu = Input(Bool())
    val rs2 = Input(UInt(5.W))

    val exeWriteEnable = Input(Bool())
    val exeRd = Input(UInt(5.W))

    val memWriteEnable = Input(Bool())
    val memRd = Input(UInt(5.W))

    val exeIsJump = Input(Bool())
    val exeImmALUToReg = Input(Bool())
    val exeMemRead = Input(Bool())
    val exeALUResult = Input(UInt(XLEN.W))
    val exeImm = Input(UInt(XLEN.W))

    val memIsJump = Input(Bool())
    val memImmALUToReg = Input(Bool())
    val memMemRead = Input(Bool())
    val memReadData = Input(UInt(XLEN.W))
    val memALUResult = Input(UInt(XLEN.W))
    val memImm = Input(UInt(XLEN.W))

    val exePC = Input(UInt(XLEN.W)) // EXE 阶段的 PC
    val memPC = Input(UInt(XLEN.W)) // MEM 阶段的 PC

    /* output */
    val keep = Output(Bool()) // 控制 BranchControlUnit
    val stall = Output(Bool()) // 连 IF/ID 的寄存器组
    val flush = Output(Bool()) // 连 ID/EXE 的寄存器组

    val forwardRs1 = Output(Bool()) // 是否将输出转发到 rs1
    val forwardRs2 = Output(Bool()) // 是否将输出转发到 rs2
    val forwardData1 = Output(UInt(XLEN.W)) // 转发到 rs1 的输出
    val forwardData2 = Output(UInt(XLEN.W)) // 转发到 rs2 的输出
  })

  val hazardJudgement = Module(new HazardJudgement())
  val dataForwarding = Module(new DataForwarding())

  hazardJudgement.io.pcRs1ToAlu := io.pcRs1ToAlu
  hazardJudgement.io.rs1 := io.rs1
  hazardJudgement.io.memWrite := io.memWrite
  hazardJudgement.io.immRs2ToAlu := io.immRs2ToAlu
  hazardJudgement.io.rs2 := io.rs2
  hazardJudgement.io.exeWriteEnable := io.exeWriteEnable
  hazardJudgement.io.exeRd := io.exeRd
  hazardJudgement.io.memWriteEnable := io.memWriteEnable
  hazardJudgement.io.memRd := io.memRd

  dataForwarding.io.ifRs1EXE := hazardJudgement.io.ifRs1EXE
  dataForwarding.io.ifRs2EXE := hazardJudgement.io.ifRs2EXE
  dataForwarding.io.ifRs1MEM := hazardJudgement.io.ifRs1MEM
  dataForwarding.io.ifRs2MEM := hazardJudgement.io.ifRs2MEM

  dataForwarding.io.exeIsJump := io.exeIsJump
  dataForwarding.io.exeImmALUToReg := io.exeImmALUToReg
  dataForwarding.io.exeMemRead := io.exeMemRead
  dataForwarding.io.exeALUResult := io.exeALUResult
  dataForwarding.io.exeImm := io.exeImm

  dataForwarding.io.memIsJump := io.memIsJump
  dataForwarding.io.memImmALUToReg := io.memImmALUToReg
  dataForwarding.io.memMemRead := io.memMemRead
  dataForwarding.io.memReadData := io.memReadData
  dataForwarding.io.memALUResult := io.memALUResult
  dataForwarding.io.memImm := io.memImm

  dataForwarding.io.exePC := io.exePC
  dataForwarding.io.memPC := io.memPC

  io.keep := dataForwarding.io.keep
  io.stall := dataForwarding.io.stall
  io.flush := dataForwarding.io.flush

  io.forwardRs1 := dataForwarding.io.forwardRs1
  io.forwardRs2 := dataForwarding.io.forwardRs2
  io.forwardData1 := dataForwarding.io.forwardData1
  io.forwardData2 := dataForwarding.io.forwardData2

  // **************** print **************** //
  val needBinary = List[Data]()
  val needDec =
    List[Data](io.rs1, io.rs2, io.exeRd, io.memRd)
  val needHex = List[Data](io.exePC, io.memPC)
  val needBool = List[Bool]()
    .appendedAll(io.getElements.filter(data => data.isInstanceOf[Bool]))

  val needDelete = List[Data]()
  val needAdd = List[Data]()

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

object DataForwardingUnit {
  def main(args: Array[String]) = {
    print(getVerilogString(new DataForwardingUnit()))

    print("\n[Success]\n")
  }
}
