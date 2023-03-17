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
class PCReg(startAddress: Int = 0x0) extends Module {
  val io = IO(new Bundle {
    /* input */
    val in = Input(UInt(XLEN.W))
    /* output */
    val out = Output(UInt(XLEN.W))
  })

  val pcReg = RegInit(UInt(XLEN.W), startAddress.U)

  pcReg := io.in
  io.out := pcReg

  // **************** print **************** //
  val needBinary = List()
  val needDec = List()
  val needHex = List(io.in, io.out)
  val needBool = io.getElements.filter(data => data.isInstanceOf[Bool]).toList

  if (DebugControl.PCRegIOPrint) {
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
