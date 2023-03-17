package CPU.Componts

import chisel3._
import chiseltest._

import org.scalatest.flatspec.AnyFlatSpec
import chiseltest.ChiselScalatestTester

trait TestFuncControlUnit {
  def doTestFromDINO(dut: ControlUnit) = {
    val tests = List(
// format: off
      // Inputs,      itype, aluop, src1, src2, branch, jumptype, resultselect, memop, toreg, regwrite, validinst, wordinst
      ( "b0110011",   0  ,   1  ,  0  ,  0  ,    0  ,      0  ,          0  ,   0  ,   0  ,      1  ,       1  ,      0  ), // R-type
      ( "b0111011",   0  ,   1  ,  0  ,  0  ,    0  ,      0  ,          0  ,   0  ,   0  ,      1  ,       1  ,      1  ), // R-type 32-bit
      ( "b0010011",   1  ,   1  ,  0  ,  1  ,    0  ,      0  ,          0  ,   0  ,   0  ,      1  ,       1  ,      0  ), // I-type
      ( "b0011011",   1  ,   1  ,  0  ,  1  ,    0  ,      0  ,          0  ,   0  ,   0  ,      1  ,       1  ,      1  ), // I-type 32-bit
      ( "b0000011",   0  ,   0  ,  0  ,  1  ,    0  ,      0  ,          0  ,   2  ,   1  ,      1  ,       1  ,      0  ), // Load
      ( "b0100011",   0  ,   0  ,  0  ,  1  ,    0  ,      0  ,          0  ,   3  ,   0  ,      0  ,       1  ,      0  ), // Store
      ( "b1100011",   0  ,   0  ,  0  ,  0  ,    1  ,      0  ,          0  ,   0  ,   0  ,      0  ,       1  ,      0  ), // Branch
      ( "b0110111",   0  ,   0  ,  0  ,  0  ,    0  ,      0  ,          1  ,   0  ,   0  ,      1  ,       1  ,      0  ), // lui
      ( "b0010111",   0  ,   0  ,  1  ,  1  ,    0  ,      0  ,          0  ,   0  ,   0  ,      1  ,       1  ,      0  ), // auipc
      ( "b1101111",   0  ,   0  ,  0  ,  2  ,    0  ,      2  ,          0  ,   0  ,   0  ,      1  ,       1  ,      0  ), // jal
   // ( "b1100111",   0  ,   0  ,  1  ,  2  ,    0  ,      3  ,          0  ,   0  ,   0  ,      1  ,       1  ,      0  )  // jalr
      ( "b1100111",   0  ,   0  ,  0  ,  1  ,    0  ,      3  ,          0  ,   0  ,   0  ,      1  ,       1  ,      0  )  // jalr
   // ( "b1100111",   0  ,   0  ,  1  ,  2  ,    0  ,      3  ,          0  ,   0  ,   0  ,      1  ,       1  ,      0  )  // jalr

// format: on
    )

    for (t <- tests) {
      dut.io.opcode.poke(t._1.toString.U)
      // print(t.toString + "\n")
      dut.clock.step()

      dut.io.isIType.expect(t._2.asUInt.asBool)
      if (t._2 == 1)
        dut.io.isRType.expect(0.U.asBool)
      else
        dut.io.isRType.expect(t._3.asUInt.asBool)
      dut.io.pcRs1ToALU.expect(t._4.asUInt.asBool)
      dut.io.immRs2ToALU.expect((t._5 % 2).asUInt.asBool)
      dut.io.isBType.expect(t._6.asUInt.asBool)
      dut.io.isJump.expect((t._7 / 2).asUInt.asBool)
      dut.io.immALUToReg.expect(t._8.asUInt.asBool)
      dut.io.memRead.expect((t._9 == 2).asBool)
      dut.io.memWrite.expect((t._9 == 3).asBool)
      // dut.io.memValid.expect((t._9 / 2).asUInt.asBool)
      dut.io.memRead.expect(t._10.asUInt.asBool)
      dut.io.ifWriteToReg.expect(t._11.asUInt.asBool)
      dut.io.isValidInst.expect(t._12.asUInt.asBool)
      dut.io.isWord.expect(t._13.asUInt.asBool)
    }
  }
}

class ControlUnitTester
    extends AnyFlatSpec
    with ChiselScalatestTester
    with TestFuncControlUnit {
  "Test" should "pass" in {
    test(new ControlUnit()) { dut =>
      {
        doTestFromDINO(dut)
      }
    }
  }
}
