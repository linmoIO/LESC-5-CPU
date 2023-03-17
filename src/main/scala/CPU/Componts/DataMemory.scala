package CPU.Componts

import chisel3._
import chisel3.util._
import scala.collection.mutable.ArrayBuffer

import chisel3.util.experimental.loadMemoryFromFile
import firrtl.annotations.MemoryLoadFileType
import dataclass.data

import CPU._
import CPU.CPUConfig._
import CPU.CPUUtils._

/**
 * <b>[[数据存储单元]]</b>
 * <p>
 * 存储数据, 根据指令进行 读/写,
 * 存储单元为 Vec(8, UInt(8.W))
 * RISC-V 默认是小端序,
 * 采用"同步写, 异步读"的形式,
 * 不允许非对齐数据访问(即所有访问都要对2的次方对齐)
 * <p>
 * [[input]]
 *   - memRead : 是否需要读
 *   - memWrite : 是否需要写
 *   - address : 读/写 的地址 (按字节)
 *   - writeData : 待写入的数据
 *   - bitType : 是否要按照 16/32/64位 进行 读/写, 为指令的 [13-12]
 *               00 : 字节, 01 : 半字, 10 : 字, 11 : 双字
 *   - isUnsigned : 做 零扩展/符号扩展, 为指令的 [14]
 * <p>
 * [[output]]
 *   - readData : 读出的数据
 *                若 memRead = false, 则读出 0.U
 */
class DataMemory(hexFilePath: String = "") extends Module {
  val io = IO(new Bundle {
    /* input */
    val memRead = Input(Bool())
    val memWrite = Input(Bool())
    val address = Input(UInt(XLEN.W))
    val writeData = Input(UInt(XLEN.W))
    val bitType = Input(UInt(2.W))
    val isUnsigned = Input(Bool())
    /* output */
    val readData = Output(UInt(XLEN.W))
  })

  // 数据内存
  val dataMem = Mem(DATA_MEMORY_SIZE, Vec(DATA_BYTE, UInt(BYTE_W.W)))

  // 地址修正偏移: 不允许非对齐地址访问
  val address = io.address >> DATA_MEMORY_OFFSET
  val index = io.address & 0x7.U

  /**
    * 读操作
    */

  // 小端序 : Vec(7) | ... | Vec(1) | Vec(0)
  val readDataRaw = dataMem.read(address).asUInt

  // 截出 index 起始对应的数据 (注意小端序, 需要逆向)
  val readDataIntercept = WireDefault(0.U(XLEN.W))
  when(index === 0.U) {
    readDataIntercept := readDataRaw(XLEN - 1, 0)
  }
  for (i <- 1 until DATA_BYTE) {
    when(index === i.U) {
      readDataIntercept := Cat(
        0.U((BYTE_W * i).W),
        readDataRaw(XLEN - 1, BYTE_W * i)
      )
    }
  }

  // 对读数据进行 mask 和 扩展 处理
  val readDataMasked = WireInit(0.U(XLEN.W))
  when(io.memRead === true.B) {
    when(io.bitType === "b11".U) { // 无需处理
      readDataMasked := readDataIntercept
    }.otherwise {
      when(io.isUnsigned === true.B) { // 进行零扩展
        switch(io.bitType) {
          is("b00".U) { readDataMasked := unsignExtend8To64(readDataIntercept) }
          is("b01".U) {
            readDataMasked := unsignExtend16To64(readDataIntercept)
          }
          is("b10".U) {
            readDataMasked := unsignExtend32To64(readDataIntercept)
          }
        }
      }.otherwise { // 进行符号扩展
        switch(io.bitType) {
          is("b00".U) { readDataMasked := signExtend8To64(readDataIntercept) }
          is("b01".U) { readDataMasked := signExtend16To64(readDataIntercept) }
          is("b10".U) { readDataMasked := signExtend32To64(readDataIntercept) }
        }
      }
    }
  }

  // 输出读出的数据
  io.readData := readDataMasked

  /**
    * 写操作
    */

  // 小端序 : Vec(7) | ... | Vec(1) | Vec(0)
  val writeData = WireDefault(VecInit(Seq.fill(DATA_BYTE)(0.U(BYTE_W.W))))

  /* 生成 mask, 默认为无法写入 */
  val mask = WireDefault(VecInit(Seq.fill(DATA_BYTE)(false.B)))

  // true 表示写入
  def genMaskVec(index: Int, maskUpOri: Int) = {
    val maskUp =
      if (maskUpOri + index > DATA_BYTE) DATA_BYTE
      else maskUpOri + index
    for (i <- 0 until index) { mask(i) := false.B }
    for (i <- index until maskUp) { mask(i) := true.B }
    for (i <- maskUp until DATA_BYTE) { mask(i) := false.B }
  }

  def getPair(i: Int) = (BYTE_W * (i + 1) - 1, BYTE_W * i)

  // 对 index 开始的位置进行修正写入
  for (iCase <- 0 until DATA_BYTE) { // 0 until 8
    when(index === iCase.U) {
      for (i <- 0 until iCase) { // 0 until index
        writeData(i) := 0.U
      }
      for (i <- iCase until DATA_BYTE) { // index until 8
        writeData(i) := io.writeData(
          getPair(i - iCase)._1,
          getPair(i - iCase)._2
        )
      }
      switch(io.bitType) {
        is("b00".U) { // 字节
          genMaskVec(iCase, BYTE_W / BYTE_W)
        }
        is("b01".U) { // 半字
          genMaskVec(iCase, HALFWORD_W / BYTE_W)
        }
        is("b10".U) { // 字
          genMaskVec(iCase, WORD_W / BYTE_W)
        }
        is("b11".U) { // 双字
          genMaskVec(iCase, DOUBLEWORD_W / BYTE_W)
        }
      }
    }
  }

  // 写入
  when(io.memWrite === true.B) {
    dataMem.write(address, writeData, mask)
  }

  /**
   * load Hex 文件
   */
  if (!hexFilePath.isEmpty()) {
    loadMemoryFromFile(
      dataMem,
      hexFilePath,
      MemoryLoadFileType.Hex
    )
  }

  // **************** print **************** //
  val needBinary = List(io.bitType)
  val needDec = List(io.writeData, io.readData)
  val needHex = List(io.address)
  val needBool = io.getElements.filter(data => data.isInstanceOf[Bool]).toList

  if (DebugControl.DataMemoryIOPrint) {
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

object DataMemory {
  def main(args: Array[String]) = {
    print(getVerilogString(new DataMemory()))

    print("\n[Success]\n")
  }
}

// (SyncReadMem 版本)
// 以下是不采用 Mem 里自带的 mask 的解决方案

// /**
//     * 写操作要用 2 个周期完成 (注意写入数据要先读出数据)
//     * 读操作用 1 个周期完成
//     * 进行读写转发操作, 解决写时读问题
//     */

// // 将上次数据存储
// val lastMemRead = RegNext(io.memRead, false.B)
// val lastMemWrite = RegNext(io.memWrite, false.B)
// val lastAddress = RegNext(io.address, 0.U(XLEN.W))
// val lastWriteData = RegNext(io.writeData, 0.U(XLEN.W))
// val lastBitType = RegNext(io.bitType, "b11".U(2.W))
// val lastIsUnsigned = RegNext(io.isUnsigned, true.B)

// val readDataDealed = WireDefault(0.U(XLEN.W)) // out (处理过的数据)
// val readDataFromMem = dataMem.read(io.address) // 注意, 此处的数据要到下一个时钟周期才能读出

// // 此处解决写时读
// val readDataRaw =
//   Mux(io.address === lastAddress, readDataDealed, readDataFromMem)

// // 对写数据进行处理
// when(lastMemWrite === true.B) { // 如果需要写入
//   switch(lastBitType) {
//     is("b00".U) { // 字节
//       readDataDealed := Cat(
//         readDataFromMem(XLEN, BYTE_W), // 63, 8
//         lastWriteData(BYTE_W - 1, 0) // 7, 0
//       )
//     }
//     is("b01".U) { // 半字
//       readDataDealed := Cat(
//         readDataFromMem(XLEN, HALFWORD_W), // 63, 16
//         lastWriteData(HALFWORD_W - 1, 0) // 15, 0
//       )
//     }
//     is("b10".U) { // 字
//       readDataDealed := Cat(
//         readDataFromMem(XLEN, WORD_W), // 63, 32
//         lastWriteData(WORD_W - 1, 0) // 31, 0
//       )
//     }
//     is("b11".U) { // 双字
//       readDataDealed := lastWriteData(DOUBLEWORD_W - 1, 0) // 63, 0
//     }
//   }
//   // 将数据写入
//   dataMem.write(lastAddress, readDataDealed)
// }.otherwise { // 无需写入
//   readDataDealed := readDataFromMem
// }

// // 对读数据进行处理
// val readDataMasked = WireInit(0.U(XLEN.W))
// when(lastMemRead === true.B) {
//   when(lastIsUnsigned === true.B) { // 进行零扩展
//     switch(lastBitType) {
//       is("b00".U) { readDataMasked := unsignExtend8To64(readDataDealed) }
//       is("b01".U) { readDataMasked := unsignExtend16To64(readDataDealed) }
//       is("b10".U) { readDataMasked := unsignExtend32To64(readDataDealed) }
//     }
//   }.otherwise { // 进行符号扩展
//     switch(lastBitType) {
//       is("b00".U) { readDataMasked := signExtend8To64(readDataDealed) }
//       is("b01".U) { readDataMasked := signExtend16To64(readDataDealed) }
//       is("b10".U) { readDataMasked := signExtend32To64(readDataDealed) }
//     }
//   }
// }

// // 将数据读出
// val oldReadData = RegInit(0.U(XLEN.W))
// val readData = WireInit(0.U(XLEN.W))
// when(lastMemRead === true.B) {
//   oldReadData := readDataMasked
//   readData := readDataMasked
// }.otherwise {
//   oldReadData := oldReadData
//   readData := oldReadData
// }

// io.readData := readData
