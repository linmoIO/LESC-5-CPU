package CPU.Componts

import chisel3._
import CPU.CPUConfig._

/**
 * <b>[[指令存储单元]]</b>
 * <p>
 * 存储待执行的指令, 根据 PC 依次取出进行执行
 * <p>
 * [[input]]
 *   - address : PC, 即取值地址, 来自 PCReg.out
 * <p>
 * [[output]]
 *   - inst : 输出对应地址的指令
 */
class InstMemory extends Module {
  val io = IO(new Bundle {
    /* input */
    val address = Input(UInt(XLEN.W))
    /* output */
    val inst = Output(UInt(INST_W.W))
  })
  io.inst := 0.U
}
