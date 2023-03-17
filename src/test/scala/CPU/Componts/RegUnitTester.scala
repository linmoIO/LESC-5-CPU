package CPU.Componts

import chisel3._
import chiseltest._

import org.scalatest.flatspec.AnyFlatSpec
import chiseltest.ChiselScalatestTester

import chiseltest.iotesters.PeekPokeTester

import CPU.CPUConfig._

class RegUnitPeekPokeTester(dut: RegUnit) extends PeekPokeTester(dut) {
  private val regUnit = dut

  // 测试初始值
  for (i <- 0 to 31) {
    poke(regUnit.io.rs1, i)
    poke(regUnit.io.writeEnable, false)
    if (IF_RESERVE_STACK_SPACE && i == 2) {
      expect(regUnit.io.readDataRs1, STACK_SIZE.U, "初始值错误")
    } else {
      expect(regUnit.io.readDataRs1, 0.U, "初始值错误")
    }
    // print(peek(regUnit.io.readDataRs1).toInt.toString() + "\n")
    step(1)
  }

  // Write some data to registers
  for (i <- 0 to 31) {
    poke(regUnit.io.rd, i)
    poke(regUnit.io.writeData, i + 100)
    poke(regUnit.io.writeEnable, true)
    // RegUnit 不允许写时读, 否则会产生回环
    // // 测试写时读
    // poke(regUnit.io.rs1, i)
    // expect(
    //   regUnit.io.readDataRs1,
    //   i + 100,
    //   s"[rs1] : ${peek(regUnit.io.readDataRs1).toInt}, should be ${i + 100}"
    // )
    step(1)
  }

  // x0 寄存器不允许写入, 读出恒为0
  poke(regUnit.io.rs1, 0.U)
  poke(regUnit.io.rs2, 0.U)
  poke(regUnit.io.writeEnable, false)
  expect(regUnit.io.readDataRs1, 0.U, "x0 错误")
  expect(regUnit.io.readDataRs2, 0.U, "x0 错误")
  step(1)

  for (i <- 1 to 30 by 2) {
    println("Checking")
    poke(regUnit.io.rs1, i)
    poke(regUnit.io.rs2, i + 1)
    poke(regUnit.io.writeEnable, false)
    expect(
      regUnit.io.readDataRs1,
      i + 100,
      s"[rs1] ${i}: ${peek(regUnit.io.readDataRs1).toInt}, should be ${i + 100}"
    )
    expect(
      regUnit.io.readDataRs2,
      i + 101,
      s"[rs2] ${i + 1}: ${peek(regUnit.io.readDataRs2).toInt}, should be ${i + 101}"
    )
    step(1)
  }
}

class RegUnitTester extends AnyFlatSpec with ChiselScalatestTester {
  "Test" should "pass" in {
    test(new RegUnit()).runPeekPoke(new RegUnitPeekPokeTester(_))
  }
}
