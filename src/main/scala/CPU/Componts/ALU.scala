package CPU.Componts

import chisel3._
import chisel3.util.switch
import chisel3.util._

import CPU.ALUOperation2Opcode._
import CPU.ALUOperation._
import CPU.CPUConfig._
import CPU.CPUUtils._
import CPU._

/**
 * <b>[[ALU 运算单元]]</b>
 * <p>
 * 根据 ALU 控制单元传来的操作码, 对数据进行计算
 * <p>
 * [[input]]
 *   - aluOperation : 操作码, 来自 ALUControlUnit
 *                    combine|isWord|isBType
 *   - x : 待计算的数据 1, pc / rs1
 *   - y : 待计算的数据 2, imm / rs2
 * <p>
 * [[output]]
 *   - result : 计算得到的结果
 */
class ALU extends Module {
  val io = IO(new Bundle {
    /* input */
    val aluOperation = Input(UInt(ALU_OPERATION_W.W))
    val x = Input(UInt(XLEN.W))
    val y = Input(UInt(XLEN.W))
    /* output */
    val result = Output(UInt(XLEN.W))
  })
  val combine = io.aluOperation(5, 2)
  val isWord = io.aluOperation(1).asBool
  val isBType = io.aluOperation(0).asBool

  // 针对 Word 指令
  val x32 = io.x(31, 0)
  val y32 = io.y(31, 0)

  // 移位量
  val shamt = io.y(SHAMT_W - 1, 0)
  val shamtW = io.y(SHAMT_W - 2, 0)

  val resWire = WireDefault(io.x + io.y)

  when(isBType === true.B) { // B-Type
    switch(combine) {
      // BEQ
      is(getBOpcode(BEQ).U) {
        resWire := io.x === io.y
      }
      // BNE
      is(getBOpcode(BNE).U) {
        resWire := io.x =/= io.y
      }
      // BLT
      is(getBOpcode(BLT).U) {
        resWire := (io.x.asSInt < io.y.asSInt).asUInt
      }
      // BGE
      is(getBOpcode(BGE).U) {
        resWire := (io.x.asSInt >= io.y.asSInt).asUInt
      }
      // BLTU
      is(getBOpcode(BLTU).U) {
        resWire := (io.x < io.y)
      }
      // BGEU
      is(getBOpcode(BGEU).U) {
        resWire := (io.x >= io.y)
      }
    }
  }.otherwise { // R-Type / I-Type
    switch(combine) {
      // ADD : ADD/ADDI, ADDW/ADDIW
      is(getBOpcode(ADD).U) {
        when(isWord === true.B) {
          resWire := signExtend32To64(x32 + y32)
        }.otherwise {
          resWire := io.x + io.y
        }
      }
      // SUB : SUB, SUBW
      is(getBOpcode(SUB).U) {
        when(isWord === true.B) {
          resWire := signExtend32To64(x32 - y32)
        }.otherwise {
          resWire := io.x - io.y
        }
      }
      // SLL : SLL/SLLI, SLLW/SLLIW
      is(getBOpcode(SLL).U) {
        when(isWord === true.B) {
          resWire := signExtend32To64(x32 << shamtW)
        }.otherwise {
          resWire := io.x << shamt
        }
      }
      // SLT : SLT/SLTI
      is(getBOpcode(SLT).U) {
        resWire := (io.x.asSInt < io.y.asSInt).asUInt
      }
      // SLTU : SLTU/SLTIU
      is(getBOpcode(SLTU).U) {
        resWire := (io.x < io.y)
      }
      // XOR : XOR/XORI
      is(getBOpcode(XOR).U) {
        resWire := (io.x ^ io.y)
      }
      // SRL : SRL/SRLI, SRLW/SRLIW
      is(getBOpcode(SRL).U) {
        when(isWord === true.B) {
          resWire := signExtend32To64(x32 >> shamtW)
        }.otherwise {
          resWire := io.x >> shamt
        }
      }
      // SRA : SRA/SRAI, SRAW/SRAIW
      is(getBOpcode(SRA).U) {
        when(isWord === true.B) {
          resWire := signExtend32To64(
            (x32.asSInt >> shamtW).asUInt
          )
        }.otherwise {
          resWire := (io.x.asSInt >> shamt).asUInt
        }
      }
      // OR : OR/ORI
      is(getBOpcode(OR).U) {
        resWire := (io.x | io.y)
      }
      // AND : AND/ADNI
      is(getBOpcode(AND).U) {
        resWire := (io.x & io.y)
      }
    }
  }

  io.result := resWire

  // **************** print **************** //
  if (DebugConfig.ALUIOPrint) {
    CPUPrintf.printfForIO(io, "")
    CPUPrintf.printfForIOArg(shamt, "")
    // CPUPrintf.printfForIOArg(combine, "")
  }
}
