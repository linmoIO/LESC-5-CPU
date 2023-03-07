package CPU.Componts

import chisel3._
import chisel3.util._
import chiseltest._

import org.scalatest.flatspec.AnyFlatSpec
import chiseltest.ChiselScalatestTester

trait TestFuncInst2ImmUnit {
  def doTest(dut: Inst2ImmUnit) = {
    val instList = Seq(
      "h011110b7".U -> "h0000000001111000".U,
      "h02222117".U -> "h0000000002222000".U,
      "h004001ef".U -> "h0000000000000004".U,
      "h00418267".U -> "h0000000000000004".U,
      "h00628263".U -> "h0000000000000004".U,
      "h00209263".U -> "h0000000000000004".U,
      "h0020c263".U -> "h0000000000000004".U,
      "h0020d263".U -> "h0000000000000004".U,
      "h0020e263".U -> "h0000000000000004".U,
      "h0020f263".U -> "h0000000000000004".U,
      "h00410083".U -> "h0000000000000004".U,
      "h00811083".U -> "h0000000000000008".U,
      "h00412083".U -> "h0000000000000004".U,
      "h00814083".U -> "h0000000000000008".U,
      "h00c15083".U -> "h000000000000000c".U,
      "h00108223".U -> "h0000000000000004".U,
      "h00109223".U -> "h0000000000000004".U,
      "h0010a223".U -> "h0000000000000004".U,
      "h00408093".U -> "h0000000000000004".U,
      "h0040a093".U -> "h0000000000000004".U,
      "h0040b093".U -> "h0000000000000004".U,
      "h0040c093".U -> "h0000000000000004".U,
      "h0040e093".U -> "h0000000000000004".U,
      "h0040f093".U -> "h0000000000000004".U,
      "h00409093".U -> "h0000000000000004".U,
      "h0040d093".U -> "h0000000000000004".U,
      "h4040d093".U -> "h0000000000000404".U,
      "h002080b3".U -> "h0000000000000000".U,
      "h402080b3".U -> "h0000000000000000".U,
      "h002090b3".U -> "h0000000000000000".U,
      "h0020a0b3".U -> "h0000000000000000".U,
      "h0020b0b3".U -> "h0000000000000000".U,
      "h0020c0b3".U -> "h0000000000000000".U,
      "h0020d0b3".U -> "h0000000000000000".U,
      "h4020d0b3".U -> "h0000000000000000".U,
      "h0020e0b3".U -> "h0000000000000000".U,
      "h0020f0b3".U -> "h0000000000000000".U
    )
    for (t <- instList) {
      dut.io.inst.poke(t._1)
      dut.clock.step()

      dut.io.imm.expect(t._2, s"[ERROR] ${t._1}")
    }
  }
}

class Inst2ImmUnitTester
    extends AnyFlatSpec
    with ChiselScalatestTester
    with TestFuncInst2ImmUnit {
  "Test" should "pass" in {
    test(new Inst2ImmUnit()) { dut => doTest(dut) }
  }
}
