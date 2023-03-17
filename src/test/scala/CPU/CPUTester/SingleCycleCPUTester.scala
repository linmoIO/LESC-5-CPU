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

trait TestFuncSingleCycleCPU {

  /* 控制信号 */
  val printToFile = true // 是否打印到文件
  val timeOut = 0 // 超时, 以周期为单位, 0 表示无限制
  val begin = 0 // 开始完全输出的起始周期
  val end = 0 // 结束完全输出的结束周期, 0 表示不会结束
  var i = 1 // 当前周期数
  val printInstPC = true // 是否由 Tester 打印指令和 PC
  val printReg = true // 是否打印 32 个寄存器状态
  var printAll = true // 是否由 Tester 打印 CPU 的详细信息

  def testFn(dut: SingleCycleCPU, myPrint: Any => Unit) = {
    myPrint(s"[INFO] 开始测试 ${dut.name}\n")

    dut.clock.setTimeout(timeOut) // 设置超时

    while (dut.io.inst.peekInt() != 0) {
      val errorPrefix = s"[ERROR] 当前为第 ${i} 个周期, " // 打印的前缀信息

      // 指令应该恒有效
      dut.io.isValidInst
        .expect(true.B, errorPrefix + s"指令 0x${Hexadecimal(dut.io.inst)} 无效")

      if (printInstPC || printAll) {
        myPrint("————————————————— [ CPU - INFO ] ——————————————————\n")

        val instB =
          stringFixUpToN(dut.io.inst.peekInt().toLong.toBinaryString, 32)
        val instKind = InstKindWithCode.getInstKind(
          stringFixUpToN(dut.io.opcode.peekInt().toLong.toBinaryString, 7)
        )

        myPrint(
          s"[Brief] : "
            + s"PC = 0x${dut.io.pc.peekInt().toLong.toHexString}, "
            + s"Next PC = 0x${dut.io.nextPC.peekInt().toLong.toHexString}, "
            + s"第 ${i} 个时钟周期\n"
            + s"\tINST = 0x${stringFixUpToN(dut.io.inst.peekInt().toLong.toHexString, INST_W / 8)}  (${instKind})\n"
            + s"\t     = ${instB.substring(0, 7) + " " + instB.substring(7, 12) + " " + instB
                .substring(12, 17) + " " + instB.substring(17, 20) + " " + instB
                .substring(20, 25) + " " + instB.substring(25)}\n"
            + "\n"
        )
      }
      if (printAll && i > begin && (i < end || end == 0)) {
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
            + s"\tresult = ${dut.io.resultALU.peekInt().toLong}  (0x${dut.io.resultALU.peekInt().toLong.toHexString}) \n"
            + "\n"
        )

        myPrint(
          s"[Immediate] : ${dut.io.imm.peekInt().toLong}  (0x${dut.io.imm.peekInt().toLong.toHexString}) \n\n"
        )

        myPrint(
          s"[内存] : "
            + s"read = ${dut.io.memRead.peekInt()}, memWrite = ${dut.io.memWrite.peekInt()}, "
            + s"bit-type = ${stringFixUpToN(dut.io.bitType.peekInt().toLong.toBinaryString, 2)}, unsigned = ${dut.io.isUnsigned.peekInt()}\n"
        )
        if (dut.io.memWrite.peekBoolean()) {
          myPrint(
            s"\t向内存 0x${dut.io.resultALU.peekInt().toLong.toHexString} 中写入数据\t ${dut.io.readDataRs2
                .peekInt()
                .toLong}  (0x${dut.io.readDataRs2.peekInt().toLong.toHexString}) \n"
          )
        } else if (dut.io.memRead.peekBoolean()) {
          myPrint(
            s"\t从内存 0x${dut.io.resultALU.peekInt().toLong.toHexString} 中读出数据\t ${dut.io.readData
                .peekInt()
                .toLong}  (0x${dut.io.readData.peekInt().toLong.toHexString}) \n"
          )
        }
        if (!dut.io.memWrite.peekBoolean() && !dut.io.memRead.peekBoolean()) {
          myPrint("\t无操作\n")
        }
        myPrint("\n")

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

        myPrint(
          s"[Res 选择器] : "
            + s"Jump = ${dut.io.isJump.peekInt()}, Imm|ALU = ${dut.io.immALUToReg
                .peekInt()}, memRead = ${dut.io.memRead.peekInt()}\n"
            + s"\t选出的 Res 结果为 ${dut.io.resultToReg.peekInt().toLong}  (0x${dut.io.resultToReg.peekInt().toLong.toHexString}) \n"
            + "\n"
        )

        myPrint(
          s"[PC 选择器] : "
            + s"JALR = ${dut.io.isJALR.peekInt()}, B-Type = ${dut.io.isBType
                .peekInt()}, Jump = ${dut.io.isJump
                .peekInt()}, isTrue = ${dut.io.isTrue.peekInt()}\n"
            + s"\t选出的 next PC 结果为 0x${dut.io.nextPC.peekInt().toLong.toHexString}\n"
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

class SingleCycleCPUTester
    extends AnyFlatSpec
    with ChiselScalatestTester
    with TestcaseSet
    with TestFuncSingleCycleCPU {

  "CPU" should "pass" in {
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
        val filePath = s"${dir}/${fileName}.log"
        println(s"[INFO] 将 CPU 输出信息写入到 ${filePath} 中")

        outFile = new PrintWriter(filePath)
        myPrint = outFile.print
      }

      val dataPathFinal = if (needData) dataPath else ""
      test(new SingleCycleCPU(instPath, dataPathFinal, startAddress)) { dut =>
        testFn(dut, myPrint)
      }

      if (printToFile && outFile != null) {
        outFile.close()
      }
    }
  }
}

trait TestcaseSet { // 测试集
  val testcases = List(
    /* dir, fileName, startAddress */

    // ("src/test/hex/fibonacci_recursion", "fibonacci_recursion", 0x98), // 耗时比较长
    ("src/test/hex/fibonacci", "fibonacci", 0xb8),
    ("src/test/hex/myTest", "myTest", 0x0)

    /* dino */
    // ("src/test/hex/dino/target/xori", "xori", 0x0),
    // ("src/test/hex/dino/target/sllw1", "sllw1", 0x0),
    // ("src/test/hex/dino/target/bgeu", "bgeu", 0x0),
    // ("src/test/hex/dino/target/addi1", "addi1", 0x0),
    // ("src/test/hex/dino/target/add0", "add0", 0x0),
    // ("src/test/hex/dino/target/slt1", "slt1", 0x0),
    // ("src/test/hex/dino/target/auipc3", "auipc3", 0x0),
    // ("src/test/hex/dino/target/srliw3", "srliw3", 0x0),
    // ("src/test/hex/dino/target/auipc0", "auipc0", 0x0),
    // ("src/test/hex/dino/target/blt", "blt", 0x0),
    // ("src/test/hex/dino/target/dual_addfwd2", "dual_addfwd2", 0x0),
    // ("src/test/hex/dino/target/and", "and", 0x0),
    // ("src/test/hex/dino/target/sll", "sll", 0x0),
    // ("src/test/hex/dino/target/sraw1", "sraw1", 0x0),
    // ("src/test/hex/dino/target/srl", "srl", 0x0),
    // ("src/test/hex/dino/target/subw2", "subw2", 0x0),
    // ("src/test/hex/dino/target/add1", "add1", 0x0),
    // ("src/test/hex/dino/target/srlw4", "srlw4", 0x0),
    // ("src/test/hex/dino/target/lui1", "lui1", 0x0),
    // ("src/test/hex/dino/target/add2", "add2", 0x0),
    // ("src/test/hex/dino/target/dual_addfwd4", "dual_addfwd4", 0x0),
    // ("src/test/hex/dino/target/srliw2", "srliw2", 0x0),
    // ("src/test/hex/dino/target/addiw2", "addiw2", 0x0),
    // ("src/test/hex/dino/target/jalr1", "jalr1", 0x0),
    // ("src/test/hex/dino/target/subw1", "subw1", 0x0),
    // ("src/test/hex/dino/target/srli2", "srli2", 0x0),
    // ("src/test/hex/dino/target/sllw2", "sllw2", 0x0),
    // ("src/test/hex/dino/target/slliw2", "slliw2", 0x0),
    // ("src/test/hex/dino/target/dual_addfwd5", "dual_addfwd5", 0x0),
    // ("src/test/hex/dino/target/addi2", "addi2", 0x0),
    // ("src/test/hex/dino/target/sub", "sub", 0x0),
    // ("src/test/hex/dino/target/bge", "bge", 0x0),
    // ("src/test/hex/dino/target/sraiw1", "sraiw1", 0x0),
    // ("src/test/hex/dino/target/auipc1", "auipc1", 0x0),
    // ("src/test/hex/dino/target/rotR", "rotR", 0x0),
    // ("src/test/hex/dino/target/bltu", "bltu", 0x0),
    // ("src/test/hex/dino/target/srl2", "srl2", 0x0),
    // ("src/test/hex/dino/target/subw3", "subw3", 0x0),
    // ("src/test/hex/dino/target/addw2", "addw2", 0x0),
    // ("src/test/hex/dino/target/addw1", "addw1", 0x0),
    // ("src/test/hex/dino/target/srai", "srai", 0x0),
    // ("src/test/hex/dino/target/lui0", "lui0", 0x0),
    // ("src/test/hex/dino/target/addiw3", "addiw3", 0x0),
    // ("src/test/hex/dino/target/sllw4", "sllw4", 0x0),
    // ("src/test/hex/dino/target/slt", "slt", 0x0),
    // ("src/test/hex/dino/target/ori", "ori", 0x0),
    // ("src/test/hex/dino/target/swapxor", "swapxor", 0x0),
    // ("src/test/hex/dino/target/srliw1", "srliw1", 0x0),
    // ("src/test/hex/dino/target/andi", "andi", 0x0),
    // ("src/test/hex/dino/target/oppsign", "oppsign", 0x0),
    // ("src/test/hex/dino/target/slti", "slti", 0x0),
    // ("src/test/hex/dino/target/sra", "sra", 0x0),
    // ("src/test/hex/dino/target/dual_addfwd3", "dual_addfwd3", 0x0),
    // ("src/test/hex/dino/target/sraw2", "sraw2", 0x0),
    // ("src/test/hex/dino/target/sltiu", "sltiu", 0x0),
    // ("src/test/hex/dino/target/addfwd", "addfwd", 0x0),
    // ("src/test/hex/dino/target/beq", "beq", 0x0),
    // ("src/test/hex/dino/target/sllw3", "sllw3", 0x0),
    // ("src/test/hex/dino/target/sltu1", "sltu1", 0x0),
    // ("src/test/hex/dino/target/sll2", "sll2", 0x0),
    // ("src/test/hex/dino/target/slli", "slli", 0x0),
    // ("src/test/hex/dino/target/slli2", "slli2", 0x0),
    // ("src/test/hex/dino/target/addiw1", "addiw1", 0x0),
    // ("src/test/hex/dino/target/or", "or", 0x0),
    // ("src/test/hex/dino/target/slliw1", "slliw1", 0x0),
    // ("src/test/hex/dino/target/srlw3", "srlw3", 0x0),
    // ("src/test/hex/dino/target/bne", "bne", 0x0),
    // ("src/test/hex/dino/target/sraiw2", "sraiw2", 0x0),
    // ("src/test/hex/dino/target/srlw1", "srlw1", 0x0),
    // ("src/test/hex/dino/target/addi-funct7", "addi-funct7", 0x0),
    // ("src/test/hex/dino/target/auipc2", "auipc2", 0x0),
    // ("src/test/hex/dino/target/sra2", "sra2", 0x0),
    // ("src/test/hex/dino/target/srli", "srli", 0x0),
    // ("src/test/hex/dino/target/beqfwd2", "beqfwd2", 0x0),
    // ("src/test/hex/dino/target/power2", "power2", 0x0),
    // ("src/test/hex/dino/target/beqfwd1", "beqfwd1", 0x0),
    // ("src/test/hex/dino/target/sltu", "sltu", 0x0),
    // ("src/test/hex/dino/target/xor", "xor", 0x0),
    // ("src/test/hex/dino/target/jal", "jal", 0x0),
    // ("src/test/hex/dino/target/dual_add1", "dual_add1", 0x0),
    // ("src/test/hex/dino/target/jalr0", "jalr0", 0x0),
    // ("src/test/hex/dino/target/srlw2", "srlw2", 0x0),
    // ("src/test/hex/dino/target/addw3", "addw3", 0x0),
    // ("src/test/hex/dino/target/sraw3", "sraw3", 0x0),
    // ("src/test/hex/dino/target/dual_addfwd1", "dual_addfwd1", 0x0),
    // ("src/test/hex/dino/target/slliw3", "slliw3", 0x0),

    /* 含 data 的指令 */
    // ("src/test/hex/dino/target/lwfwd", "lwfwd", 0x0),
    // ("src/test/hex/dino/target/lh1", "lh1", 0x0),
    // ("src/test/hex/dino/target/lw1", "lw1", 0x0),
    // ("src/test/hex/dino/target/lb1", "lb1", 0x0),
    // ("src/test/hex/dino/target/sw", "sw", 0x0),
    // ("src/test/hex/dino/target/sd1", "sd1", 0x0),
    // ("src/test/hex/dino/target/lh", "lh", 0x0),
    // ("src/test/hex/dino/target/lb", "lb", 0x0),
    // ("src/test/hex/dino/target/sb", "sb", 0x0),
    // ("src/test/hex/dino/target/lbu", "lbu", 0x0),
    // ("src/test/hex/dino/target/sw2", "sw2", 0x0),
    // ("src/test/hex/dino/target/ld1", "ld1", 0x0),
    // ("src/test/hex/dino/target/sd2", "sd2", 0x0),
    // ("src/test/hex/dino/target/sh", "sh", 0x0),
    // ("src/test/hex/dino/target/lhu", "lhu", 0x0),
    // ("src/test/hex/dino/target/lwu", "lwu", 0x0),
    // ("src/test/hex/dino/target/lwu1", "lwu1", 0x0),
    // ("src/test/hex/dino/target/ld2", "ld2", 0x0),
    // // ("src/test/hex/dino/target/sort", "sort", 0x0) // 代码有错误

    /* 综合的 */
    // ("src/test/hex/dino/target/divider", "divider", 0x0),
    // ("src/test/hex/dino/target/ldfwd", "ldfwd", 0x0),
    // ("src/test/hex/dino/target/test", "test", 0x0),
    // ("src/test/hex/dino/target/swfwd1", "swfwd1", 0x0),
    // ("src/test/hex/dino/target/multiplier", "multiplier", 0x0),
    // ("src/test/hex/dino/target/naturalsum", "naturalsum", 0x0),
    // ("src/test/hex/dino/target/fibonacci", "fibonacci", 0x0),
    // ("src/test/hex/dino/target/swfwd2", "swfwd2", 0x0)

    /* 尚未实现的指令 */
    // ("src/test/hex/dino/target/ebreak", "ebreak", 0x0),
    // ("src/test/hex/dino/target/csrrw", "csrrw", 0x0),
    // ("src/test/hex/dino/target/ecall", "ecall", 0x0),
    // ("src/test/hex/dino/target/csrrs", "csrrs", 0x0),
    // ("src/test/hex/dino/target/csrrwi", "csrrwi", 0x0),
    // ("src/test/hex/dino/target/csrrc", "csrrc", 0x0),
    // ("src/test/hex/dino/target/csrrci", "csrrci", 0x0),
    // ("src/test/hex/dino/target/csrrsi", "csrrsi", 0x0),
    // ("src/test/hex/dino/target/mret", "mret", 0x0),
  )
}
