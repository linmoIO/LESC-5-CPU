package CPU.Componts

import chisel3._
import CPU._
import CPU.CPUConfig._
import chisel3.util.experimental.loadMemoryFromFile
import firrtl.annotations.MemoryLoadFileType

/**
 * <b>[[指令存储单元]]</b>
 * <p>
 * 存储待执行的指令, 根据 PC 依次取出进行执行
 * 大小端问题 ?
 * <p>
 * [[input]]
 *   - address : PC, 即取值地址, 来自 PCReg.out
 * <p>
 * [[output]]
 *   - inst : 输出对应地址的指令
 */
class InstMemory(hexFile: String = "") extends Module {
  val io = IO(new Bundle {
    /* input */
    val address = Input(UInt(XLEN.W))
    /* output */
    val inst = Output(UInt(INST_W.W))
  })

  val instMem = SyncReadMem(INST_MEMORY_SIZE, Vec(INST_BYTE, UInt(BYTE_W.W)))

  val address = io.address >> INST_MEMORY_OFFSET.U // 地址需要修正偏移

  // 小端序 : Vec(3) | Vec(2) | Vec(1) | Vec(0)
  io.inst := instMem.read(address).asUInt

  /**
     * load Hex 文件
     */
  if (!hexFile.isEmpty()) {
    loadMemoryFromFile(
      instMem,
      // ..../.../hexFile/hexFile_0.hex
      HEX_INST_DIR.appendedAll(s"/${hexFile}/${hexFile}.hex"),
      MemoryLoadFileType.Hex
    )
  }

  // **************** print **************** //
  if (DebugConfig.InstMemoryIOPrint) {
    CPUPrintf.printfForIO(io, "Hex")
  }

}

object InstMemory {
  def main(args: Array[String]) = {
    print(getVerilogString(new InstMemory()))

    print("\n[Success]\n")
  }
}
