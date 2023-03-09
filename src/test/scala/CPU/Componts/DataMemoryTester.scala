package CPU.Componts

import chisel3._
import chiseltest._
import chisel3.util._

import CPU.CPUConfig._
import CPU.CPUConfig._
import CPU.Endianness
import CPU.CPUUtils

import scala.collection.mutable._
import scala.io.Source

import org.scalatest.flatspec.AnyFlatSpec
import chiseltest.ChiselScalatestTester
import CPU.CPUPrintf

trait TestFuncRandomReadWrite {
// 生成MEM_DATA_SIZE条随机数据进行测试
  val data_list =
    Seq.fill(DATA_MEMORY_SIZE)(
      scala.util.Random.nextInt().toLong & 0x7fffffffffL
    )

  def testFn(dut: DataMemory): Unit = {
    print(s"=============== 初始化状态 ===============\n")
    // 初始化状态
    dut.clock.setTimeout(0)
    dut.io.memRead.poke(false.B)
    dut.io.memWrite.poke(false.B)
    dut.io.bitType.poke("b11".U)
    dut.io.isUnsigned.poke(true.B)
    dut.io.writeData.poke(0.U(XLEN.W))
    dut.io.address.poke(0.U(XLEN.W))
    // 非LS指令
    for (i <- 0 to DATA_MEMORY_SIZE - 1) {
      dut.io.address.poke((i * DATA_BYTE).U)
      dut.clock.step(1)
      dut.io.readData.expect(0.U, s"非LS指令 ${i}")
      // dut.io.readData.expect((i * DATA_BYTE).U, s"非LS指令 ${i}")
    }

    print(s"=============== SD 指令 ===============\n")
    dut.io.memWrite.poke(true.B)
    // dut.io.memRead.poke(true.B)
    for (i <- 0 to DATA_MEMORY_SIZE - 1) {
      dut.io.writeData.poke(data_list(i))
      print(s"写入 ${i} 的数据为 : 0x${data_list(i).toHexString}\n")
      dut.io.address.poke((i * DATA_BYTE).U) // 作为地址，应该左移三位，即乘以8
      dut.clock.step(1) // 时钟往前, 将数据写入
      dut.io.readData.expect(0.U, s"SW指令 ${i}")
      // dut.io.readData.expect(data_list(i).U, s"测同时写入和读出 ${i}")
      // dut.io.readData.expect((i * DATA_BYTE).U, s"SD指令 ${i}")
    }

    print(s"=============== LD 指令 ===============\n")
    dut.io.memWrite.poke(false.B)
    dut.io.memRead.poke(true.B)
    for (i <- 0 to DATA_MEMORY_SIZE - 1) {
      dut.io.writeData.poke(0.U)
      dut.io.address.poke((i * DATA_BYTE).U) // 作为地址，应该左移三位，即乘以8
      // print(s"${(i * DATA_BYTE).U}\n")
      dut.clock.step(1) // 时钟往前, 将数据读出
      dut.io.readData.expect(data_list(i).U, s"LD指令 ${i}")
    }

    print(s"=============== 测试 readData 的无 memRead 输出 0.U ===============\n")
    // 测试 readData 的无 memRead 输出 0.U
    dut.io.address.poke(0)
    dut.io.memRead.poke(false.B)
    dut.clock.step(10) // 时钟往前, 将数据读出

    // SH清零低16比特
    print(s"=============== SH清零低16比特 ===============\n")
    dut.io.memWrite.poke(true.B)
    dut.io.memRead.poke(false.B)
    dut.io.bitType.poke("b01".U)
    for (i <- 0 to DATA_MEMORY_SIZE - 1) {
      dut.io.writeData.poke(0)
      dut.io.address.poke((i * DATA_BYTE).U) // 作为地址，应该左移三位，即乘以8
      dut.clock.step(1) // 时钟往前, 将数据读出
      // dut.io.readData.expect((i * DATA_BYTE).U, s"SH清零低16比特 ${i}")
    }

    // LHU指令读低16比特
    print(s"=============== LHU指令读低16比特 ===============\n")
    dut.io.memWrite.poke(false.B)
    dut.io.memRead.poke(true.B)
    dut.io.bitType.poke("b01".U)
    for (i <- 0 to DATA_MEMORY_SIZE - 1) {
      dut.io.writeData.poke(0.U)
      dut.io.address.poke((i * DATA_BYTE).U) // 作为地址，应该左移三位，即乘以8
      dut.clock.step(1) // 时钟往前, 将数据读出
      dut.io.readData.expect(0.U, s"LHU指令读低16比特 ${i}")
    }
    dut.io.isUnsigned.poke(false.B)

    // LH指令读低16比特
    print(s"=============== LH指令读低16比特 ===============\n")
    for (i <- 0 to DATA_MEMORY_SIZE - 1) {
      dut.io.writeData.poke(0.U)
      dut.io.address.poke((i * DATA_BYTE).U) // 作为地址，应该左移三位，即乘以8
      dut.clock.step(1) // 时钟往前, 将数据读出
      dut.io.readData.expect(0.U, s"LH指令读低16比特 ${i}")
    }
    dut.io.isUnsigned.poke(true.B)

    // SB存储低8比特
    print(s"=============== SB存储低8比特 ===============\n")
    dut.io.memWrite.poke(true.B)
    dut.io.memRead.poke(false.B)
    dut.io.bitType.poke("b00".U)
    for (i <- 0 to DATA_MEMORY_SIZE - 1) {
      dut.io.writeData.poke(data_list(i))
      dut.io.address.poke((i * DATA_BYTE).U) // 作为地址，应该左移三位，即乘以8
      dut.clock.step(1)
      // dut.io.readData.expect((i * DATA_BYTE).U, s"SB存储低8比特 ${i}")
    }

    // 清空 (15,8) 位, 避免后续 LW 出错
    for (i <- 0 to DATA_MEMORY_SIZE - 1) {
      data_list(i) = data_list(i) & 0x7fffff00ffL
    }

    // LBU指令读低8比特
    print(s"=============== LBU指令读低8比特 ===============\n")
    dut.io.memWrite.poke(false.B)
    dut.io.memRead.poke(true.B)
    for (i <- 0 to DATA_MEMORY_SIZE - 1) {
      dut.io.writeData.poke(0.U)
      dut.io.address.poke((i * DATA_BYTE).U) // 作为地址，应该左移三位，即乘以8
      dut.clock.step(1)
      dut.io.readData
        .expect((data_list(i).toLong & 0x00000000ffL).U, s"LBU指令读低8比特 ${i}")
    }

    // LB指令读低8比特
    print(s"=============== LB指令读低8比特 ===============\n")
    dut.io.isUnsigned.poke(false.B)
    for (i <- 0 to DATA_MEMORY_SIZE - 1) {
      dut.io.writeData.poke(0.U)
      dut.io.address.poke((i * DATA_BYTE).U) // 作为地址，应该左移三位，即乘以8
      dut.clock.step(1)
      if ((data_list(i).toLong & 0x0000000080L) == 0) {
        dut.io.readData
          .expect(
            (data_list(i).toLong & 0x00000000ffL).U,
            s"LB指令读低8比特 if(0) ${i}"
          )
      } else {
        dut.io.readData
          .expect(
            s"hffffffff${((data_list(i).toLong & 0x00000000ffL) | 0xffffff00L).toHexString}".U,
            s"LB指令读低8比特 if not(0) ${i}"
          )
      }
    }
    dut.io.isUnsigned.poke(true.B)

    // LW指令读低32比特
    print(s"=============== LW指令读低32比特 ===============\n")
    dut.io.bitType.poke("b10".U)
    dut.io.isUnsigned.poke(false.B)
    for (i <- 0 to DATA_MEMORY_SIZE - 1) {
      dut.io.writeData.poke(0.U)
      dut.io.address.poke((i * DATA_BYTE).U) // 作为地址，应该左移三位，即乘以8
      dut.clock.step(1)
      if ((data_list(i).toLong & 0x0080000000L) == 0) {
        dut.io.readData
          .expect(
            (data_list(i).toLong & 0x00ffffffffL).U,
            s"LW指令读低32比特 if(0) ${i}"
          )
      } else {
        dut.io.readData
          .expect(
            s"hffffffff${(data_list(i).toLong & 0x00ffffffffL).toHexString}".U,
            s"LW指令读低32比特 if not(0) ${i}"
          )
      }
    }
    dut.io.isUnsigned.poke(true.B)

    // SW清零低32比特
    print(s"=============== SW清零低32比特 ===============\n")
    dut.io.memWrite.poke(true.B)
    dut.io.memRead.poke(false.B)
    dut.io.bitType.poke("b10".U)
    for (i <- 0 to DATA_MEMORY_SIZE - 1) {
      dut.io.writeData.poke(0)
      dut.io.address.poke((i * DATA_BYTE).U) // 作为地址，应该左移三位，即乘以8
      dut.clock.step(1) // 时钟往前, 将数据读出
    }

    // LWU指令读低32比特
    print(s"=============== LWU指令读低32比特 ===============\n")
    dut.io.memWrite.poke(false.B)
    dut.io.memRead.poke(true.B)
    dut.io.bitType.poke("b10".U)
    for (i <- 0 to DATA_MEMORY_SIZE - 1) {
      dut.io.writeData.poke(0.U)
      dut.io.address.poke((i * DATA_BYTE).U) // 作为地址，应该左移三位，即乘以8
      dut.clock.step(1) // 时钟往前, 将数据读出
      dut.io.readData.expect(0.U, s"LWU指令读低32比特 ${i}")
    }
    dut.io.isUnsigned.poke(false.B)
  }
}

trait TestFuncLoadFile {
  private var data_list = ArrayBuffer[String]()

  def loadHexFile(filename: String) = {
    val dir = System
      .getProperty("user.dir")
      .appendedAll(s"/${HEX_DATA_DIR}/${filename}")
    val filePath = s"${dir}/${filename}.hex"
    val sourceFile = Source.fromFile(filePath)
    data_list.appendAll(sourceFile.getLines())
    sourceFile.close()

    // 生成分离的 Hex
    CPUUtils.splitHexFile(dir, filename, DATA_BYTE)
  }
  def testDATA(dut: DataMemory) = {
    // 依次读取所有的数据，与data_list进行匹配
    for (i <- 0 until data_list.size) {
      dut.io.memRead.poke(true.B)
      dut.io.memWrite.poke(false.B)
      dut.io.writeData.poke(0.U)
      dut.io.bitType.poke("b11".U)
      dut.io.isUnsigned.poke(true.B)

      dut.io.address.poke((i * DATA_BYTE).U) // 作为地址，应该左移两位，即乘以4
      dut.clock.step()
      dut.io.readData.expect(
        s"h${data_list(i)}".U,
        s"[ERROR]${i} : ${dut.io.readData.peekInt().toInt.toHexString} should be ${data_list(i)}"
      )
    }
  }
}

class DataMemoryTester
    extends AnyFlatSpec
    with ChiselScalatestTester
    with TestFuncRandomReadWrite
    with TestFuncLoadFile {
  "DataMem Random" should "pass" in {
    // 随机读写指令测试
    test(new DataMemory()) { dut => testFn(dut) }
  }
  "DataMem Inst Test" should "pass" in {
    // 已有文件测试
    // 先读取文件, 再测试
    val instFile = "dataTest"
    loadHexFile(instFile)
    test(new DataMemory(instFile)) { dut =>
      testDATA(dut)
    }
  }
}
