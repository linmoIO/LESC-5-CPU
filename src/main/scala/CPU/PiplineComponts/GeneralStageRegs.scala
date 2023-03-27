package CPU.PiplineComponts

import chisel3._

/**
  * 通用 IO 端
  *
  * @param dataFlow
  */
class GeneralStageRegsIO[+T <: Data](dataFlow: T) extends Bundle {
  val stall = Input(Bool()) // 是否暂停 (即保持原本输出)
  val flush = Input(Bool()) // 是否冲刷流水线 (即输出 0.U)

  val in = Input(dataFlow) // 数据输入

  val out = Output(dataFlow) // 数据输出

  // override def cloneType: this.type =
  //   GeneralStageRegsIO(dataFlow).asInstanceOf[this.type] // 用于帮助 Chisel 进行类型推导
}

// object GeneralStageRegsIO {
//   def apply[T <: Data](dataFlow: T): GeneralStageRegsIO[T] =
//     new GeneralStageRegsIO(dataFlow)
// }

/**
  * 通用寄存器组
  *
  * @param dataFlow
  */
class GeneralStageRegs[+T <: Data](dataFlow: T) extends Module {
  val io = IO(new GeneralStageRegsIO[T](dataFlow))

  val reg = RegInit(0.U.asTypeOf(dataFlow))

  // 若暂停则保持
  when(io.stall) {
    reg := reg
  }.otherwise {
    reg := io.in
  }

  // 若冲刷流水线则插入气泡, 输出 0.U
  when(io.flush) {
    io.out := 0.U.asTypeOf(dataFlow)
  }.otherwise {
    io.out := reg
  }
}
