package CPU.Componts

import chisel3._
import CPU.CPUConfig._

/**
 * <b>[[ALU 控制单元]]</b>
 * <p>
 * 根据 ControlUnit 的控制信号、funct3 和 funct7 生成对应的 ALU 的控制信号
 * 指挥 ALU 的执行
 * <p>
 * [[input]]
 *   - isBType : 当前指令是否为 B-type 指令
 *   - isIType : 当前指令是否为 I-type 指令
 *   - isRType : 当前指令是否为 R-type 指令
 *   - isWord : 是否为 '*W' 型指令, 即按 word 处理
 *   - funct3 : 指令中的 3 位方法码, 来自于指令的 [14-12]
 *   - funct7 : 指令中的 7 位方法码, 来自于指令的 [31-25]
 * <p>
 * [[output]]
 *   - aluOperation : 根据输入生成的 6 位控制码
 *                    若为 R-type/B-type, 组成为 funct3|inst[30]|isWord|isBType
 *                    若为 I-type, 则为对应的 R-type 的控制码
 *                    若均不是, 则生成默认控制码(将执行 ADD 操作)
 */
class ALUControlUnit extends Module {
  val io = IO(new Bundle {
    /* input */
    val isBType = Input(Bool())
    val isIType = Input(Bool())
    val isRType = Input(Bool())
    val isWord = Input(Bool())
    val funct3 = Input(UInt(3.W))
    val funct7 = Input(UInt(7.W))
    /* output */
    val aluOperation = Output(UInt(ALU_OPERATION_W.W))
  })
  io.aluOperation := 0.U
}
