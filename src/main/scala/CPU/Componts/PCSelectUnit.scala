package CPU.Componts

import chisel3._
import CPU.CPUConfig._

/**
 * <b>[[PC地址选择单元]]</b>
 * <p>
 * 用于根据输入的控制信号来选择对应的 PC 进行输出
 * <p>
 * [[input]]
 *   - pcPlus4 : PC+4
 *   - pcPlusImm : PC+immediate
 *
 *   - isJALR : 为 true 则 next_pc 来源于 ALU, 1 for jalr
 *   - isBType : 是否为 B-type 指令, 1 for B-type
 *   - isJump : 是否为 jump 指令, 1 for jal/jalr
 *   - isTrue : 对于 B-type 指令, ALU 计算的结果是否满足跳转条件
 *               来源于 ALU.result[0]
 *
 *   - aluResult : ALU 的计算结果
 * <p>
 * [[output]]
 *   - nextPC : 下一个 PC
 */
class PCSelectUnit extends Module {
  val io = IO(new Bundle {
    /* input */
    val pcPlus4 = Input(UInt(XLEN.W))
    val pcPlusImm = Input(UInt(XLEN.W))

    val isJALR = Input(Bool())
    val isBType = Input(Bool())
    val isJump = Input(Bool())
    val isTrue = Input(Bool())

    val aluResult = Input(UInt(XLEN.W))
    /* output */
    val nextPC = Output(UInt(XLEN.W))
  })

  val nextPC = WireDefault(io.pcPlus4)

  when(io.isJALR === true.B) {
    nextPC := io.aluResult
  }.elsewhen(io.isJump || (io.isBType && io.isTrue)) {
    nextPC := io.pcPlusImm
  }

  io.nextPC := nextPC
}
