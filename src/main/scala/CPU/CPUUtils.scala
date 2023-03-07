package CPU

import chisel3._
import CPUConfig._
import chisel3.experimental.IO

/**
 * <b>[[加法器]]</b>
 * <p>
 * 将 x 和 y 相加后输出
 * <p>
 * [[input]]
 *   - x
 *   - y
 * <p>
 * [[output]]
 *   - out : x + y
 */
class Adder extends Module {
  val io = IO(new Bundle {
    /* input */
    val x = Input(UInt(XLEN.W))
    val y = Input(UInt(XLEN.W))
    /* output */
    val out = Output(UInt(XLEN.W))
  })
  io.out := io.x + io.y
}

object CPUPrintf {
  def printfForIO(io: Bundle, control: String = "") = {
    printf("\n")
    io.getElements.foreach(data => printfForIOArg(data, control))
    printf("\n")
  }

  def printfForIOArg(arg: Data, control: String) = {
    printf(cf"${arg.toString().trim()} : ")
    if (arg.isInstanceOf[Bool]) {
      printf(cf"${arg}")
    } else if (arg.isInstanceOf[UInt] || arg.isInstanceOf[SInt]) {
      if (control.contains("Hex")) {
        if (arg.isInstanceOf[UInt])
          printf(cf"0x${Hexadecimal(arg.asInstanceOf[UInt])}")
        else if (arg.isInstanceOf[SInt])
          printf(cf"0x${Hexadecimal(arg.asInstanceOf[SInt])}")
      } else {
        if (arg.isInstanceOf[UInt])
          printf(cf"${Binary(arg.asInstanceOf[UInt])}")
        else if (arg.isInstanceOf[SInt])
          printf(cf"${Binary(arg.asInstanceOf[SInt])}")
      }
    } else {
      printf(cf"${arg}")
    }

    printf(" |\t")
  }

}

object CPUUtils {}
