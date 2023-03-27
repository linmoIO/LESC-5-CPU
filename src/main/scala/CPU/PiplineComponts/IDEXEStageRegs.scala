package CPU.PiplineComponts

import chisel3._

import CPU._
import CPU.CPUPrintf
import CPUConfig._

class IDEXEStageRegsIO extends Bundle {
  val pc = UInt(XLEN.W) // PC
  val inst = UInt(INST_W.W) // 指令

  // 控制信号
  val isJALR = Bool()
  val isBType = Bool()
  val isJump = Bool()

  val immALUToReg = Bool()

  val memRead = Bool()
  val memWrite = Bool()

  val writeEnable = Bool()

  // ALU 控制码
  val aluOperation = UInt(ALU_OPERATION_W.W)

  // 寄存器组相关
  val readDataRs2 = UInt(XLEN.W)
  val rd = UInt(5.W)
  val aluX = UInt(XLEN.W) // ALU x 操作数
  val aluY = UInt(XLEN.W) // ALU y 操作数

  // 立即数
  val imm = UInt(XLEN.W)
}

class IDEXEStageRegs extends GeneralStageRegs(new IDEXEStageRegsIO) {
  // **************** print **************** //
  val needBinary =
    List(io.in.inst, io.out.inst, io.in.aluOperation, io.out.aluOperation)
  val needDec = List(
    io.in.readDataRs2,
    io.out.readDataRs2,
    io.in.aluX,
    io.out.aluX,
    io.in.aluY,
    io.out.aluY,
    io.in.imm,
    io.out.imm
  )
  val needHex = List(io.in.pc, io.out.pc)
  val needBool = List[Bool]()
    .appendedAll(io.getElements.filter(data => data.isInstanceOf[Bool]))
    .appendedAll(io.in.getElements.filter(data => data.isInstanceOf[Bool]))
    .appendedAll(io.out.getElements.filter(data => data.isInstanceOf[Bool]))

  val needDelete = List(io.in, io.out)
  val needAdd = List[Data]()
    .appendedAll(io.out.getElements)
    .appendedAll(io.in.getElements)

  if (DebugControl.IDEXEStageRegsIOPrint) {
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
