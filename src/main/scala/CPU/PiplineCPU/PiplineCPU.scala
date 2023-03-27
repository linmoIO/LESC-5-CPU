package CPU.PiplineCPU

import chisel3._
import chisel3.util._

import CPU.Adder
import CPU.CPUConfig._
import CPU.Componts._
import CPU.DebugControl
import CPU.PiplineComponts._
import dataclass.data

/**
 * <b>[流水线 CPU]]</b>
 * <p>
 * 流水线 CPU 顶层架构
 * @param instFile
 *  指令内存初始化 hex 文件所在的位置
 * @param dataFile
 *  数据文件初始化 hex 文件所在的位置
 * @param startAddress
 *  CPU 开始运行的起始指令位置
 */
class PiplineCPU(
    instFile: String = "",
    dataFile: String = "",
    startAddress: Int = 0x0
) extends Module {
  val io = IO(new Bundle {
    // 输出端口, 用于查看 CPU 运行
    val isValidInst = Output(Bool()) // 当前指令是否有效

    val ifPC = Output(UInt(XLEN.W))
    val ifInst = Output(UInt(INST_W.W))
    val idPC = Output(UInt(XLEN.W))
    val idInst = Output(UInt(INST_W.W))
    val exePC = Output(UInt(XLEN.W))
    val exeInst = Output(UInt(INST_W.W))
    val memPC = Output(UInt(XLEN.W))
    val memInst = Output(UInt(INST_W.W))
    val wbPC = Output(UInt(XLEN.W))
    val wbInst = Output(UInt(INST_W.W))

    val nextPC = Output(UInt(XLEN.W)) // PC 选择器选出的下一条待执行的指令

    // ALU 计算
    val aluOperation = Output(UInt(ALU_OPERATION_W.W))
    val imm = Output(UInt(XLEN.W))
    val aluResult = Output(UInt(XLEN.W)) // ALU 计算结果

    // 控制信号组
    val opcode = Output(UInt(7.W))
    val isTrue = Output(Bool())
    val isJALR = Output(Bool())
    val isBType = Output(Bool())
    val isJump = Output(Bool())
    val immALUToReg = Output(Bool())
    val memRead = Output(Bool())
    val memWrite = Output(Bool())
    val immRs2ToALU = Output(Bool()) // ALU y 的输入
    val aluY = Output(UInt(XLEN.W))
    val pcRs1ToALU = Output(Bool()) // ALU x 的输入
    val aluX = Output(UInt(XLEN.W))
    val isIType = Output(Bool())
    val isRType = Output(Bool())
    val isWord = Output(Bool())
    val ifWriteToReg = Output(Bool())

    // 内存组
    val address = Output(UInt(XLEN.W))
    val writeData = Output(UInt(XLEN.W))

    // 寄存器操作组
    val rs1 = Output(UInt(5.W))
    val readDataRs1 = Output(UInt(XLEN.W))
    val rs2 = Output(UInt(5.W))
    val readDataRs2 = Output(UInt(XLEN.W))
    val rd = Output(UInt(5.W))
    val resultToReg = Output(UInt(XLEN.W)) // 将写入寄存器的结果

    val bitType = Output(UInt(2.W))
    val isUnsigned = Output(Bool())
    val readData = Output(UInt(XLEN.W)) // 内存中读出的数据

    val regAll = Output(Vec(32, UInt(XLEN.W))) // 寄存器状态
  })

  /* 创建组件 */
  val pcReg = Module(new PCReg(startAddress))
  val instMemory = Module(new InstMemory(instFile))
  val controlUnit = Module(new ControlUnit())
  val inst2ImmUnit = Module(new Inst2ImmUnit())
  val regUnit = Module(new RegUnitWithForwarding())
  val aluControlUnit = Module(new ALUControlUnit())
  val pcSelectUnit = Module(new PCSelectUnit())
  val alu = Module(new ALU())
  val dataMemory = Module(new DataMemory(dataFile))
  val resSelectUnit = Module(new ResSelectUnit())

  val ifIDStageRegs = Module(new IFIDStageRegs())
  val idEXEStageRegs = Module(new IDEXEStageRegs())
  val exeMEMStageRegs = Module(new EXEMEMStageRegs())
  val memWBStageRegs = Module(new MEMWBStageRegs())

  val branchControlUnit = Module(new BranchControlUnit())
  val dataControlUnit = Module(new DataControlUnit())

  /* 连接 CPU 的输出 */

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
  io.readDataRs1 := regUnit.io.readDataRs1
  io.rs2 := regUnit.io.rs2
  io.readDataRs2 := regUnit.io.readDataRs2
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

  ifIDStageRegs.io.stall := dataControlUnit.io.stall
  ifIDStageRegs.io.flush := branchControlUnit.io.flush
  ifIDStageRegs.io.in.pc := pcReg.io.out
  ifIDStageRegs.io.in.inst := instMemory.io.inst

  idEXEStageRegs.io.stall := false.B
  idEXEStageRegs.io.flush := dataControlUnit.io.flush
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
  idEXEStageRegs.io.in.readDataRs2 := regUnit.io.readDataRs2
  idEXEStageRegs.io.in.rd := rd
  idEXEStageRegs.io.in.aluX := Mux(
    controlUnit.io.pcRs1ToALU,
    ifIDStageRegs.io.out.pc,
    regUnit.io.readDataRs1
  )
  idEXEStageRegs.io.in.aluY := Mux(
    controlUnit.io.immRs2ToALU,
    inst2ImmUnit.io.imm,
    regUnit.io.readDataRs2
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

  branchControlUnit.io.keep := dataControlUnit.io.keep
  branchControlUnit.io.isJump := controlUnit.io.isJump
  branchControlUnit.io.isBType := controlUnit.io.isBType
  branchControlUnit.io.ifPC := ifPC
  branchControlUnit.io.idPC := idPC
  branchControlUnit.io.exePC := exePC
  branchControlUnit.io.selectPC := pcSelectUnit.io.nextPC

  dataControlUnit.io.inWriteEnable := memWBStageRegs.io.out.writeEnable
  dataControlUnit.io.inRd := wbRd
  dataControlUnit.io.inData := resSelectUnit.io.out
  dataControlUnit.io.pcRs1ToAlu := controlUnit.io.pcRs1ToALU
  dataControlUnit.io.rs1 := rs1
  dataControlUnit.io.memWrite := controlUnit.io.memWrite
  dataControlUnit.io.immRs2ToAlu := controlUnit.io.immRs2ToALU
  dataControlUnit.io.rs2 := rs2
  dataControlUnit.io.exeWriteEnable := idEXEStageRegs.io.out.writeEnable
  dataControlUnit.io.exeRd := idEXEStageRegs.io.out.rd
  dataControlUnit.io.memWriteEnable := exeMEMStageRegs.io.out.writeEnable
  dataControlUnit.io.memRd := exeMEMStageRegs.io.out.rd
  dataControlUnit.io.exePC := exePC
  dataControlUnit.io.memPC := memPC
  dataControlUnit.io.wbPC := wbPC

  pcReg.io.in := branchControlUnit.io.nextPC

  instMemory.io.address := pcReg.io.out

  controlUnit.io.opcode := opcode

  aluControlUnit.io.isBType := controlUnit.io.isBType
  aluControlUnit.io.isIType := controlUnit.io.isIType
  aluControlUnit.io.isRType := controlUnit.io.isRType
  aluControlUnit.io.isWord := controlUnit.io.isWord
  aluControlUnit.io.funct3 := funct3
  aluControlUnit.io.funct7 := funct7

  regUnit.io.writeEnable := dataControlUnit.io.writeEnable
  regUnit.io.rs1 := rs1
  regUnit.io.rs2 := rs2
  regUnit.io.rd := dataControlUnit.io.rd
  regUnit.io.writeData := dataControlUnit.io.data

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

  // **************** print **************** //
  val rs1UInt = Cat(0.U, io.rs1)
  val rs2UInt = Cat(0.U, io.rs2)
  val rdUInt = Cat(0.U, io.rd)
  if (DebugControl.PiplineCPUPrint) {
    myPrintCPU()
  }

  def myPrintCPU() = {
    printf("————————————————— [ CPU - INFO ] ——————————————————\n")

    printf(
      cf"[Brief] : "
        + cf"PC = 0x${Hexadecimal(io.ifPC)}, Next PC = 0x${Hexadecimal(io.nextPC)}\n"
        + cf"\tINST = 0x${Hexadecimal(io.ifInst)} (${Binary(io.ifInst)})\n"
        + "\n"
    )

    printf(
      cf"[ALU] : "
        + cf"opcode = ${Binary(io.aluOperation)},"
        + cf" B-Type = ${io.isBType}, Word = ${io.isWord}\n"
        + cf"\tpc |rs1 = ${io.pcRs1ToALU},\tx = ${Decimal(io.aluX.asSInt)} \n"
        + cf"\timm|rs2 = ${io.immRs2ToALU},\ty = ${Decimal(io.aluY.asSInt)} \n"
        + cf"\tresult = ${io.aluResult}\n"
        + "\n"
    )

    printf(cf"[Immediate] : ${Decimal(io.imm)}\n\n")

    printf(
      cf"[内存] : "
        + cf"read = ${io.memRead}, memWrite = ${io.memWrite}, "
        + cf"bit-type = ${Binary(dataMemory.io.bitType)}, unsigned = ${dataMemory.io.isUnsigned}\n"
        + cf"\t从 0x${Hexadecimal(io.aluResult)} 中读出数据 ${Decimal(io.readData)}\n"
        + cf"\t往 0x${Hexadecimal(io.aluResult)} 中写入 ${Decimal(io.readDataRs2)}\n"
        + "\n"
    )

    printf(
      cf"[寄存器] : "
        + cf"writeEnable = ${regUnit.io.writeEnable}\n"
        + cf"\trs1 : 从 ${Decimal(rs1UInt)} 中读出数据 ${Decimal(io.readDataRs1)}\n"
        + cf"\trs2 : 从 ${Decimal(rs2UInt)} 中读出数据 ${Decimal(io.readDataRs2)}\n"
        + cf"\trd  : 往 ${Decimal(rdUInt)} 中写入数据 ${Decimal(io.resultToReg)}\n"
        + "\n"
    )

    printf(
      cf"[Res 选择器] : "
        + cf"Jump = ${io.isJump}, Imm|ALU = ${io.immALUToReg}, memRead = ${io.memRead}\n"
        + cf"\t选出的 Res 结果为 ${Decimal(io.resultToReg)}\n"
        + "\n"
    )

    printf(
      cf"[PC 选择器] : "
        + cf"JALR = ${io.isJALR}, B-Type = ${io.isBType}, Jump = ${io.isJump}, isTrue = ${io.isTrue}\n"
        + cf"\t选出的 next PC 结果为 0x${Hexadecimal(io.nextPC)}\n"
        + "\n"
    )

    printf("———————————————————————————————————————————————————\n")
  }
}

object PiplineCPU {
  def main(args: Array[String]) = {
    print(getVerilogString(new PiplineCPU()))
    emitVerilog(
      new PiplineCPU(),
      Array(
        "--target-dir",
        s"generated/${PiplineCPU.toString().split('$')(0).split('.').last}"
      )
    )
    print("\n[Success]\n")
  }
}
