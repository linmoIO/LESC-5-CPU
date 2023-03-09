package CPU.Componts

import chisel3._
import CPU.CPUConfig._
import CPU._

/**
 * <b>[[寄存器单元]]</b>
 * <p>
 * 由 32 个寄存器形成的寄存器单元, 执行 读/写寄存器 的操作
 * <p>
 * [[input]]
 *   - rs1 : rs1 寄存器, 根据指令的 [19-15] 得到
 *   - rs2 : rs2 寄存器, 根据指令的 [24-20] 得到
 *   - rd : rd 寄存器, 根据指令的 [11-7] 得到
 *   - writeEnable : 写使能, 来自于 ControlUnit.ifWriteToReg
 *   - writeData : 要写入的数据, 来自于 ResSelectUnit.out
 * <p>
 * [[output]]
 *   - readDataRs1 : 从 rs1 中读出的数据
 *   - readDataRs2 : 从 rs2 中读出的数据
 */
class RegUnit extends Module {
  val io = IO(new Bundle {
    /* input */
    val rs1 = Input(UInt(5.W))
    val rs2 = Input(UInt(5.W))
    val rd = Input(UInt(5.W))
    val writeEnable = Input(Bool())
    val writeData = Input(UInt(XLEN.W))
    /* output */
    val readDataRs1 = Output(UInt(XLEN.W))
    val readDataRs2 = Output(UInt(XLEN.W))
  })

  // 32 个寄存器, 64 位
  val regGroup = Reg(Vec(REGISTE_NUM, UInt(XLEN.W)))

  // 考虑写时读的问题, 读写转发
  io.readDataRs1 := Mux(
    (io.writeEnable && (io.rs1 === io.rd)),
    io.writeData,
    regGroup(io.rs1)
  )
  io.readDataRs2 := Mux(
    (io.writeEnable && (io.rs2 === io.rd)),
    io.writeData,
    regGroup(io.rs2)
  )

  when(io.writeEnable === true.B) {
    regGroup(io.rd) := io.writeData
  }

  // **************** print **************** //
  if (DebugConfig.RegUnitIOPrint) {
    CPUPrintf.printfForIO(io, "")
  }
}
