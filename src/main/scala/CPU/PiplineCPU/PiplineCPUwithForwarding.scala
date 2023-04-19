package CPU.PiplineCPU

import chisel3._
import chisel3.util._

import CPU.Adder
import CPU.CPUConfig._
import CPU.Componts._
import CPU.DebugControl
import CPU.PiplineComponts._

/**
 * <b>[带旁路转发的流水线 CPU]]</b>
 * <p>
 * 流水线 CPU 顶层架构
 * @param instFile
 *  指令内存初始化 hex 文件所在的位置
 * @param dataFile
 *  数据文件初始化 hex 文件所在的位置
 * @param startAddress
 *  CPU 开始运行的起始指令位置
 */
class PiplineCPUwithForwarding(
    instFile: String = "",
    dataFile: String = "",
    startAddress: Int = 0x0
) extends PiplineCPUGeneral(instFile, dataFile, startAddress) {
  /* 创建组件 */
  val branchControlUnit = Module(new BranchControlUnit())
  val dataForwardingUnit = Module(new DataForwardingUnit())

  /* 连接 CPU 的输出 */
  val readDataRs1 = Mux(
    dataForwardingUnit.io.forwardRs1, // 旁路转发
    dataForwardingUnit.io.forwardData1,
    regUnit.io.readDataRs1
  )
  val readDataRs2 = Mux(
    dataForwardingUnit.io.forwardRs2, // 旁路转发
    dataForwardingUnit.io.forwardData2,
    regUnit.io.readDataRs2
  )

  io.isValidInst := controlUnit.io.isValidInst

  io.ifPC := ifIDStageRegs.io.in.pc
  io.ifInst := ifIDStageRegs.io.in.inst
  io.idPC := idEXEStageRegs.io.in.pc
  io.idInst := idEXEStageRegs.io.in.inst
  io.exePC := exeMEMStageRegs.io.in.pc
  io.exeInst := exeMEMStageRegs.io.in.inst
  io.memPC := memWBStageRegs.io.in.pc
  io.memInst := memWBStageRegs.io.in.inst
  io.wbPC := memWBStageRegs.io.out.pc
  io.wbInst := memWBStageRegs.io.out.inst

  io.resultToReg := regUnit.io.writeData
  io.readData := dataMemory.io.readData
  io.aluResult := alu.io.result

  io.isTrue := pcSelectUnit.io.isTrue
  io.opcode := controlUnit.io.opcode
  io.isJALR := pcSelectUnit.io.isJALR
  io.isBType := pcSelectUnit.io.isBType
  io.isJump := pcSelectUnit.io.isJump
  io.immALUToReg := controlUnit.io.immALUToReg
  io.memRead := dataMemory.io.memRead
  io.memWrite := dataMemory.io.memWrite
  io.immRs2ToALU := controlUnit.io.immRs2ToALU
  io.aluY := alu.io.y
  io.pcRs1ToALU := controlUnit.io.pcRs1ToALU
  io.aluX := alu.io.x
  io.isIType := controlUnit.io.isIType
  io.isRType := controlUnit.io.isRType
  io.isWord := controlUnit.io.isWord
  io.ifWriteToReg := regUnit.io.writeEnable

  io.address := dataMemory.io.address
  io.writeData := dataMemory.io.writeData

  io.aluOperation := alu.io.aluOperation
  io.imm := inst2ImmUnit.io.imm
  io.rs1 := regUnit.io.rs1
  io.readDataRs1 := readDataRs1
  io.rs2 := regUnit.io.rs2
  io.readDataRs2 := readDataRs2
  io.rd := regUnit.io.rd
  io.nextPC := branchControlUnit.io.nextPC

  io.bitType := dataMemory.io.bitType
  io.isUnsigned := dataMemory.io.isUnsigned

  for (i <- 0 until 32) {
    io.regAll(i) := regUnit.io.regAll(i)
  }

  /* 连接组件 */
  val ifPC = pcReg.io.out
  val ifInst = instMemory.io.inst
  val idPC = ifIDStageRegs.io.out.pc
  val idInst = ifIDStageRegs.io.out.inst
  val exePC = idEXEStageRegs.io.out.pc
  val exeInst = idEXEStageRegs.io.out.inst
  val memPC = exeMEMStageRegs.io.out.pc
  val memInst = exeMEMStageRegs.io.out.inst
  val wbPC = memWBStageRegs.io.out.pc
  val wbInst = memWBStageRegs.io.out.inst

  val opcode = idInst(6, 0)

  val rs1 = idInst(19, 15)
  val rs2 = idInst(24, 20)
  val rd = idInst(11, 7)
  val funct3 = idInst(14, 12)
  val funct7 = idInst(31, 25)

  val bitType = memInst(13, 12)
  val isUnsigned = memInst(14)

  val wbRd = wbInst(11, 7)

  ifIDStageRegs.io.stall := dataForwardingUnit.io.stall
  ifIDStageRegs.io.flush := branchControlUnit.io.flush
  ifIDStageRegs.io.in.pc := pcReg.io.out
  ifIDStageRegs.io.in.inst := instMemory.io.inst

  idEXEStageRegs.io.stall := false.B
  idEXEStageRegs.io.flush := dataForwardingUnit.io.flush
  idEXEStageRegs.io.in.pc := ifIDStageRegs.io.out.pc
  idEXEStageRegs.io.in.inst := ifIDStageRegs.io.out.inst
  idEXEStageRegs.io.in.isJALR := controlUnit.io.isJALR
  idEXEStageRegs.io.in.isBType := controlUnit.io.isBType
  idEXEStageRegs.io.in.isJump := controlUnit.io.isJump
  idEXEStageRegs.io.in.immALUToReg := controlUnit.io.immALUToReg
  idEXEStageRegs.io.in.memRead := controlUnit.io.memRead
  idEXEStageRegs.io.in.memWrite := controlUnit.io.memWrite
  idEXEStageRegs.io.in.writeEnable := controlUnit.io.ifWriteToReg
  idEXEStageRegs.io.in.aluOperation := aluControlUnit.io.aluOperation
  idEXEStageRegs.io.in.readDataRs2 := readDataRs2
  idEXEStageRegs.io.in.rd := rd
  idEXEStageRegs.io.in.aluX := Mux(
    controlUnit.io.pcRs1ToALU,
    ifIDStageRegs.io.out.pc,
    readDataRs1
  )
  idEXEStageRegs.io.in.aluY := Mux(
    controlUnit.io.immRs2ToALU,
    inst2ImmUnit.io.imm,
    readDataRs2
  )
  idEXEStageRegs.io.in.imm := inst2ImmUnit.io.imm

  exeMEMStageRegs.io.stall := false.B
  exeMEMStageRegs.io.flush := false.B
  exeMEMStageRegs.io.in.pc := idEXEStageRegs.io.out.pc
  exeMEMStageRegs.io.in.inst := idEXEStageRegs.io.out.inst
  exeMEMStageRegs.io.in.isJump := idEXEStageRegs.io.out.isJump
  exeMEMStageRegs.io.in.immALUToReg := idEXEStageRegs.io.out.immALUToReg
  exeMEMStageRegs.io.in.memRead := idEXEStageRegs.io.out.memRead
  exeMEMStageRegs.io.in.memWrite := idEXEStageRegs.io.out.memWrite
  exeMEMStageRegs.io.in.writeEnable := idEXEStageRegs.io.out.writeEnable
  exeMEMStageRegs.io.in.readDataRs2 := idEXEStageRegs.io.out.readDataRs2
  exeMEMStageRegs.io.in.rd := idEXEStageRegs.io.out.rd
  exeMEMStageRegs.io.in.aluResult := alu.io.result
  exeMEMStageRegs.io.in.imm := idEXEStageRegs.io.out.imm

  memWBStageRegs.io.stall := false.B
  memWBStageRegs.io.flush := false.B
  memWBStageRegs.io.in.pc := exeMEMStageRegs.io.out.pc
  memWBStageRegs.io.in.inst := exeMEMStageRegs.io.out.inst
  memWBStageRegs.io.in.isJump := exeMEMStageRegs.io.out.isJump
  memWBStageRegs.io.in.immALUToReg := exeMEMStageRegs.io.out.immALUToReg
  memWBStageRegs.io.in.memRead := exeMEMStageRegs.io.out.memRead
  memWBStageRegs.io.in.writeEnable := exeMEMStageRegs.io.out.writeEnable
  memWBStageRegs.io.in.readData := dataMemory.io.readData
  memWBStageRegs.io.in.rd := exeMEMStageRegs.io.in.rd
  memWBStageRegs.io.in.aluResult := exeMEMStageRegs.io.out.aluResult
  memWBStageRegs.io.in.imm := exeMEMStageRegs.io.out.imm

  branchControlUnit.io.keep := dataForwardingUnit.io.keep
  branchControlUnit.io.isJump := controlUnit.io.isJump
  branchControlUnit.io.isBType := controlUnit.io.isBType
  branchControlUnit.io.ifPC := ifPC
  branchControlUnit.io.idPC := idPC
  branchControlUnit.io.exePC := exePC
  branchControlUnit.io.selectPC := pcSelectUnit.io.nextPC

  dataForwardingUnit.io.pcRs1ToAlu := controlUnit.io.pcRs1ToALU
  dataForwardingUnit.io.rs1 := rs1
  dataForwardingUnit.io.memWrite := controlUnit.io.memWrite
  dataForwardingUnit.io.immRs2ToAlu := controlUnit.io.immRs2ToALU
  dataForwardingUnit.io.rs2 := rs2
  dataForwardingUnit.io.exeWriteEnable := idEXEStageRegs.io.out.writeEnable
  dataForwardingUnit.io.exeRd := idEXEStageRegs.io.out.rd
  dataForwardingUnit.io.memWriteEnable := exeMEMStageRegs.io.out.writeEnable
  dataForwardingUnit.io.memRd := exeMEMStageRegs.io.out.rd

  dataForwardingUnit.io.exeIsJump := idEXEStageRegs.io.out.isJump
  dataForwardingUnit.io.exeImmALUToReg := idEXEStageRegs.io.out.immALUToReg
  dataForwardingUnit.io.exeMemRead := idEXEStageRegs.io.out.memRead
  dataForwardingUnit.io.exeALUResult := alu.io.result
  dataForwardingUnit.io.exeImm := idEXEStageRegs.io.out.imm

  dataForwardingUnit.io.memIsJump := exeMEMStageRegs.io.out.isJump
  dataForwardingUnit.io.memImmALUToReg := exeMEMStageRegs.io.out.immALUToReg
  dataForwardingUnit.io.memMemRead := exeMEMStageRegs.io.out.memRead
  dataForwardingUnit.io.memReadData := dataMemory.io.readData
  dataForwardingUnit.io.memALUResult := exeMEMStageRegs.io.out.aluResult
  dataForwardingUnit.io.memImm := exeMEMStageRegs.io.out.imm

  dataForwardingUnit.io.exePC := exePC
  dataForwardingUnit.io.memPC := memPC

  pcReg.io.in := branchControlUnit.io.nextPC

  instMemory.io.address := pcReg.io.out

  controlUnit.io.opcode := opcode

  aluControlUnit.io.isBType := controlUnit.io.isBType
  aluControlUnit.io.isIType := controlUnit.io.isIType
  aluControlUnit.io.isRType := controlUnit.io.isRType
  aluControlUnit.io.isWord := controlUnit.io.isWord
  aluControlUnit.io.funct3 := funct3
  aluControlUnit.io.funct7 := funct7

  regUnit.io.writeEnable := memWBStageRegs.io.out.writeEnable
  regUnit.io.rs1 := rs1
  regUnit.io.rs2 := rs2
  regUnit.io.rd := wbRd
  regUnit.io.writeData := resSelectUnit.io.out

  inst2ImmUnit.io.inst := idInst

  pcSelectUnit.io.pcPlus4 := exePC + 4.U
  pcSelectUnit.io.pcPlusImm := exePC + idEXEStageRegs.io.out.imm
  pcSelectUnit.io.isJALR := idEXEStageRegs.io.out.isJALR
  pcSelectUnit.io.isBType := idEXEStageRegs.io.out.isBType
  pcSelectUnit.io.isJump := idEXEStageRegs.io.out.isJump
  pcSelectUnit.io.isTrue := alu.io.result(0)
  pcSelectUnit.io.aluResult := alu.io.result

  alu.io.aluOperation := idEXEStageRegs.io.out.aluOperation
  alu.io.x := idEXEStageRegs.io.out.aluX
  alu.io.y := idEXEStageRegs.io.out.aluY

  dataMemory.io.memRead := exeMEMStageRegs.io.out.memRead
  dataMemory.io.memWrite := exeMEMStageRegs.io.out.memWrite
  dataMemory.io.address := exeMEMStageRegs.io.out.aluResult
  dataMemory.io.writeData := exeMEMStageRegs.io.out.readDataRs2
  dataMemory.io.bitType := bitType
  dataMemory.io.isUnsigned := isUnsigned

  resSelectUnit.io.isJump := memWBStageRegs.io.out.isJump
  resSelectUnit.io.immALUToReg := memWBStageRegs.io.out.immALUToReg
  resSelectUnit.io.memRead := memWBStageRegs.io.out.memRead
  resSelectUnit.io.readData := memWBStageRegs.io.out.readData
  resSelectUnit.io.aluResult := memWBStageRegs.io.out.aluResult
  resSelectUnit.io.imm := memWBStageRegs.io.out.imm
  resSelectUnit.io.pcPlus4 := wbPC + 4.U
}

object PiplineCPUwithForwarding {
  def main(args: Array[String]) = {
    print(getVerilogString(new PiplineCPUwithForwarding()))
    emitVerilog(
      new PiplineCPUwithForwarding(),
      Array(
        "--target-dir",
        s"generated/${PiplineCPUwithForwarding.toString().split('$')(0).split('.').last}"
      )
    )
    print("\n[Success]\n")
  }
}

class PiplineCPUwithForwardingSimplify(
    instFile: String = "",
    dataFile: String = "",
    startAddress: Int = 0x0
) extends Module {
  val io = IO(new PiplineCPUGeneralSimplifyIO)

  val cpu = Module(new PiplineCPU(instFile, dataFile, startAddress))

  io.isValidInst := cpu.io.isValidInst

  io.pc := cpu.io.ifPC
  io.nextPC := cpu.io.nextPC
  io.inst := cpu.io.ifInst

  io.aluOperation := cpu.io.aluOperation
  io.imm := cpu.io.imm
  io.aluResult := cpu.io.aluResult

  io.opcode := cpu.io.opcode
  io.isTrue := cpu.io.isTrue
  io.isJALR := cpu.io.isJALR
  io.isBType := cpu.io.isBType
  io.isJump := cpu.io.isJump
  io.immALUToReg := cpu.io.immALUToReg
  io.memRead := cpu.io.memRead
  io.memWrite := cpu.io.memWrite
  io.immRs2ToALU := cpu.io.immRs2ToALU
  io.pcRs1ToALU := cpu.io.pcRs1ToALU
  io.isIType := cpu.io.isIType
  io.isRType := cpu.io.isRType
  io.isWord := cpu.io.isWord
  io.ifWriteToReg := cpu.io.ifWriteToReg

  io.rs1 := cpu.io.rs1
  io.rs2 := cpu.io.rs2
  io.rd := cpu.io.rd

  io.bitType := cpu.io.bitType
  io.isUnsigned := cpu.io.isUnsigned
  io.readData := cpu.io.readData
}

object PiplineCPUwithForwardingSimplify {
  def main(args: Array[String]) = {
    print(
      getVerilogString(new PiplineCPUwithForwardingSimplify())
    )
    emitVerilog(
      new PiplineCPUwithForwardingSimplify(),
      Array(
        "--target-dir",
        s"generated/${PiplineCPUwithForwardingSimplify.toString().split('$')(0).split('.').last}"
      )
    )
    print("\n[Success]\n")
  }
}
