package CPU.Componts

import chisel3._
import chiseltest._

import org.scalatest.flatspec.AnyFlatSpec
import chiseltest.ChiselScalatestTester

import chiseltest.iotesters.PeekPokeTester

class RegUnitPeekPokeTester(dut: RegUnit) extends PeekPokeTester(dut) {
  private val regUnit = dut

  // Write some data to registers
  for (i <- 0 to 31) {
    poke(regUnit.io.rd, i)
    poke(regUnit.io.writeData, i + 100)
    poke(regUnit.io.writeEnable, true)
    step(1)
  }

  for (i <- 0 to 31 by 2) {
    println("Checking")
    poke(regUnit.io.rs1, i)
    poke(regUnit.io.rs2, i + 1)
    poke(regUnit.io.writeEnable, false)
    expect(
      regUnit.io.readDataRs1,
      i + 100,
      s"[rs1] : ${peek(regUnit.io.readDataRs1).toInt}, should be ${i + 100}"
    )
    expect(
      regUnit.io.readDataRs2,
      i + 101,
      s"[rs2] : ${peek(regUnit.io.readDataRs2).toInt}, should be ${i + 101}"
    )
    step(1)
  }
}

class RegUnitTester extends AnyFlatSpec with ChiselScalatestTester {
  "Test" should "pass" in {
    test(new RegUnit()).runPeekPoke(new RegUnitPeekPokeTester(_))
  }
}
