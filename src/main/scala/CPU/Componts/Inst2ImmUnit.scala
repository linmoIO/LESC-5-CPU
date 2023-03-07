package CPU.Componts

import chisel3._
import CPU.CPUConfig._

/**
 * <b>[[指令to立即数转换器]]</b>
 * <p>
 * 根据 32 位指令生成对应 type 的立即数
 * <p>
 * [[input]]
 *   - inst : 来自 InstMemory 取出的指令, 完整的 32 位
 * <p>
 * [[output]]
 *   - imm : 根据 32 位指令生成的对应的符号扩展的立即数
 */
class Inst2ImmUnit extends Module {
  val io = IO(new Bundle {
    /* input */
    val inst = Input(UInt(INST_W.W))
    /* output */
    val imm = Output(UInt(XLEN.W))
  })
  io.imm := 0.U
}
