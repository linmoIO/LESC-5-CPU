package CPU.PiplineComponts

import chisel3._

import CPU._
import CPU.CPUPrintf
import CPUConfig._

/**
 * EXE -> MEM 阶段的寄存器组的 IO
 */
class EXEMEMStageRegsIO extends Bundle {
  val pc = UInt(XLEN.W) // PC
  val inst = UInt(INST_W.W) // 指令

  // 控制信号
  val isJump = Bool()
  val immALUToReg = Bool()
  val memRead = Bool()
  val memWrite = Bool()
  val writeEnable = Bool()

  // 寄存器组
  val readDataRs2 = UInt(XLEN.W)
  val rd = UInt(5.W)

  // ALU 计算结果
  val aluResult = UInt(XLEN.W)

  // 立即数
  val imm = UInt(XLEN.W)
}

/**
 * EXE -> MEM 阶段的寄存器组
 */
class EXEMEMStageRegs extends GeneralStageRegs(new EXEMEMStageRegsIO) {

  // **************** print **************** //
  val needBinary =
    List(io.in.inst, io.out.inst)
  val needDec = List(
    io.in.readDataRs2,
    io.out.readDataRs2,
    io.in.imm,
    io.out.imm,
    io.in.aluResult,
    io.out.aluResult
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

  if (DebugControl.EXEMEMStageRegsIOPrint) {
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
