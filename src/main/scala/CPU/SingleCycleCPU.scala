package CPU

import chisel3._
import chisel3.util._

import CPU.Adder
import CPU.CPUConfig._
import Componts._
import dataclass.data

/**
  * <b>[[关于 CPU 的说明]]</b>
  * <p>
  * 提供了大量的输出端口用于调试查看,
  * 且内置了 myPrintCPU 用于以日志的形式打印 CPU 的信息,
  * 同时也在 SingleCycleCPUTester 中
  * 提供了日志形式的打印(可能更加美观一些)
  */

/**
 * <b>[[单周期 CPU]]</b>
 * <p>
 * 单周期 CPU 顶层架构
 * @param instFile
 *  指令内存初始化 hex 文件所在的位置
 * @param dataFile
 *  数据文件初始化 hex 文件所在的位置
 * @param startAddress
 *  CPU 开始运行的起始指令位置
 */
class SingleCycleCPU(
    instFile: String = "",
    dataFile: String = "",
    startAddress: Int = 0x0
) extends Module {
  val io = IO(new Bundle {
    // 输出端口, 用于查看 CPU 运行
    val isValidInst = Output(Bool()) // 当前指令是否有效

    val pc = Output(UInt(XLEN.W)) // 地址
    val nextPC = Output(UInt(XLEN.W)) // 下一条待执行的指令
    val inst = Output(UInt(INST_W.W)) // 指令

    // ALU 计算
    val aluOperation = Output(UInt(ALU_OPERATION_W.W))
    val imm = Output(UInt(XLEN.W))
    val resultALU = Output(UInt(XLEN.W)) // ALU 计算结果

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
  val pcAdd4 = Module(new Adder())
  val pcAddImm = Module(new Adder())
  val instMemory = Module(new InstMemory(instFile))
  val controlUnit = Module(new ControlUnit())
  val inst2ImmUnit = Module(new Inst2ImmUnit())
  val regUnit = Module(new RegUnit())
  val aluControlUnit = Module(new ALUControlUnit())
  val pcSelectUnit = Module(new PCSelectUnit())
  val alu = Module(new ALU())
  val dataMemory = Module(new DataMemory(dataFile))
  val resSelectUnit = Module(new ResSelectUnit())

  /* 连接 CPU 的输出 */

  io.isValidInst := controlUnit.io.isValidInst
  io.pc := pcReg.io.out
  io.inst := instMemory.io.inst
  io.resultToReg := resSelectUnit.io.out
  io.readData := dataMemory.io.readData
  io.resultALU := alu.io.result

  io.isTrue := pcSelectUnit.io.isTrue
  io.opcode := controlUnit.io.opcode
  io.isJALR := controlUnit.io.isJALR
  io.isBType := controlUnit.io.isBType
  io.isJump := controlUnit.io.isJump
  io.immALUToReg := controlUnit.io.immALUToReg
  io.memRead := controlUnit.io.memRead
  io.memWrite := controlUnit.io.memWrite
  io.immRs2ToALU := controlUnit.io.immRs2ToALU
  io.aluY := alu.io.y
  io.pcRs1ToALU := controlUnit.io.pcRs1ToALU
  io.aluX := alu.io.x
  io.isIType := controlUnit.io.isIType
  io.isRType := controlUnit.io.isRType
  io.isWord := controlUnit.io.isWord
  io.ifWriteToReg := controlUnit.io.ifWriteToReg

  io.aluOperation := alu.io.aluOperation
  io.imm := inst2ImmUnit.io.imm
  io.rs1 := regUnit.io.rs1
  io.readDataRs1 := regUnit.io.readDataRs1
  io.rs2 := regUnit.io.rs2
  io.readDataRs2 := regUnit.io.readDataRs2
  io.rd := regUnit.io.rd
  io.nextPC := pcSelectUnit.io.nextPC

  io.bitType := dataMemory.io.bitType
  io.isUnsigned := dataMemory.io.isUnsigned

  for (i <- 0 until 32) {
    io.regAll(i) := regUnit.io.regAll(i)
  }

  /* 连接组件 */

  pcReg.io.in := pcSelectUnit.io.nextPC

  pcAdd4.io.x := 4.U
  pcAdd4.io.y := pcReg.io.out

  pcAddImm.io.x := pcReg.io.out
  pcAddImm.io.y := inst2ImmUnit.io.imm

  instMemory.io.address := pcReg.io.out

  controlUnit.io.opcode := instMemory.io.inst(6, 0)

  inst2ImmUnit.io.inst := instMemory.io.inst

  regUnit.io.rs1 := instMemory.io.inst(19, 15)
  regUnit.io.rs2 := instMemory.io.inst(24, 20)
  regUnit.io.rd := instMemory.io.inst(11, 7)
  regUnit.io.writeEnable := controlUnit.io.ifWriteToReg
  regUnit.io.writeData := resSelectUnit.io.out

  pcSelectUnit.io.pcPlus4 := pcAdd4.io.out
  pcSelectUnit.io.pcPlusImm := pcAddImm.io.out
  pcSelectUnit.io.isJump := controlUnit.io.isJump
  pcSelectUnit.io.isBType := controlUnit.io.isBType
  pcSelectUnit.io.isJALR := controlUnit.io.isJALR
  pcSelectUnit.io.isTrue := alu.io.result(0)
  pcSelectUnit.io.aluResult := alu.io.result

  aluControlUnit.io.isBType := controlUnit.io.isBType
  aluControlUnit.io.isIType := controlUnit.io.isIType
  aluControlUnit.io.isRType := controlUnit.io.isRType
  aluControlUnit.io.isWord := controlUnit.io.isWord
  aluControlUnit.io.funct3 := instMemory.io.inst(14, 12)
  aluControlUnit.io.funct7 := instMemory.io.inst(31, 25)

  alu.io.aluOperation := aluControlUnit.io.aluOperation
  alu.io.x := Mux(
    controlUnit.io.pcRs1ToALU,
    pcReg.io.out,
    regUnit.io.readDataRs1
  )
  alu.io.y := Mux(
    controlUnit.io.immRs2ToALU,
    inst2ImmUnit.io.imm,
    regUnit.io.readDataRs2
  )

  dataMemory.io.memRead := controlUnit.io.memRead
  dataMemory.io.memWrite := controlUnit.io.memWrite
  dataMemory.io.address := alu.io.result
  dataMemory.io.writeData := regUnit.io.readDataRs2
  dataMemory.io.bitType := instMemory.io.inst(13, 12)
  dataMemory.io.isUnsigned := instMemory.io.inst(14)

  resSelectUnit.io.memRead := controlUnit.io.memRead
  resSelectUnit.io.isJump := controlUnit.io.isJump
  resSelectUnit.io.immALUToReg := controlUnit.io.immALUToReg
  resSelectUnit.io.readData := dataMemory.io.readData
  resSelectUnit.io.aluResult := alu.io.result
  resSelectUnit.io.imm := inst2ImmUnit.io.imm
  resSelectUnit.io.pcPlus4 := pcAdd4.io.out

  // **************** print **************** //
  val rs1UInt = Cat(0.U, io.rs1)
  val rs2UInt = Cat(0.U, io.rs2)
  val rdUInt = Cat(0.U, io.rd)
  if (DebugControl.SingleCycleCPUPrint) {
    myPrintCPU()
  }

  def myPrintCPU() = {
    printf("————————————————— [ CPU - INFO ] ——————————————————\n")

    printf(
      cf"[Brief] : "
        + cf"PC = 0x${Hexadecimal(io.pc)}, Next PC = 0x${Hexadecimal(io.nextPC)}\n"
        + cf"\tINST = 0x${Hexadecimal(io.inst)} (${Binary(io.inst)})\n"
        + "\n"
    )

    printf(
      cf"[ALU] : "
        + cf"opcode = ${Binary(io.aluOperation)},"
        + cf" B-Type = ${io.isBType}, Word = ${io.isWord}\n"
        + cf"\tpc |rs1 = ${io.pcRs1ToALU},\tx = ${Decimal(io.aluX.asSInt)} \n"
        + cf"\timm|rs2 = ${io.immRs2ToALU},\ty = ${Decimal(io.aluY.asSInt)} \n"
        + cf"\tresult = ${io.resultALU}\n"
        + "\n"
    )

    printf(cf"[Immediate] : ${Decimal(io.imm)}\n\n")

    printf(
      cf"[内存] : "
        + cf"read = ${io.memRead}, memWrite = ${io.memWrite}, "
        + cf"bit-type = ${Binary(dataMemory.io.bitType)}, unsigned = ${dataMemory.io.isUnsigned}\n"
        + cf"\t从 0x${Hexadecimal(io.resultALU)} 中读出数据 ${Decimal(io.readData)}\n"
        + cf"\t往 0x${Hexadecimal(io.resultALU)} 中写入 ${Decimal(io.readDataRs2)}\n"
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

object SingleCycleCPU {
  def main(args: Array[String]) = {
    print(getVerilogString(new SingleCycleCPU()))
    emitVerilog(new SingleCycleCPU(), Array("--target-dir", "generated"))
    print("\n[Success]\n")
  }
}
