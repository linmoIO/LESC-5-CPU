package CPU.PiplineComponts

import chisel3._

import CPU._
import CPU.CPUPrintf
import CPUConfig._

class IFIDStageRegsIO extends Bundle {
  val pc = UInt(XLEN.W) // PC
  val inst = UInt(INST_W.W) // 指令
}

class IFIDStageRegs extends GeneralStageRegs(new IFIDStageRegsIO) {

  // **************** print **************** //
  val needBinary = List(io.in.inst, io.out.inst)
  val needDec = List()
  val needHex = List(io.in.pc, io.out.pc)
  val needBool = List[Bool]()
    .appendedAll(io.getElements.filter(data => data.isInstanceOf[Bool]))
    .appendedAll(io.in.getElements.filter(data => data.isInstanceOf[Bool]))
    .appendedAll(io.out.getElements.filter(data => data.isInstanceOf[Bool]))

  val needDelete = List(io.in, io.out)
  val needAdd = List[Data]()
    .appendedAll(io.out.getElements)
    .appendedAll(io.in.getElements)

  if (DebugControl.IFIDStageRegsIOPrint) {
    CPUPrintf.printfIO(
      "INFO",
      this,
      io.getElements
        .filterNot(data => needDelete.contains(data))
        .toList
        .appendedAll(needAdd),
      needBinary,
      needDec,
      needHex,
      needBool
    )
  }
}
