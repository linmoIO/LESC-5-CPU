package CPU.Componts

import chisel3._
import chisel3.util._

import CPU.CPUConfig._
import CPU._

/**
 * <b>[[指令to立即数转换器]]</b>
 * <p>
 * 根据 32 位指令生成对应 type 的立即数
 * <p>
 * [[input]]
 *   - inst : 来自 InstMemory 取出的指令, 完整的 32 位
 * <p>
 * [[output]]
 *   - imm : 根据 32 位指令生成的对应的符号扩展的立即数
 */
class Inst2ImmUnit extends Module {
  val io = IO(new Bundle {
    /* input */
    val inst = Input(UInt(INST_W.W))
    /* output */
    val imm = Output(UInt(XLEN.W))
  })

  val opcode = io.inst(6, 0) // get opcode, 用于判断 Type

  val immWire = WireDefault(0.U(64.W))

  switch(opcode) {
// format: off
    // I-Type : JALR Load I-Type(64) I-Type(32)
    is(InstKindWithCode.getBCode(InstKind.JALR).U) {
      immWire := Cat(Fill(63 - 10, io.inst(31)), io.inst(30,25), io.inst(24,21), io.inst(20))
    }
    is(InstKindWithCode.getBCode(InstKind.Load).U) {
      immWire := Cat(Fill(63 - 10, io.inst(31)), io.inst(30,25), io.inst(24,21), io.inst(20))
    }
    is(InstKindWithCode.getBCode(InstKind.IType).U) {
      immWire := Cat(Fill(63 - 10, io.inst(31)), io.inst(30,25), io.inst(24,21), io.inst(20))
    }
    is(InstKindWithCode.getBCode(InstKind.ITypeW).U) {
      immWire := Cat(Fill(63 - 10, io.inst(31)), io.inst(30,25), io.inst(24,21), io.inst(20))
    }

    // S-Type : Store
    is(InstKindWithCode.getBCode(InstKind.Store).U) {
      immWire := Cat(Fill(63 - 10, io.inst(31)), io.inst(30,25), io.inst(11,8), io.inst(7))
    }

    // B-Type : B-Type
    is(InstKindWithCode.getBCode(InstKind.BType).U) {
      immWire := Cat(Fill(63 - 11, io.inst(31)), io.inst(7), io.inst(30,25), io.inst(11,8), 0.U)
    }

    // U-Type : LUI AUIPC
    is(InstKindWithCode.getBCode(InstKind.LUI).U) {
      immWire := Cat(Fill(63 - 30, io.inst(31)), io.inst(30,20), io.inst(19,12), Fill(12, 0.U))
    }
    is(InstKindWithCode.getBCode(InstKind.AUIPC).U) {
      immWire := Cat(Fill(63 - 30, io.inst(31)), io.inst(30,20), io.inst(19,12), Fill(12, 0.U))
    }

    // J-Type : JAL
    is(InstKindWithCode.getBCode(InstKind.JAL).U) {
      immWire := Cat(Fill(63 - 19, io.inst(31)), io.inst(19,12), io.inst(20), io.inst(30,25), io.inst(24,21), 0.U)
    }
// format: on
  }

  io.imm := immWire

  val inst32 = io.inst(31, 0)

  // **************** print **************** //
  val needBinary = List(io.inst)
  val needDec = List(io.imm)
  val needHex = List()
  val needBool = io.getElements.filter(data => data.isInstanceOf[Bool]).toList

  if (DebugControl.Inst2ImmUnitIOPrint) {
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
