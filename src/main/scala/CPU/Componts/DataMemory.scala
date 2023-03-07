package CPU.Componts

import chisel3._
import CPU.CPUConfig._

/**
 * <b>[[数据存储单元]]</b>
 * <p>
 * 存储数据, 根据指令进行 读/写
 * <p>
 * [[input]]
 *   - valid : 若 valid = true, 表示需要 读/写
 *   - memRead : 是否需要读
 *   - memWrite : 是否需要写
 *   - address : 读/写 的地址
 *   - writeData : 待写入的数据
 *   - bitType : 是否要按照 16/32/64位 进行 读/写, 为指令的 [13-12]
 *   - isUnsigned : 做 零扩展/符号扩展, 为指令的 [14]
 * <p>
 * [[output]]
 *   - readData : 读出的数据
 */
class DataMemory extends Module {
  val io = IO(new Bundle {
    /* input */
    val valid = Input(Bool())
    val memRead = Input(Bool())
    val memWrite = Input(Bool())
    val address = Input(UInt(XLEN.W))
    val writeData = Input(UInt(XLEN.W))
    val bitType = Input(UInt(2.W))
    val isUnsigned = Input(Bool())
    /* output */
    val readData = Output(UInt(XLEN.W))
  })
  io.readData := 0.U
}
