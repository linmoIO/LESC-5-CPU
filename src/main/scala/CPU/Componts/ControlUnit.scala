package CPU.Componts

import chisel3._
import chisel3.util.ListLookup
import chisel3.util.BitPat

import CPU._

import CPU.{InstKind, InstKind2Opcode}

/**
 * <b>[[控制单元]]</b>
 * <p>
 * 根据操作码生成对应的控制信号
 * <p>
 * [[input]]
 *   - opcode : 操作码, 来自 InstMemory.inst 的 [6-0]
 *              为指令的低 7 位
 * <p>
 * [[output]]
 *   - isJALR : 1 for jalr, 等同于 jumptype[0]
 *              为 true.B,   (jalr) 则 next_pc 来源于 ALU
 *   - isBType : 是否为 B-type 指令, 1 for B-type
 *   - isJump : 是否为 jump 指令, 1 for jal/jalr, 等同于 jumptype[1]

 *   - immALUToReg : 将 立即数/ALU的结果 放入寄存器,
 *                 1 for immediate, 0 for ALU's result
 *
 *   - memRead : 是否需要从 DataMemory 中读取数据
 *   - memWrite : 是否需要向 DataMemory 中写入数据
 *   - memValid : 是否要对 DataMemory 进行操作,
 *                memValid = memRead BitOR memWrite
 *
 *   - immRs2ToALU : 控制 ALU.y 的输入
 *              1 for immediate, 0 for RegUnit.readDataRs2
 *   - pcRs1ToALU : 控制 ALU.x 的输入
 *             1 for PCReg.out, 0 for RegUnit.readDataRs1
 *
 *   - isIType : 是否为 I-type 指令
 *   - isRType : 是否为 R-type 指令
 *   - isWord : 是否为 '*W' 型指令, 即按 word 处理
 *
 *   - ifWriteToReg : 是否要将结果写入寄存器
 *
 *   - isValidInst : 是否是有效的指令
 */
class ControlUnit extends Module {
  val io = IO(new Bundle {
    /* input */
    val opcode = Input(UInt(7.W))
    /* output */
    val isJALR = Output(Bool())
    val isBType = Output(Bool())
    val isJump = Output(Bool())
    val immALUToReg = Output(Bool())
    val memRead = Output(Bool())
    val memWrite = Output(Bool())
    val memValid = Output(Bool())
    val immRs2ToALU = Output(Bool())
    val pcRs1ToALU = Output(Bool())
    val isIType = Output(Bool())
    val isRType = Output(Bool())
    val isWord = Output(Bool())
    val ifWriteToReg = Output(Bool())
    val isValidInst = Output(Bool())
  })

  val controlSignals = ListLookup(
// format: off
    io.opcode,
    List( // default
    //      isJALR   isBType  isJump immALUToReg memRead memWrite memValid immRs2   pcRs1    isIType  isRType  isWord  ifWriteToReg isValid
            false.B, false.B, false.B, false.B, false.B, false.B, false.B, false.B, false.B, false.B, false.B, false.B, false.B, false.B
    ),
    Array(
      // LUI, U-type : LUI
      BitPat(InstKind2Opcode.getBOpcode(InstKind.LUI)) -> List(
      //    isJALR   isBType  isJump immALUToReg memRead memWrite memValid immRs2   pcRs1    isIType  isRType  isWord  ifWriteToReg isValid
            false.B, false.B, false.B, true.B,  false.B, false.B, false.B, false.B, false.B, false.B, false.B, false.B, true.B,  true.B
      ),
      // AUIPC, U-type : AUIPC
      BitPat(InstKind2Opcode.getBOpcode(InstKind.AUIPC)) -> List(
      //    isJALR   isBType  isJump immALUToReg memRead memWrite memValid immRs2   pcRs1    isIType  isRType  isWord  ifWriteToReg isValid
            false.B, false.B, false.B, false.B, false.B, false.B, false.B, true.B,  true.B,  false.B, false.B, false.B, true.B,  true.B
      ),
      // JAL, J-type : JAL
      BitPat(InstKind2Opcode.getBOpcode(InstKind.JAL)) -> List(
      //    isJALR   isBType  isJump immALUToReg memRead memWrite memValid immRs2   pcRs1    isIType  isRType  isWord  ifWriteToReg isValid
            false.B, false.B, true.B,  false.B, false.B, false.B, false.B, false.B, false.B, false.B, false.B, false.B, true.B,  true.B
      ),
      // JALR, I-type : JALR
      BitPat(InstKind2Opcode.getBOpcode(InstKind.JALR)) -> List(
      //    isJALR   isBType  isJump immALUToReg memRead memWrite memValid immRs2   pcRs1    isIType  isRType  isWord  ifWriteToReg isValid
            true.B,  false.B, true.B,  false.B, false.B, false.B, false.B, true.B,  false.B, false.B, false.B, false.B, true.B,  true.B
      ),
      // B-type, B-type : BEQ, BNE, BLT, BGE, BLTU, BGEU
      BitPat(InstKind2Opcode.getBOpcode(InstKind.BType)) -> List(
      //    isJALR   isBType  isJump immALUToReg memRead memWrite memValid immRs2   pcRs1    isIType  isRType  isWord  ifWriteToReg isValid
            false.B, true.B,  false.B, false.B, false.B, false.B, false.B, false.B, false.B, false.B, false.B, false.B, false.B, true.B
      ),
      // Load, I-type : LB, LH, LW, LD, LBU, LHU, LWU
      BitPat(InstKind2Opcode.getBOpcode(InstKind.Load)) -> List(
      //    isJALR   isBType  isJump immALUToReg memRead memWrite memValid immRs2   pcRs1    isIType  isRType  isWord  ifWriteToReg isValid
            false.B, false.B, false.B, false.B, true.B,  false.B, true.B,  true.B,  false.B, false.B, false.B, false.B, true.B,  true.B
      ),
      // Store, S-type : SB, SH, SW, SD
      BitPat(InstKind2Opcode.getBOpcode(InstKind.Store)) -> List(
      //    isJALR   isBType  isJump immALUToReg memRead memWrite memValid immRs2   pcRs1    isIType  isRType  isWord  ifWriteToReg isValid
            false.B, false.B, false.B, false.B, false.B, true.B,  true.B,  true.B,  false.B, false.B, false.B, false.B, false.B, true.B
      ),
      // I-type(64), I-type : ADDI, SLTI, SLTIU, XORI, ORI, ANDI, SLLI, SRLI, SRAI
      BitPat(InstKind2Opcode.getBOpcode(InstKind.IType)) -> List(
      //    isJALR   isBType  isJump immALUToReg memRead memWrite memValid immRs2   pcRs1    isIType  isRType  isWord  ifWriteToReg isValid
            false.B, false.B, false.B, false.B, false.B, false.B, false.B, true.B,  false.B, true.B,  false.B, false.B, true.B,  true.B
      ),
      // I-type(32), I-type : ADDIW, SLLIW, SRLIW, SRAIW
      BitPat(InstKind2Opcode.getBOpcode(InstKind.ITypeW)) -> List(
      //    isJALR   isBType  isJump immALUToReg memRead memWrite memValid immRs2   pcRs1    isIType  isRType  isWord  ifWriteToReg isValid
            false.B, false.B, false.B, false.B, false.B, false.B, false.B, true.B,  false.B, true.B,  false.B, true.B,  true.B,  true.B
      ),
      // R-type(64), R-type : ADD, SUB, SLL, SLT, SLTU, XOR, SRL, SRA, OR, AND
      BitPat(InstKind2Opcode.getBOpcode(InstKind.RType)) -> List(
      //    isJALR   isBType  isJump immALUToReg memRead memWrite memValid immRs2   pcRs1    isIType  isRType  isWord  ifWriteToReg isValid
            false.B, false.B, false.B, false.B, false.B, false.B, false.B, false.B, false.B, false.B, true.B,  false.B, true.B,  true.B
      ),
      // R-type(32), R-type : ADDW, SUBW, SLLW, SRLW, SRAW
      BitPat(InstKind2Opcode.getBOpcode(InstKind.RTypeW)) -> List(
      //    isJALR   isBType  isJump immALUToReg memRead memWrite memValid immRs2   pcRs1    isIType  isRType  isWord  ifWriteToReg isValid
            false.B, false.B, false.B, false.B, false.B, false.B, false.B, false.B, false.B, false.B, true.B,  true.B,  true.B,  true.B
      )
    )
// format: on
  )

  io.isJALR := controlSignals(0)
  io.isBType := controlSignals(1)
  io.isJump := controlSignals(2)
  io.immALUToReg := controlSignals(3)
  io.memRead := controlSignals(4)
  io.memWrite := controlSignals(5)
  io.memValid := controlSignals(6)
  io.immRs2ToALU := controlSignals(7)
  io.pcRs1ToALU := controlSignals(8)
  io.isIType := controlSignals(9)
  io.isRType := controlSignals(10)
  io.isWord := controlSignals(11)
  io.ifWriteToReg := controlSignals(12)
  io.isValidInst := controlSignals(13)

  // **************** print **************** //
  if (DebugConfig.ControlUnitIOPrint)
    CPUPrintf.printfForIO(io)
}
