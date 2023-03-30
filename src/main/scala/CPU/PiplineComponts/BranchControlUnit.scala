package CPU.PiplineComponts

import chisel3._
import chisel3.util._
import CPU.CPUConfig._
import CPU._

/**
 * <b>[[分支跳转控制器]]</b>
 * <p>
 * 针对流水线 CPU 设计的组件，用于解决控制冒险。(无分支预测功能, 单纯进行气泡插入, 控制流水线的暂停和继续)
 * <p>
 * [[input]]
 * <p>
 * [[output]]
 */
class BranchControlUnit extends Module {
  val io = IO(new Bundle {
    /* input */
    val keep = Input(Bool()) // 来自 DataControlUnit, 控制 PC 保持不动
    val isJump = Input(Bool())
    val isBType = Input(Bool())

    val ifPC = Input(UInt(XLEN.W)) // IF 阶段的 PC
    val idPC = Input(UInt(XLEN.W)) // ID 阶段的 PC
    val exePC = Input(UInt(XLEN.W)) // EXE 阶段的 PC

    val selectPC = Input(UInt(XLEN.W)) // 来自 PCSelectUnit 的 PC
    /* output */
    val nextPC = Output(UInt(XLEN.W)) // 生成的下一个 PC, 接到 PCReg.in 上
    val flush = Output(Bool()) // 输出的流水线冲刷信号, 接到 IF/ID 的寄存器组上
  })

  /**
    * FSM 的状态
    * Normal : 正常
    * Branch : 检测到分支, 在等待处理结果
    * Res : 获取到结果, 等待执行成功
    */
  val sNormal :: sBranch :: sRes :: Nil = Enum(3)

  val stateReg = RegInit(sNormal) // 状态寄存器
  val pcRecordReg = RegInit(0.U(XLEN.W)) // PC 记录寄存器
  val flushReg = RegInit(false.B) // 加一个寄存器, 防止回环

  val nextPC = WireDefault(io.ifPC + INST_BYTE.U)

  when(io.keep) { // 数据冒险的控制优先级更高
    nextPC := io.ifPC // PC 维持
    flushReg := false.B // ID 不冲刷
    // stateReg := sNormal // 保持正常状态
  }.otherwise {
    switch(stateReg) {
      is(sNormal) { // 一般状态下
        nextPC := io.ifPC + INST_BYTE.U // PC + 4
        flushReg := false.B // 正常流动

        when(io.isJump || io.isBType) { // 检测到分支跳转
          nextPC := 0.U
          pcRecordReg := io.idPC
          flushReg := true.B // 插入气泡
          stateReg := sBranch // 进入下一个状态
        }
      }

      is(sBranch) { // 检测到分支跳转, 等待结果
        nextPC := 0.U
        flushReg := true.B

        when(io.exePC === pcRecordReg) { // 检测到可获取结果
          nextPC := io.selectPC
          pcRecordReg := io.selectPC
          flushReg := true.B
          stateReg := sRes // 进入下一个状态
        }
      }

      is(sRes) { // 获取到结果
        nextPC := pcRecordReg
        flushReg := true.B

        when(io.ifPC === pcRecordReg) { // 成功取到正确指令, 退出本次控制
          nextPC := io.ifPC + INST_BYTE.U // PC + 4
          pcRecordReg := 0.U // 清空记录
          flushReg := false.B
          stateReg := sNormal // 回到正常状态
        }
      }
    }
  }

  io.flush := flushReg
  io.nextPC := nextPC

  // **************** print **************** //
  val needBinary = List[Data]()
  val needDec = List[Data]()
  val needHex =
    List[Data](io.ifPC, io.idPC, io.exePC, io.selectPC, io.nextPC, pcRecordReg)
  val needBool = List[Bool]()
    .appendedAll(io.getElements.filter(data => data.isInstanceOf[Bool]))

  val needDelete = List[Data]()
  val needAdd = List[Data](stateReg, pcRecordReg)

  if (DebugControl.BranchControlUnitIOPrint) {
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
