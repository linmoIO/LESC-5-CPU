package CPU.CPUTester

import chisel3._
import chiseltest._
import chisel3.util._

import org.scalatest.flatspec.AnyFlatSpec
import chiseltest.ChiselScalatestTester

import CPU._
import CPU.CPUUtils.stringFixUpToN
import CPU.CPUUtils.splitHexFile
import CPU.CPUConfig._
import java.io.PrintWriter
import java.io.File
import java.io.FileInputStream
import java.io.FileOutputStream
import firrtl.FileUtils

import CPU.PiplineCPU.PiplineCPU

trait TestFuncPiplineCPU {

  /* 控制信号 */
  val printToFile = true // 是否打印到文件
  val timeOut = 100000 // 超时, 以周期为单位, 0 表示无限制
  val begin = 0 // 开始完全输出的起始周期
  val end = 0 // 结束完全输出的结束周期, 0 表示不会结束
  val printInstPC = true // 是否由 Tester 打印指令和 PC
  val printReg = DebugControl.RegPrint // 是否打印 32 个寄存器状态
  var printAll = true // 是否由 Tester 打印 CPU 的详细信息

  def testFn(dut: PiplineCPU, myPrint: Any => Unit) = {
    var i = 1 // 当前周期数

    myPrint(s"[INFO] 开始测试 ${dut.name}\n")

    dut.clock.setTimeout(timeOut) // 设置超时

    // dut.clock.step(1)

    while (
      (dut.io.ifInst.peekInt() != 0 || dut.io.idInst
        .peekInt() != 0 || dut.io.exeInst.peekInt() != 0 || dut.io.memInst
        .peekInt() != 0 || dut.io.wbInst.peekInt() != 0)
    ) {
      val errorPrefix = s"[ERROR] 当前为第 ${i} 个周期, " // 打印的前缀信息

      // // 指令应该恒有效
      // dut.io.isValidInst
      //   .expect(true.B, errorPrefix + s"指令 0x${Hexadecimal(dut.io.inst)} 无效")

      val ifInstB =
        stringFixUpToN(dut.io.ifInst.peekInt().toLong.toBinaryString, 32)
      def getKind(port: UInt) = {
        InstKindWithCode.getInstKind(
          stringFixUpToN(
            (port.peekInt() & 0x7f).toLong.toBinaryString,
            7
          )
        )
      }
      val ifInstKind = getKind(dut.io.ifInst)
      val idInstKind = getKind(dut.io.idInst)
      val exeInstKind = getKind(dut.io.exeInst)
      val memInstKind = getKind(dut.io.memInst)
      val wbInstKind = getKind(dut.io.wbInst)

      if (printInstPC || printAll) {
        myPrint("————————————————— [ CPU - INFO ] ——————————————————\n")

        myPrint(
          s"[Brief] : "
            + s"PC = 0x${dut.io.ifPC.peekInt().toLong.toHexString}, "
            + s"Next PC = 0x${dut.io.nextPC.peekInt().toLong.toHexString}, "
            + s"第 ${i} 个时钟周期\n"
            + s"\tINST = 0x${stringFixUpToN(dut.io.ifInst.peekInt().toLong.toHexString, INST_W / 8)}  (${ifInstKind})\n"
            + s"\t     = ${ifInstB.substring(0, 7) + " " + ifInstB.substring(7, 12) + " " + ifInstB
                .substring(12, 17) + " " + ifInstB.substring(17, 20) + " " + ifInstB
                .substring(20, 25) + " " + ifInstB.substring(25)}\n"
            + "\n"
        )
      }
      def printStage(
          stageName: String,
          pc: UInt,
          inst: UInt,
          instKind: Any
      ) = {
        myPrint(
          s"==== [ ${stageName} ] ==== "
            + s"[PC = 0x${pc.peekInt().toLong.toHexString}, "
            + s"INST = 0x${stringFixUpToN(inst.peekInt().toLong.toHexString, INST_W / 8)} (${instKind})]\n"
        )
      }
      if (printAll && i > begin && (i < end || end == 0)) {
        printStage("ID", dut.io.idPC, dut.io.idInst, idInstKind)
        // --------------- 寄存器 --------------------------
        val rs1 = dut.io.rs1.peekInt().toLong.toInt
        val rs1Name = RegNameWithNum.getRegName(rs1)
        val rs2 = dut.io.rs2.peekInt().toLong.toInt
        val rs2Name = RegNameWithNum.getRegName(rs2)
        val rd = dut.io.rd.peekInt().toLong.toInt
        val rdName = RegNameWithNum.getRegName(rd)

        myPrint(
          s"[寄存器] : \n"
            + s"\trs1 : 从 ${rs1}(${rs1Name}) 中读出数据 ${dut.io.readDataRs1
                .peekInt()
                .toLong}  (0x${dut.io.readDataRs1.peekInt().toLong.toHexString}) \n"
            + s"\trs2 : 从 ${rs2}(${rs2Name}) 中读出数据 ${dut.io.readDataRs2
                .peekInt()
                .toLong}  (0x${dut.io.readDataRs2.peekInt().toLong.toHexString}) \n"
        )
        if (dut.io.ifWriteToReg.peekBoolean()) {
          myPrint(
            s"\trd  : 往 ${rd}(${rdName}) 中写入数据 ${dut.io.resultToReg
                .peekInt()
                .toLong}  (0x${dut.io.resultToReg.peekInt().toLong.toHexString}) \n"
              + "\n"
          )
        } else { myPrint(s"\t不写入寄存器\n\n") }

        if (printReg) {
          myPrint(s"[寄存器状态] : \n")
          for (i <- 0 until 32) {
            val regData = dut.io.regAll(i).peekInt().toLong
            myPrint(
              s"${i}(${RegNameWithNum.getRegName(i)}) : ${regData} (0x${regData.toHexString})\t"
            )
            if ((i + 1) % 4 == 0) {
              myPrint("\n")
            }
          }
          myPrint("\n")
        }

        // --------------- 立即数 --------------------------
        myPrint(
          s"[Immediate] : ${dut.io.imm.peekInt().toLong}  (0x${dut.io.imm.peekInt().toLong.toHexString}) \n\n"
        )

        printStage("EXE", dut.io.exePC, dut.io.exeInst, exeInstKind)
        // --------------- ALU --------------------------
        val aluCode = stringFixUpToN(
          dut.io.aluOperation.peekInt().toLong.toBinaryString,
          ALU_OPERATION_W
        )
        val aluOp =
          ALUOpWithCode.getALUOp(
            aluCode.substring(0, 4),
            dut.io.isBType.peekBoolean()
          )
        val aluXS =
          if (dut.io.pcRs1ToALU.peekBoolean()) "ALU.x from PC"
          else "ALU.x from Rs1"
        val aluYS =
          if (dut.io.immRs2ToALU.peekBoolean()) "ALU.y from imm"
          else "ALU.y from Rs2"

        myPrint(
          s"[ALU] : "
            + s"opcode = ${aluCode} (${aluOp}),"
            + s" B-Type = ${dut.io.isBType.peekInt()}, Word = ${dut.io.isWord.peekInt()}\n"
            + s"\t${aluXS}, \tx = ${dut.io.aluX.peekInt().toLong} (0x${dut.io.aluX.peekInt().toLong.toHexString}) \n"
            + s"\t${aluYS}, \ty = ${dut.io.aluY.peekInt().toLong} (0x${dut.io.aluY.peekInt().toLong.toHexString}) \n"
            + s"\tresult = ${dut.io.aluResult.peekInt().toLong}  (0x${dut.io.aluResult.peekInt().toLong.toHexString}) \n"
            + "\n"
        )

        // --------------- PC选择器 --------------------------
        myPrint(
          s"[PC 选择器] : "
            + s"JALR = ${dut.io.isJALR.peekInt()}, B-Type = ${dut.io.isBType
                .peekInt()}, Jump = ${dut.io.isJump
                .peekInt()}, isTrue = ${dut.io.isTrue.peekInt()}\n"
            + s"\t选出的 next PC 结果为 0x${dut.io.nextPC.peekInt().toLong.toHexString}\n"
            + "\n"
        )

        printStage("MEM", dut.io.memPC, dut.io.memInst, memInstKind)
        // --------------- 内存 --------------------------
        myPrint(
          s"[内存] : "
            + s"read = ${dut.io.memRead.peekInt()}, memWrite = ${dut.io.memWrite.peekInt()}, "
            + s"bit-type = ${stringFixUpToN(dut.io.bitType.peekInt().toLong.toBinaryString, 2)}, unsigned = ${dut.io.isUnsigned.peekInt()}\n"
        )
        if (dut.io.memWrite.peekBoolean()) {
          myPrint(
            s"\t向内存 0x${dut.io.address.peekInt().toLong.toHexString} 中写入数据\t ${dut.io.writeData
                .peekInt()
                .toLong}  (0x${dut.io.writeData.peekInt().toLong.toHexString}) \n"
          )
        } else if (dut.io.memRead.peekBoolean()) {
          myPrint(
            s"\t从内存 0x${dut.io.aluResult.peekInt().toLong.toHexString} 中读出数据\t ${dut.io.readData
                .peekInt()
                .toLong}  (0x${dut.io.readData.peekInt().toLong.toHexString}) \n"
          )
        }
        if (!dut.io.memWrite.peekBoolean() && !dut.io.memRead.peekBoolean()) {
          myPrint("\t无操作\n")
        }
        myPrint("\n")

        printStage("WB", dut.io.wbPC, dut.io.wbInst, wbInstKind)
        // --------------- Res 选择器 --------------------------
        myPrint(
          s"[Res 选择器] : "
            + s"Jump = ${dut.io.isJump.peekInt()}, Imm|ALU = ${dut.io.immALUToReg
                .peekInt()}, memRead = ${dut.io.memRead.peekInt()}\n"
            + s"\t选出的 Res 结果为 ${dut.io.resultToReg.peekInt().toLong}  (0x${dut.io.resultToReg.peekInt().toLong.toHexString}) \n"
            + "\n"
        )

        myPrint("———————————————————————————————————————————————————\n")
      }
      dut.clock.step(1)
      i = i + 1
    }

    myPrint(s"[SUCCESS] ${dut.name} 所有指令执行结束\n")
  }
}

class PiplineCPUTester
    extends AnyFlatSpec
    with ChiselScalatestTester
    with TestcaseSet
    with TestFuncPiplineCPU {

  "CPU" should "pass" in {
    // sbt "testOnly CPU.CPUTester.PiplineCPUTester" > src/test/hex/fibonacci/pipline_stage.log

    for (testcasePair <- testcases) {
      val dir = s"${System
          .getProperty("user.dir")}/${testcasePair._1}"
      val fileName = testcasePair._2
      val startAddress = testcasePair._3

      val instDir = s"${dir}/inst"
      val dataDir = s"${dir}/data"
      val instPath = s"${instDir}/${fileName}.hex"
      val dataPath = s"${dataDir}/${fileName}.hex"

      // 对指令文件进行处理
      // 查看指令文件是否存在
      val instFile = new File(instPath)
      if (!instFile.exists()) {
        println(s"[ERROR] 指令文件 ${instPath} 不存在")
      }

      // 对 hex 文件进行分割
      splitHexFile(instDir, fileName, INST_BYTE)

      println(s"[INFO] 成功在 ${dir} 生成指令 hex 文件 : ${fileName}")

      // 对数据文件进行处理
      var needData = false
      val dataFile = new File(dataPath)
      if (dataFile.exists()) {
        // 若存在数据文件, 则处理
        // 对 hex 文件进行分割
        splitHexFile(dataDir, fileName, DATA_BYTE)

        println(s"[INFO] 成功在 ${dir} 生成数据 hex 文件 : ${fileName}")
        needData = true
      }

      println(s"[INFO] 开始地址为 0x${startAddress.toHexString}")

      var myPrint: Any => Unit = print
      var outFile: PrintWriter = null

      if (printToFile) {
        val filePath = s"${dir}/${fileName}_pipline.log"
        println(s"[INFO] 将 CPU 输出信息写入到 ${filePath} 中")

        outFile = new PrintWriter(filePath)
        myPrint = outFile.print
      }

      val dataPathFinal = if (needData) dataPath else ""
      test(new PiplineCPU(instPath, dataPathFinal, startAddress)) { dut =>
        testFn(dut, myPrint)
      }

      if (printToFile && outFile != null) {
        outFile.close()
      }
    }
  }
}
