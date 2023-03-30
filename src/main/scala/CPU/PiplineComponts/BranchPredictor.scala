package CPU.PiplineComponts

import chisel3._
import chisel3.util._
import CPU.CPUConfig._
import CPU._

/**
 * <b>[[分支预测器]]</b>
 * <p>
 * 用分支预测的方式优化流水线 CPU 的控制冒险问题。
 * <p>
 * [[input]]
 * <p>
 * [[output]]
 */
class BranchPredictor extends Module {
  val io = IO(new Bundle {
    /* input */
    val keep = Input(Bool()) // 来自 DataControlUnit, 控制 PC 保持不动
    val ifMayJump = Input(Bool()) // 如果可能为跳转指令 (在 IF 阶段进行简单的译码)

    val ifPC = Input(UInt(XLEN.W)) // IF 阶段的 PC
    val idPC = Input(UInt(XLEN.W)) // ID 阶段的 PC
    val exePC = Input(UInt(XLEN.W)) // EXE 阶段的 PC

    val idInst = Input(UInt(INST_W.W)) // ID 阶段的指令
    val exeInst = Input(UInt(INST_W.W)) // EXE 阶段的指令

    val selectPC = Input(UInt(XLEN.W)) // 来自 PCSelectUnit 的 PC
    val jump = Input(Bool()) // 来自 PCSelctUnit, 表示当前指令是否的确发生跳转

    /* output */
    val nextPC = Output(UInt(XLEN.W)) // 生成的下一个 PC, 接到 PCReg.in 上
    val flush = Output(Bool()) // 输出的流水线冲刷信号, 接到 IF/ID 和 ID/EXE 的寄存器组上
  })

  val pht = new PHT // PHT 表
  val btb = new BTB // BTB 表
  val flushReg = RegInit(false.B) // 加一个寄存器, 防止回环

  val nextPC = WireDefault(io.ifPC + INST_BYTE.U)

  val ifPCIndex = io.ifPC >> INST_MEMORY_OFFSET // 指令索引右移 2 位
  val exePCIndex = io.exePC >> INST_MEMORY_OFFSET // 指令索引右移 2 位

  val flush = WireDefault(false.B)
  flushReg := flush // 默认不冲刷

  /* 获取 NextPC 部分 */
  when(io.keep) { // 数据冒险的控制优先级更高
    nextPC := io.ifPC // PC 维持
  }.otherwise {
    when(io.ifMayJump) { // 当前可能为跳转指令
      // 去 PHT 表获取对应的饱和计数器
      val historyState = pht.getHistoryState(ifPCIndex(PHT_INDEX_W - 1, 0))
      //   printf(
      //     cf"[DEBUG] 获取饱和计数器 : ifPC = ${io.ifPC}, historyState = ${historyState}\n"
      //   )
      when(historyState(1) === 1.U) { // 若为 10/11
        // 去 BTB 表中获得对应的跳转 PC
        val target = btb.getTargetAddress(ifPCIndex)
        // printf(cf"[DEBUG] 获取Target : ifPC = ${io.ifPC}, target = ${target}\n")
        nextPC := target // 将对应的 PC 输出
      }
    }
  }

  /* 预测错误冲刷流水线 */
  when(
    (io.idInst =/= 0.U) && (io.exeInst =/= 0.U) && (io.idPC =/= io.selectPC)
  ) { // 预测失败
    nextPC := io.selectPC // 让正确的指令进入 PC 寄存器
    flushReg := true.B // 冲刷流水线
  }

  /* 更新部分 */
  pht.updata(exePCIndex(PHT_INDEX_W - 1, 0), io.jump) // 更新饱和计数器
//   when(pht.getHistoryState(exePCIndex(PHT_INDEX_W - 1, 0)) =/= 0.U) {
//     printf(cf"[DEBUG] 更新饱和计数器 : exePC = ${io.exePC}, jump = ${io.jump}\n")
//   }
  when(io.jump) {
    // printf(cf"[DEBUG] 更新 : exePC = ${io.exePC}, target = ${io.selectPC}\n")
    btb.updata(exePCIndex, io.selectPC) // 更新目标地址
  }

  /* 输出部分 */
  io.nextPC := nextPC
  io.flush := flushReg
}

class PHT {
  // 12bits index | 2bits 饱和计数器
  val phtMem = Mem(PHT_SIZE, UInt(2.W)) // PHT 表的存储

  def getHistoryState(index: UInt) = { // 索引为 12 位
    phtMem.read(index)
  }
  def updata(index: UInt, jump: Bool) = { // 索引为 12 位
    val historyState = phtMem.read(index)
    phtMem.write(index, Cat(historyState(0), jump))
  }
}

class BTB {
  // 6bits 索引 | 64bits PC高位地址 | 64bits 目标地址
  val pcW = XLEN
  val targetW = XLEN
  val btbMem = Mem(BTB_SIZE, UInt((pcW + targetW).W)) // BTB 表的存储

  def getTargetAddress(pcIndex: UInt) = { // 索引为 62 位(低 2 位恒为 0, 所以可以去掉)
    val data = btbMem.read(pcIndex(BTB_INDEX_W - 1, 0)) // 取出数据
    val pcSource = data(pcW + targetW - 1, targetW) // 取出 56bits 的 PC高位地址
    val target =
      WireDefault((pcIndex + 1.U) << INST_MEMORY_OFFSET) // 默认 PC + 4 (注意末尾 2 位)
    when((pcSource >> INST_MEMORY_OFFSET) === pcIndex) { // 若匹配上了
      target := data(targetW - 1, 0) // 取出目标地址
    }
    target
  }

  def updata(pcIndex: UInt, selectPC: UInt) = { // 索引为 62 位, selectPC 为 64 位
    val pcSource = pcIndex << INST_MEMORY_OFFSET // 补齐
    val data = Cat(pcSource, selectPC)
    btbMem.write(pcIndex(BTB_INDEX_W - 1, 0), data)
  }
}

object BranchPredictor {
  def main(args: Array[String]) = {
    print(getVerilogString(new BranchPredictor()))

    print("\n[Success]\n")
  }
}
