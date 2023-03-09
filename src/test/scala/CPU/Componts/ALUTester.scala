package CPU.Componts

import chisel3._
import chiseltest._

import chiseltest.iotesters.PeekPokeTester
import org.scalatest.flatspec.AnyFlatSpec
import chiseltest.ChiselScalatestTester

import scala.util._

// dino : isWord|Opcode
// my : Opcode|isWord|isBType
object aluOperationCodeDino2My {
  val dino2My = Map(
    "b00010" -> "b000000", // add
    "b10010" -> "b000010", // addw
    "b00011" -> "b000100", // sub
    "b10011" -> "b000110", // subw
    "b01001" -> "b001000", // sll
    "b11001" -> "b001010", // sllw
    "b01000" -> "b010000",
    "b00101" -> "b011000",
    "b00110" -> "b100000",
    "b00111" -> "b101000", // srl
    "b10111" -> "b101010", // srlw
    "b00100" -> "b101100", // sra
    "b10100" -> "b101110", // sraw
    "b00001" -> "b110000",
    "b00000" -> "b111000",

    // B-type
    "b01101" -> "b000000",
    "b01110" -> "b001000",
    // "b01000" -> "b100001",
    "b01011" -> "b101000",
    // "b00101" -> "110001",
    "b01100" -> "b111000"
  )

  def getDino2MyOpcodeB(dinoOp: String) = {
    val res = dino2My.getOrElse(dinoOp, "b000000")
    print(s"dino : ${dinoOp}, my : ${res}\n")
    res.U
  }
}

class ALURandomUnitTester(c: ALU) extends PeekPokeTester(c) {
  private val alu = c

  val maxInt = BigInt("FFFFFFFFFFFFFFFF", 16)

  def test(op: String, f: (BigInt, BigInt) => BigInt) = {
    for (i <- 0 until 10) {
      val x = Random.nextInt(100000000)
      val y = Random.nextInt(500000000)

      poke(
        alu.io.aluOperation,
        aluOperationCodeDino2My.getDino2MyOpcodeB(op)
      )
      poke(alu.io.x, x)
      poke(alu.io.y, y)
      step(1)
      val expectOut = f(x, y).toLong & maxInt
      expect(
        alu.io.result,
        expectOut,
        s"for operation ${op}, inputx: ${x.toBinaryString}, inputy: ${y.toBinaryString}, wrong result :${peek(
            alu.io.result
          ).toInt.toBinaryString}, should be :${expectOut.toInt.toBinaryString}\n"
      )
    }
  }

  def twoscomp(v: BigInt): BigInt = {
    if (v < 0) {
      return maxInt + v + 1
    } else {
      return v
    }
  }

  def to32bit(v: BigInt): BigInt = {
    return v & BigInt("FFFFFFFF", 16)
  }

  def signExtend32bitTo64bit(v: BigInt): BigInt = {
    val signBit = (v >> 31) & 1
    val bitMask32 = BigInt("FFFFFFFF", 16)
    if (signBit == 0) {
      return v & bitMask32 // we only keep the lower half since the upper half must be all zeros
    } else {
      return v | (bitMask32 << 32) // the upper half must be all ones, the lower half must be preserved
    }
  }

  test("b00000", (x: BigInt, y: BigInt) => (x & y))
  test("b00001", (x: BigInt, y: BigInt) => (x | y))
  test("b00010", (x: BigInt, y: BigInt) => (x + y))
  test(
    "b10010",
    (x: BigInt, y: BigInt) => (signExtend32bitTo64bit(to32bit(x) + to32bit(y)))
  ) // 32-bit operands
  test("b00011", (x: BigInt, y: BigInt) => twoscomp(x - y))
  test(
    "b10011",
    (x: BigInt, y: BigInt) =>
      (signExtend32bitTo64bit(twoscomp(to32bit(x) - to32bit(y))))
  ) // 32-bit operands
  test("b00100", (x: BigInt, y: BigInt) => (x >> (y.toInt & 0x3f)))
  test(
    "b10100",
    (x: BigInt, y: BigInt) =>
      (signExtend32bitTo64bit(to32bit(x) >> (y.toInt & 0x1f)))
  ) // 32-bit operands
  test("b00101", (x: BigInt, y: BigInt) => (if (x < y) 1 else 0))
  test("b00110", (x: BigInt, y: BigInt) => (x ^ y))
  test("b00111", (x: BigInt, y: BigInt) => (x >> (y.toInt & 0x3f)))
  test(
    "b10111",
    (x: BigInt, y: BigInt) =>
      (signExtend32bitTo64bit(to32bit(x) >> (y.toInt & 0x1f)))
  ) // 32-bit operands
  test("b01000", (x: BigInt, y: BigInt) => (if (x < y) 1 else 0))
  test("b01001", (x: BigInt, y: BigInt) => (x << (y.toInt & 0x3f)))
  test(
    "b11001",
    (x: BigInt, y: BigInt) =>
      (signExtend32bitTo64bit(to32bit(x) << (y.toInt & 0x1f)))
  ) // 32-bit operands
  // nor 操作
  //   test("b01010", (x: BigInt, y: BigInt) => twoscomp(~(x | y)))
}

class ALUDirectedUnitTester(c: ALU) extends PeekPokeTester(c) {
  private val alu = c
  val maxInt = BigInt("FFFFFFFFFFFFFFFF", 16)

  def twoscomp(v: BigInt): BigInt = {
    if (v < 0) {
      return maxInt + v + 1
    } else {
      return v
    }
  }

  // signed <
  poke(
    alu.io.aluOperation,
    aluOperationCodeDino2My.getDino2MyOpcodeB("b01000")
  )

  poke(alu.io.x, twoscomp(-1))
  poke(alu.io.y, 1)
  step(1)
  expect(
    alu.io.result,
    1,
    s"for operation signed <; inputx: ${twoscomp(-1)}; inputy: ${1}"
  )

  // unsigned <
  poke(
    alu.io.aluOperation,
    aluOperationCodeDino2My.getDino2MyOpcodeB("b00101")
  )
  poke(alu.io.x, maxInt)
  poke(alu.io.y, 1)
  step(1)
  expect(
    alu.io.result,
    0,
    s"for operation unsigned <; inputx: ${maxInt}; inputy: ${1}"
  )

  // signed >>
  poke(
    alu.io.aluOperation,
    aluOperationCodeDino2My.getDino2MyOpcodeB("b00100")
  )
  poke(alu.io.x, twoscomp(-1024))
  poke(alu.io.y, 5)
  step(1)
  expect(
    alu.io.result,
    twoscomp(-32),
    s"for operation unsigned <; inputx: ${twoscomp(-1024)}; inputy: ${5}"
  )
}

class ALUTester extends AnyFlatSpec with ChiselScalatestTester {
  "ALU" should s"match expectations for random tests" in {
    test(new ALU()).runPeekPoke(new ALURandomUnitTester(_))
  }
  "ALU" should s"match expectations for directed edge tests" in {
    test(new ALU()).runPeekPoke(new ALUDirectedUnitTester(_))
  }
}
