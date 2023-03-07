package CPU.Componts

import chisel3._
import CPU.CPUConfig._

/**
 * <b>[[寄存器单元]]</b>
 * <p>
 * 由 32 个寄存器形成的寄存器单元, 执行 读/写寄存器 的操作
 * <p>
 * [[input]]
 *   - rs1 : rs1 寄存器, 根据指令的 [19-15] 得到
 *   - rs2 : rs2 寄存器, 根据指令的 [24-20] 得到
 *   - rd : rd 寄存器, 根据指令的 [11-7] 得到
 *   - writeEnable : 写使能, 来自于 ControlUnit.ifWriteToReg
 *   - writeData : 要写入的数据, 来自于 ResSelectUnit.out
 * <p>
 * [[output]]
 *   - readDataRs1 : 从 rs1 中读出的数据
 *   - readDataRs2 : 从 rs2 中读出的数据
 */
class RegUnit extends Module {
  val io = IO(new Bundle {
    /* input */
    val rs1 = Input(UInt(5.W))
    val rs2 = Input(UInt(5.W))
    val rd = Input(UInt(5.W))
    val writeEnable = Input(Bool())
    val writeData = Input(UInt(XLEN.W))
    /* output */
    val readDataRs1 = Output(UInt(XLEN.W))
    val readDataRs2 = Output(UInt(XLEN.W))
  })
  io.readDataRs1 := 0.U
  io.readDataRs2 := 0.U
}
