package CPU.Componts

import chisel3._
import CPU.CPUConfig._
import CPU._

/**
 * <b>[[PC 寄存器]]</b>
 * <p>
 * PC 寄存器
 * <p>
 * [[input]]
 *   - in : 下一个 PC, 来自 PCSelectUnit.nextPC
 * <p>
 * [[output]]
 *   - out : 输出当前 PC
 */
class PCReg extends Module {
  val io = IO(new Bundle {
    /* input */
    val in = Input(UInt(XLEN.W))
    /* output */
    val out = Output(UInt(XLEN.W))
  })

  val pcReg = RegInit(UInt(XLEN.W), START_ADDRESS.U)

  pcReg := io.in
  io.out := pcReg

  // **************** print **************** //
  if (DebugConfig.PCRegIOPrint)
    CPUPrintf.printfForIO(io, "Hex")
}
