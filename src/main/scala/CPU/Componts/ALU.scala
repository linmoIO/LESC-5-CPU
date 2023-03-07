package CPU.Componts

import chisel3._
import CPU.CPUConfig._

/**
 * <b>[[ALU 运算单元]]</b>
 * <p>
 * 根据 ALU 控制单元传来的操作码, 对数据进行计算
 * <p>
 * [[input]]
 *   - aluOperation : 操作码, 来自 ALUControlUnit
 *   - x : 待计算的数据 1
 *   - y : 待计算的数据 2
 * <p>
 * [[output]]
 *   - result : 计算得到的结果
 */
class ALU extends Module {
  val io = IO(new Bundle {
    /* input */
    val aluOperation = Input(UInt(ALU_OPERATION_W.W))
    val x = Input(UInt(XLEN.W))
    val y = Input(UInt(XLEN.W))
    /* output */
    val result = Output(UInt(XLEN.W))
  })
  io.result := 0.U
}
