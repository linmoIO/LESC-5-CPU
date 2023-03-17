package CPU.Componts

import chisel3._
import chiseltest._
import scala.math._

import org.scalatest.flatspec.AnyFlatSpec
import chiseltest.ChiselScalatestTester
import CPU.CPUConfig._

trait TestFunctionPCReg {

  def doTest(dut: PCReg, startAddress: Int) = {
    var lastPC = startAddress
    for (i <- 1 until 100) {
      dut.io.out.expect(lastPC.U)

      val PC = scala.util.Random.nextInt(pow(2, XLEN).toInt - 1)
      dut.io.in.poke(PC.U)
      dut.clock.step()
      lastPC = PC
    }
  }
}

class PCRegTester
    extends AnyFlatSpec
    with ChiselScalatestTester
    with TestFunctionPCReg {
  "Test" should "pass" in {
    val startAddress = 0x0
    test(new PCReg(startAddress)) { dut =>
      {
        doTest(dut, startAddress)
      }
    }
  }
}
