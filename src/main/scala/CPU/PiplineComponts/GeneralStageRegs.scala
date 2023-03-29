package CPU.PiplineComponts

import chisel3._

/**
 * <b>[[通用流水线寄存器组的IO]]</b>
 * <p>
 * 根据参数 dataFlow, 封装不同的寄存器组 IO, 满足不同阶段的 IO 需求
 * <p>
 * [[input]]
 * <p>
 * [[output]]
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
 * <b>[[通用流水线寄存器组]]</b>
 * <p>
 * 用于创建流水线上各个阶段的寄存器组
 * <p>
 * [[input]]
 * <p>
 * [[output]]
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
