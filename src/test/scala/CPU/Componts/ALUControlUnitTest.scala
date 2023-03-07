package CPU.Componts

import chisel3._
import chiseltest._
import chisel3.util._

import org.scalatest.flatspec.AnyFlatSpec
import chiseltest.ChiselScalatestTester
import scala.annotation.meta.companionObject

trait TestFunctionALUControlUnitTest {
  def doTest(dut: ALUControlUnit) = {
    doTestWord(dut, false) // 无 *W 测试
    doTestWord(dut, true) // 含 *W 测试
  }
  def doTestWord(dut: ALUControlUnit, testWord: Boolean) = {
    // Copied from Patterson and Waterman Figure 2.3
    val tests = List(
// format: off
    // aluop,   imm,      Funct7,     Func3,   Control Input
    (  0, false.B, "b0000000".U, "b000".U, "0010", "load/store"),
    (  0, false.B, "b1111111".U, "b111".U, "0010", "load/store"),
    (  0, false.B, "b0000000".U, "b000".U, "0010", "load/store"),
    (  2, false.B, "b0000000".U, "b000".U, "0010", "add"),
    (  2, false.B, "b0100000".U, "b000".U, "0011", "sub"),
    (  2, false.B, "b0000000".U, "b001".U, "1001", "sll"),
    (  2, false.B, "b0000000".U, "b010".U, "1000", "slt"),
    (  2, false.B, "b0000000".U, "b011".U, "0101", "sltu"),
    (  2, false.B, "b0000000".U, "b100".U, "0110", "xor"),
    (  2, false.B, "b0000000".U, "b101".U, "0111", "srl"),
    (  2, false.B, "b0100000".U, "b101".U, "0100", "sra"),
    (  2, false.B, "b0000000".U, "b110".U, "0001", "or"),
    (  2, false.B, "b0000000".U, "b111".U, "0000", "and"),
    (  2, true.B,  "b0000000".U, "b000".U, "0010", "addi"),
    (  2, true.B,  "b0000000".U, "b010".U, "1000", "slti"),
    (  2, true.B,  "b0000000".U, "b011".U, "0101", "sltiu"),
    (  2, true.B,  "b0000000".U, "b100".U, "0110", "xori"),
    (  2, true.B,  "b0000000".U, "b110".U, "0001", "ori"),
    (  2, true.B,  "b0000000".U, "b111".U, "0000", "andi"),
    (  2, true.B,  "b0000000".U, "b001".U, "1001", "slli"),
    (  2, true.B,  "b0000000".U, "b101".U, "0111", "srli"),
    (  2, true.B,  "b0100000".U, "b101".U, "0100", "srai"),
    (  1, false.B, "b0000000".U, "b000".U, "1101", "beq"),
    (  1, false.B, "b0000000".U, "b001".U, "1110", "bne"),
    (  1, false.B, "b0000000".U, "b100".U, "1000", "blt"),
    (  1, false.B, "b0000000".U, "b101".U, "1011", "bge"),
    (  1, false.B, "b0000000".U, "b110".U, "0101", "bltu"),
    (  1, false.B, "b0000000".U, "b111".U, "1100", "bgeu")
// format: on
    )

    for (t <- tests) {
      var isWord = 0
      if (wInst.contains(t._6) && testWord) {
        // test for *W
        isWord = 1
      } else {
        isWord = 0
      }
      dut.io.isWord.poke(isWord.U.asBool)
      dut.io.isBType.poke((t._1 % 2).U.asBool)
      if (t._2 == 1)
        dut.io.isRType.poke(0.U.asBool)
      else
        dut.io.isRType.poke((t._1 / 2).U.asBool)
      dut.io.funct7.poke(t._3)
      dut.io.funct3.poke(t._4)

      dut.clock.step()

      val opcode =
        getDino2MyBOpcode(t._5, (t._1 % 2 == 1)) + isWord
          .toString() + (t._1 % 2)
          .toString()

      print(s"\n${t._6} : ${opcode}\n")

      dut.io.aluOperation
        .expect(
          opcode.asUInt,
          s"${t._6} wrong"
        )
    }
  }

  val dino2My = Map(
    "0010" -> "0000",
    "0011" -> "0001",
    "1001" -> "0010",
    "1000" -> "0100",
    "0101" -> "0110",
    "0110" -> "1000",
    "0111" -> "1010",
    "0100" -> "1011",
    "0001" -> "1100",
    "0000" -> "1110"
  )

  val dino2MyBType = Map(
    // B-type
    "1101" -> "0000",
    "1110" -> "0010",
    "1000" -> "1000",
    "1011" -> "1010",
    "0101" -> "1100",
    "1100" -> "1110"
  )

  def getDino2MyBOpcode(dinoOp: String, isBType: Boolean) = {
    if (isBType)
      "b".appendedAll(dino2MyBType.getOrElse(dinoOp, "0000"))
    else
      "b".appendedAll(dino2My.getOrElse(dinoOp, "0000"))
  }

  val wInst =
    Set("addi", "slli", "srli", "srai", "add", "sub", "sll", "srl", "sra")
}

class ALUControlUnitTest
    extends AnyFlatSpec
    with ChiselScalatestTester
    with TestFunctionALUControlUnitTest {
  "Test" should "pass" in {
    test(new ALUControlUnit()) { dut => doTest(dut) }
  }
}
