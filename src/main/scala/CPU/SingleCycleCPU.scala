package CPU

import Componts._
import chisel3._

import CPU.Adder

/**
 * <b>[[单周期 CPU]]</b>
 * <p>
 * CPU 顶层架构
 * <p>
 * [[output]]
 *   - isValidInst : 当前执行的指令是否有效
 */
class SingleCycleCPU extends Module {
  val io = IO(new Bundle {
    val isValidInst = Output(Bool())
  })

  val pcReg = Module(new PCReg())
  val pcAdd4 = Module(new Adder())
  val pcAddImm = Module(new Adder())
  val instMemory = Module(new InstMemory())
  val controlUnit = Module(new ControlUnit())
  val inst2ImmUnit = Module(new Inst2ImmUnit())
  val regUnit = Module(new RegUnit())
  val aluControlUnit = Module(new ALUControlUnit())
  val pcSelectUnit = Module(new PCSelectUnit())
  val alu = Module(new ALU())
  val dataMemory = Module(new DataMemory())
  val resSelectUnit = Module(new ResSelectUnit())

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

  dataMemory.io.valid := controlUnit.io.memRead & controlUnit.io.memWrite
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

  io.isValidInst := controlUnit.io.isValidInst
}

object Design {
  def main(args: Array[String]) = {
    print(getVerilogString(new SingleCycleCPU()))

    print("\n[Success]\n")
  }
}
