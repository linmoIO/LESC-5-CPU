package CPU

import chisel3._
import chisel3.util._
import CPUConfig._
import chisel3.experimental.IO
import firrtl.FirrtlProtos.Firrtl.Statement.Memory

import java.io.PrintWriter
import java.io.File
import java.util.Scanner
import scala.collection.mutable._
import scala.io.Source

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

object CPUUtils {

  /**
    * 符号扩展函数集合
    *
    * @param input
    * @param num
    * @param signed
    * @return
    */
  private def extendTo64(input: UInt, num: Int, signed: Boolean) = {
    val sign = if (signed) input(num - 1) else 0.U
    Cat(Fill(64 - num, sign), input(num - 1, 0))
  }

  def signExtend8To64(input: UInt) = extendTo64(input, 8, true)
  def signExtend16To64(input: UInt) = extendTo64(input, 16, true)
  def signExtend32To64(input: UInt) = extendTo64(input, 32, true)

  def unsignExtend8To64(input: UInt) = extendTo64(input, 8, false)
  def unsignExtend16To64(input: UInt) = extendTo64(input, 16, false)
  def unsignExtend32To64(input: UInt) = extendTo64(input, 32, false)

  /**
    * 分离 Hex 文件, 用于同步内存的读取
    *
    * @param dirPath
    * @param fileName
    * @param splitNum
    */
  def splitHexFile(dirPath: String, fileName: String, splitNum: Int) = {
    // 从源文件中读取数据
    val sourceFile = Source.fromFile(s"${dirPath}/${fileName}.hex")
    val sourceData = sourceFile.getLines().toList
    sourceFile.close()

    // 生成 split 文件
    for (idx <- 0 until splitNum) {
      // 小端序
      val byteIdx =
        if (CPU_ENDIAN == Endianness.Little_Endian) splitNum - idx - 1 else idx

      val splitFile = new File(s"${dirPath}/${fileName}_${idx}.hex")
      splitFile.createNewFile()
      val splitWriter = new PrintWriter(splitFile)
      for (s <- sourceData) {
        // 长度校准, 高位补0 (此处可用函数式编程)
        var res = s
        val need = splitNum * 2 - s.length()
        for (i <- 0 until need) {
          res = "0" + res
        }

        splitWriter.println(res.substring(byteIdx * 2, byteIdx * 2 + 2))
      }
      splitWriter.close()
    }
  }
}
