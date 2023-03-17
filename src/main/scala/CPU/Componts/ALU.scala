package CPU.Componts

import chisel3._
import chisel3.util.switch
import chisel3.util._

import CPU._
import CPU.ALUOpWithCode._
import CPU.ALUOp._
import CPU.CPUConfig._
import CPU.CPUUtils._

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
  val combine = io.aluOperation(5, 2) // 4 位操作码
  val isWord = io.aluOperation(1).asBool // 是否为 *W 指令
  val isBType = io.aluOperation(0).asBool // 是否为 Branch 类型

  // 针对 Word 指令
  val x32 = io.x(31, 0)
  val y32 = io.y(31, 0)

  // 移位量
  val shamt = io.y(SHAMT_W - 1, 0) // 6位
  val shamtW = io.y(SHAMT_W - 2, 0) // 5位

  val resWire = WireDefault(io.x +& io.y) // 结果总线

  when(isBType === true.B) { // B-Type
    switch(combine) {
      // BEQ
      is(getBCode(BEQ).U) {
        resWire := io.x === io.y
      }
      // BNE
      is(getBCode(BNE).U) {
        resWire := io.x =/= io.y
      }
      // BLT
      is(getBCode(BLT).U) {
        resWire := (io.x.asSInt < io.y.asSInt).asUInt
      }
      // BGE
      is(getBCode(BGE).U) {
        resWire := (io.x.asSInt >= io.y.asSInt).asUInt
      }
      // BLTU
      is(getBCode(BLTU).U) {
        resWire := (io.x < io.y)
      }
      // BGEU
      is(getBCode(BGEU).U) {
        resWire := (io.x >= io.y)
      }
    }
  }.otherwise { // R-Type / I-Type
    switch(combine) {
      // ADD : ADD/ADDI, ADDW/ADDIW
      is(getBCode(ADD).U) {
        when(isWord === true.B) {
          resWire := signExtend32To64(x32 + y32)
        }.otherwise {
          resWire := io.x + io.y
        }
      }
      // SUB : SUB, SUBW
      is(getBCode(SUB).U) {
        when(isWord === true.B) {
          resWire := signExtend32To64(x32 - y32)
        }.otherwise {
          resWire := io.x - io.y
        }
      }
      // SLL : SLL/SLLI, SLLW/SLLIW
      is(getBCode(SLL).U) {
        when(isWord === true.B) {
          resWire := signExtend32To64(x32 << shamtW)
        }.otherwise {
          resWire := io.x << shamt
        }
      }
      // SLT : SLT/SLTI
      is(getBCode(SLT).U) {
        resWire := (io.x.asSInt < io.y.asSInt).asUInt
      }
      // SLTU : SLTU/SLTIU
      is(getBCode(SLTU).U) {
        resWire := (io.x < io.y)
      }
      // XOR : XOR/XORI
      is(getBCode(XOR).U) {
        resWire := (io.x ^ io.y)
      }
      // SRL : SRL/SRLI, SRLW/SRLIW
      is(getBCode(SRL).U) {
        when(isWord === true.B) {
          resWire := signExtend32To64(x32 >> shamtW)
        }.otherwise {
          resWire := io.x >> shamt
        }
      }
      // SRA : SRA/SRAI, SRAW/SRAIW
      is(getBCode(SRA).U) {
        when(isWord === true.B) {
          resWire := signExtend32To64(
            (x32.asSInt >> shamtW).asUInt
          )
        }.otherwise {
          resWire := (io.x.asSInt >> shamt).asUInt
        }
      }
      // OR : OR/ORI
      is(getBCode(OR).U) {
        resWire := (io.x | io.y)
      }
      // AND : AND/ADNI
      is(getBCode(AND).U) {
        resWire := (io.x & io.y)
      }
    }
  }

  io.result := resWire

  // **************** print **************** //
  val needBinary = List(io.aluOperation)
  val needDec = List(io.result, io.x, io.y)
  val needHex = List()
  val needBool = io.getElements.filter(data => data.isInstanceOf[Bool]).toList

  if (DebugControl.ALUIOPrint) {
    CPUPrintf.printfIO(
      "INFO",
      this,
      io.getElements.toList,
      needBinary,
      needDec,
      needHex,
      needBool
    )
  }
}
