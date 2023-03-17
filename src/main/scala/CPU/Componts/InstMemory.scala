package CPU.Componts

import chisel3._
import chisel3.util.experimental.loadMemoryFromFile
import firrtl.annotations.MemoryLoadFileType

import CPU._
import CPU.CPUConfig._

/**
 * <b>[[指令存储单元]]</b>
 * <p>
 * 存储待执行的指令, 根据 PC 依次取出进行执行,
 * 存储单元为 Vec(4, UInt(8.W))
 * RISC-V 默认为小端序,
 * 不允许非对齐数据访问(所有访问会对 4 字节对齐)
 * <p>
 * [[input]]
 *   - address : PC, 即取值地址, 来自 PCReg.out
 * <p>
 * [[output]]
 *   - inst : 输出对应地址的指令
 */
class InstMemory(hexFilePath: String = "") extends Module {
  val io = IO(new Bundle {
    /* input */
    val address = Input(UInt(XLEN.W))
    /* output */
    val inst = Output(UInt(INST_W.W))
  })

  val instMem = Mem(INST_MEMORY_SIZE, Vec(INST_BYTE, UInt(BYTE_W.W)))

  val address = io.address >> INST_MEMORY_OFFSET.U // 地址需要修正偏移

  // 小端序 : Vec(3) | Vec(2) | Vec(1) | Vec(0)
  io.inst := instMem.read(address).asUInt

  /**
     * load Hex 文件
     */
  if (!hexFilePath.isEmpty()) {
    loadMemoryFromFile(
      instMem,
      hexFilePath,
      MemoryLoadFileType.Hex
    )
  }

  // **************** print **************** //
  val needBinary = List(io.inst)
  val needDec = List()
  val needHex = List(io.address)
  val needBool = io.getElements.filter(data => data.isInstanceOf[Bool]).toList

  if (DebugControl.InstMemoryIOPrint) {
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

object InstMemory {
  def main(args: Array[String]) = {
    print(getVerilogString(new InstMemory()))

    print("\n[Success]\n")
  }
}
