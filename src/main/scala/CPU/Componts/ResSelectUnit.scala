package CPU.Componts

import chisel3._
import CPU.CPUConfig._

/**
 * <b>[[结果选择单元]]</b>
 * <p>
 * 根据控制信号选择所需要的结果
 * <p>
 * [[input]]
 *   - isJump : 若 isJump = True, 则将 PC+4 放入寄存器(保存返回地址)
 *   - immALUToReg : 将 立即数/ALU的结果 放入寄存器
 *   - memRead : 若 memRead = True, 则将 DataMemory 中取出的值放入寄存器
 *
 *   - readData : 从存储单元读取出的数据
 *   - aluResult : ALU 的计算结果
 *   - imm : 立即数
 *   - pcPlus4 : PC+4
 * <p>
 * [[output]]
 *   - out : 根据选择信号和输入的数据, 得出结果用于存入寄存器
 */
class ResSelectUnit extends Module {
  val io = IO(new Bundle {
    /* input */
    val isJump = Input(Bool())
    val immALUToReg = Input(Bool())
    val memRead = Input(Bool())
    val readData = Input(UInt(XLEN.W))
    val aluResult = Input(UInt(XLEN.W))
    val imm = Input(UInt(XLEN.W))
    val pcPlus4 = Input(UInt(XLEN.W))
    /* output */
    val out = Output(UInt(XLEN.W))
  })
  io.out := 0.U
}
