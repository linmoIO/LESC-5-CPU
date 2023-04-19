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
 * <b>[流水线通用顶层]]</b>
 * <p>
 * 流水线 CPU 通用顶层架构, 用于统一 Tester 和打印
 * @param instFile
 *  指令内存初始化 hex 文件所在的位置
 * @param dataFile
 *  数据文件初始化 hex 文件所在的位置
 * @param startAddress
 *  CPU 开始运行的起始指令位置
 */
class PiplineCPUGeneral(
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

  /**
    * 内部连线由子类补充
    */

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

class PiplineCPUGeneralSimplifyIO extends Bundle {
  // 输出端口, 用于查看 CPU 运行
  val isValidInst = Output(Bool()) // 当前指令是否有效

  val pc = Output(UInt(XLEN.W)) // 地址
  val nextPC = Output(UInt(XLEN.W)) // 下一条待执行的指令
  val inst = Output(UInt(INST_W.W)) // 指令

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
  // val aluY = Output(UInt(XLEN.W))
  val pcRs1ToALU = Output(Bool()) // ALU x 的输入
  // val aluX = Output(UInt(XLEN.W))
  val isIType = Output(Bool())
  val isRType = Output(Bool())
  val isWord = Output(Bool())
  val ifWriteToReg = Output(Bool())

  // 寄存器操作组
  val rs1 = Output(UInt(5.W))
  // val readDataRs1 = Output(UInt(XLEN.W))
  val rs2 = Output(UInt(5.W))
  // val readDataRs2 = Output(UInt(XLEN.W))
  val rd = Output(UInt(5.W))
  // val resultToReg = Output(UInt(XLEN.W)) // 将写入寄存器的结果

  val bitType = Output(UInt(2.W))
  val isUnsigned = Output(Bool())
  val readData = Output(UInt(XLEN.W)) // 内存中读出的数据
}
