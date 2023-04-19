package CPU.SingleCycleCPU

import chisel3._
import chisel3.util._

import CPU.Adder
import CPU.CPUConfig._
import CPU.Componts._

class SingleCycleCPUSimlify(
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
  })

  val cpu = Module(new SingleCycleCPU(instFile, dataFile, startAddress))

  io.isValidInst := cpu.io.isValidInst

  io.pc := cpu.io.pc
  io.nextPC := cpu.io.nextPC
  io.inst := cpu.io.inst

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

object SingleCycleCPUSimlify {
  def main(args: Array[String]) = {
    print(getVerilogString(new SingleCycleCPUSimlify()))
    emitVerilog(
      new SingleCycleCPUSimlify(),
      Array(
        "--target-dir",
        s"generated/${SingleCycleCPUSimlify.toString().split('$')(0).split('.').last}"
      )
    )
    print("\n[Success]\n")
  }
}
