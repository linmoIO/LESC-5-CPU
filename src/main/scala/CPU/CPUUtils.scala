package CPU

import chisel3._
import chisel3.util._
import chisel3.experimental.IO
import firrtl.FirrtlProtos.Firrtl.Statement.Memory

import java.io.PrintWriter
import java.io.File
import java.util.Scanner
import scala.collection.mutable._
import scala.io.Source

import CPUConfig._

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

/**
 * <b>[[CPU 打印器]]</b>
 * <p>
 * 用于打印调试信息
 */
object CPUPrintf {
  /* 通用 IO 打印函数 */

  // 根据设置打印整个 IO
  def printfIO(
      prefix: String = "INFO",
      module: Module,
      dataList: List[Data],
      needBinary: List[Data] = List(),
      needDec: List[Data] = List(),
      needHex: List[Data] = List(),
      needBool: List[Data] = List()
  ) = {
    printf(
      cf"[${prefix}] [${module.getClass().toString().split('.').last}] : \n"
    )
    for (data <- dataList.reverse) {
      val control = {
        if (needDec.contains(data))
          PrintKind.Dec
        else if (needHex.contains(data))
          PrintKind.Hex
        else if (needBinary.contains(data))
          PrintKind.Binary
        else if (needBool.contains(data))
          PrintKind.Bool
        else
          PrintKind.Default
      }
      printfIOArg(data, control)
    }
    printf(cf"\n\n")
  }

  // 根据设置打印单个 Port (换行)
  def printfIOArgln(
      data: Data,
      control: PrintKind.Value = PrintKind.Default
  ) = {
    printfIOArg(data, control)
  }

  // 根据设置打印单个 Port
  def printfIOArg(data: Data, control: PrintKind.Value = PrintKind.Default) = {
    val s = {
      if (control == PrintKind.Dec)
        cf"${Decimal(data.asUInt.asSInt)} (0x${Hexadecimal(data.asUInt)})"
      else if (control == PrintKind.Hex)
        cf"0x${Hexadecimal(data.asUInt)}"
      else if (control == PrintKind.Binary)
        cf"${Binary(data.asUInt)} (0x${Hexadecimal(data.asUInt)})"
      else if (control == PrintKind.Bool) // 目前暂不知如何优雅地打印 Bool 类型
        cf"${data.asUInt}"
      else
        cf"${data.asUInt}  (0x${Hexadecimal(data.asUInt)})"

    }
    printf(
      cf"\t${data.toString().split(":")(0).split('.').last}\t= ${s}\n"
    )
  }

  /* 自定义打印函数 */

}

object CPUUtils {
  /* 符号扩展函数集合 */

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

  // 将字符串前补 0 长度校准至 n
  def stringFixUpToN(s: String, n: Int) = {
    if (n > s.length())
      "0".repeat(n - s.length()) + s
    else s
  }

  def getDirName(filePath: String) = {
    val position = filePath.lastIndexOf('/')
    val dir = filePath.substring(0, position)
    val hexName = filePath.substring(position + 1).split(".hex")(0)
    (dir, hexName)
  }

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
        val res = stringFixUpToN(s, splitNum * 2)

        splitWriter.println(res.substring(byteIdx * 2, byteIdx * 2 + 2))
      }
      splitWriter.close()
    }
  }
}
