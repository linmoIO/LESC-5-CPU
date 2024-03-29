package CPU.Componts

import chisel3._
import chisel3.util._

import CPU.CPUConfig._
import CPU._

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
 *                    若为 R-type, 组成为 funct3|inst[30]|isWord|isBType
 *                    若为 B-type, 组成为 funct3|0|isWord|isBType
 *                    若为 I-type, 则为对应的 R-type 的控制码
 *                        对于 SRLI / SRAI / SRLIW / SRAIW, 为 funct3|inst[30]|isWord|isBType
 *                        对于其他的, 为 funct3|0|isWord|isBType
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

  // funct3 | inst[30]
  val combine = WireDefault(ALUOpWithCode.getBCodeDefault().U(4.W))

  when(io.isRType === true.B) {
    combine := Cat(io.funct3, io.funct7(5))
  }.elsewhen(io.isBType === true.B) {
    combine := Cat(io.funct3, 0.U)
  }.elsewhen(io.isIType === true.B) {
    when(io.funct3 === "b101".U) { // SRLI / SRAI / SRLIW / SRAIW
      combine := Cat(io.funct3, io.funct7(5))
    }.otherwise {
      combine := Cat(io.funct3, 0.U)
    }
  }

  io.aluOperation := Cat(combine, io.isWord, io.isBType)

  // **************** print **************** //
  val needBinary = List(io.funct3, io.funct7, io.aluOperation)
  val needDec = List()
  val needHex = List()
  val needBool = io.getElements.filter(data => data.isInstanceOf[Bool]).toList

  if (DebugControl.ALUControlUnitIOPrint) {
    CPUPrintf.printfIO(
      "INFO",
      this,
      io.getElements.toList,
      needBinary,
      needDec,
      needHex,
      needBool
    )
  }

}
