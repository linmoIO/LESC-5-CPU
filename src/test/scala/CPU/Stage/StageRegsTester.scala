package CPU.Stage

import chisel3._
import chiseltest._
import scala.math._

import org.scalatest.flatspec.AnyFlatSpec
import chiseltest.ChiselScalatestTester
import CPU.CPUConfig
import CPU.PiplineComponts._

trait IFIDTester {
  def randomTest(dut: IFIDStageRegs) = {
    for (i <- 1 until 10) {
      val stall = scala.util.Random.nextInt(2)
      dut.io.stall.poke(stall.U.asBool)
      val flush = scala.util.Random.nextInt(2)
      dut.io.flush.poke(flush.U.asBool)
      for (port <- dut.io.in.getElements) {
        val PC = scala.util.Random.nextInt(pow(2, CPUConfig.XLEN).toInt - 1)
        port.poke(PC.U)
      }
      dut.clock.step()
    }
  }
}

class StageRegsTester
    extends AnyFlatSpec
    with ChiselScalatestTester
    with IFIDTester {
  "Test" should "pass" in {
    test(new IFIDStageRegs) { dut =>
      randomTest(dut)
    }
  }
}
