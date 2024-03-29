package CPU.Componts

import chisel3._
import chiseltest._
import chisel3.util._
import org.scalatest.flatspec.AnyFlatSpec

import java.io.PrintWriter
import java.io.File

import CPU.CPUConfig._
import CPU.CPUConfig._
import CPU.Endianness
import CPU.CPUUtils
import scala.collection.mutable._
import scala.io.Source

trait TestFunctionInstMemoryRandom {
  val inst_test_size = math.min(INST_MEMORY_SIZE, 1024)

  // 生成MEM_INST_SIZE条随机指令进行测试
  val inst_list =
    Seq.fill(inst_test_size)(
      scala.util.Random.nextInt().toLong & 0x00ffffffffL
    )

  def long2InstHex(num: Long) = {
    var res = num.toHexString
    val need = INST_BYTE * 2 - res.length()
    for (i <- 0 until need) {
      res = "0".appendedAll(res)
    }
    res
  }

  // 为随机指令生成hex文本文件
  def genMemInstHex(hexPath: String): Unit = {
    val pairDirName = CPUUtils.getDirName(hexPath)
    val dir = pairDirName._1
    val hexName = pairDirName._2

    // 生成源hex
    val filePath = s"${dir}/${hexName}.hex"
    val memFile = new File(filePath)
    memFile.createNewFile()
    val memPrintWriter = new PrintWriter(memFile)
    for (i <- 0 to inst_test_size - 1) {
      memPrintWriter.println(long2InstHex(inst_list(i)))
    }
    memPrintWriter.close()

    // 生成 split hex
    CPUUtils.splitHexFile(dir, hexName, INST_BYTE)
  }

  def testFn(dut: InstMemory): Unit = {
    // 依次读取所有的指令，与inst_list进行匹配
    for (i <- 0 to inst_test_size - 1) {
      dut.io.address.poke((i * INST_BYTE).U) // 作为地址，应该左移两位，即乘以4
      dut.clock.step()
      dut.io.inst.expect(
        inst_list(i).U,
        s"[ERROR]${i} : ${dut.io.inst.peekInt().toInt.toHexString} should be ${inst_list(i).toHexString}"
      )
    }
  }

}

trait TestFunctionInstMemoryInst {
  private var inst_list = ArrayBuffer[String]()

  def loadHexFile(filePath: String) = {
    val pairDirName = CPUUtils.getDirName(filePath)
    val dir = pairDirName._1
    val hexName = pairDirName._2

    val sourceFile = Source.fromFile(filePath)
    inst_list.appendAll(sourceFile.getLines())
    sourceFile.close()

    // 生成分离的 Hex
    CPUUtils.splitHexFile(dir, hexName, INST_BYTE)
  }
  def testInst(dut: InstMemory) = {
    // 依次读取所有的指令，与inst_list进行匹配
    for (i <- 0 until inst_list.size) {
      dut.io.address.poke((i * INST_BYTE).U) // 作为地址，应该左移两位，即乘以4
      dut.clock.step()
      dut.io.inst.expect(
        s"h${inst_list(i)}".U,
        s"[ERROR]${i} : ${dut.io.inst.peekInt().toInt.toHexString} should be ${inst_list(i)}"
      )
    }
  }
}

class InstMemoryTester
    extends AnyFlatSpec
    with ChiselScalatestTester
    with TestFunctionInstMemoryRandom
    with TestFunctionInstMemoryInst {
  "InstMemory Random Test" should "pass" in {
    // 随机生成测试
    // 先生成随机hex文件，再进行测试
    val randomHexFile = System
      .getProperty("user.dir")
      .appendedAll("/src/test/hex/random/inst/random.hex")
    genMemInstHex(randomHexFile)
    test(new InstMemory(randomHexFile)) { dut =>
      testFn(dut)
    }
  }
  "InstMemory Inst Test" should "pass" in {
    // 已有文件测试
    // 先读取文件, 再测试
    val fibonacciHexFile = System
      .getProperty("user.dir")
      .appendedAll("/src/test/hex/fibonacci/inst/fibonacci.hex")
    loadHexFile(fibonacciHexFile)
    test(new InstMemory(fibonacciHexFile)) { dut =>
      testInst(dut)
    }
  }
}
