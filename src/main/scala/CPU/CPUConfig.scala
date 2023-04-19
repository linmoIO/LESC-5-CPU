package CPU

import chisel3._
import chisel3.util._

import math._

/**
 * <b>[[CPU 配置]]</b>
 * <p>
 * 配置 CPU 信息
 * <p>
 */
object CPUConfig {
  /* 机器相关配置 */

  val XLEN = 64 // 机器位数 : 64 位机器

  val CPU_ENDIAN = Endianness.Little_Endian // 机器端序 : 小端序

  val MEM_TYPE = "ASYNC" // 内存类型 : 异步读 (异步读版本, 同步读实在绝望了)

  val REGISTE_NUM = 32 // 寄存器个数 : 32

  /* 指令内存相关配置 */

  val INST_W = 32 // 指令宽度 : 32位
  val INST_BYTE = INST_W / 8 // 指令单位的字节大小 : 4B
  val INST_MEMORY_OFFSET =
    ceil(log(INST_BYTE) / log(2)).toInt // 指令内存地址寻址偏移量 (按字节)
  // val INST_MEMORY_SIZE = 128 // 用于测试
  val INST_MEMORY_SIZE =
    64 * 1024 // 指令内存大小 (指令内存按指令长度为单位) : 64 * 1024 * 4B = 256KB， 理论可支持的最大指令内存大小 2^64 * 4B = 16EB

  /* 数据内存相关配置 */

  val DATA_BYTE = XLEN / 8 // 数据单位的字节大小 : 8B
  val DATA_MEMORY_OFFSET =
    ceil(log(DATA_BYTE) / log(2)).toInt // 数据内存地址寻址偏移量 (按字节)
  // val DATA_MEMORY_SIZE = 8 // 用于测试
  val DATA_MEMORY_SIZE =
    256 * 1024 // 数据内存大小 (数据内存按字节为单位) : 256 * 1024 * 8B = 2MB， 理论可支持的最大数据内存大小 2^64 * B = 4EB

  /* 字节宽度相关配置 */

  val BYTE_W = 8 // 字节宽度 : 8位
  val HALFWORD_W = 16 // 半字宽度 : 16位
  val WORD_W = 32 // 字宽度 : 32位
  val DOUBLEWORD_W = 64 // 双字宽度 : 64位

  /* 其他相关配置 */

  val ALU_OPERATION_W = 6 // ALU 操作码宽度 : 6位
  val SHAMT_W = ceil(log(XLEN) / log(2)).toInt // 指令中的偏移量宽度 (shamt) : 6位

  // 无操作指令, 用于解决 pc 跳转需要 2 个周期的问题
  // 即 addi x0, x0, 0
  // 000000000000 00000 000 00000 0010011
  // 0x00000013
  // 这是同步读的眼泪
  val NOP_INST = "00000013"

  /* 分支预测的配置 */
  val PHT_INDEX_W = 12 // PHT 表索引宽度 : 12 位
  val PHT_SIZE = pow(2, PHT_INDEX_W).toInt // PHT 表大小: 4096 项
  val BTB_INDEX_W = 6 // BTB 表索引宽度 : 6 位
  val BTB_SIZE = pow(2, BTB_INDEX_W).toInt // BTB 表大小: 64 项

  /* 初始化相关配置 [可修改] */

  val IF_RESERVE_STACK_SPACE = true // 是否预先保留栈空间
  val STACK_SIZE = 8 * 4096 // 预先开栈大小
  val TIME_OUT = 200000 // 测试时的周期超时上限

  // 以下均已弃用, 由外部参数传入
  // val START_ADDRESS = 0x00000000 // 起始地址
  // var HEX_DATA_DIR = "src/test/hex/data" // 数据内存初始化文件夹所在位置
  // var HEX_INST_DIR = "src/test/hex/inst" // 指令内存初始化文件夹所在位置
}

/**
 * <b>[[打印信息控制]]</b>
 * <p>
 * 控制 IO 等信息的打印, 用于调试查看
 * <p>
 */
object DebugControl {
  /* 组件打印信息控制 */
  val ALUIOPrint = false
  val ALUControlUnitIOPrint = false
  val ControlUnitIOPrint = false
  val DataMemoryIOPrint = false
  val Inst2ImmUnitIOPrint = false
  val InstMemoryIOPrint = false
  val PCRegIOPrint = false
  val PCSelectUnitIOPrint = false
  val RegUnitIOPrint = false
  val ResSelectUnitIOPrint = false

  /* 流水线寄存器组打印信息控制 */
  val IFIDStageRegsIOPrint = false
  val IDEXEStageRegsIOPrint = false
  val EXEMEMStageRegsIOPrint = false
  val MEMWBStageRegsIOPrint = false

  /* 流水线控制器打印信息控制 */
  val BranchControlUnitIOPrint = false
  val DataControlUnitIOPrint = false

  /* CPU 打印信息控制 */
  val SingleCycleCPUPrint = false
  val PiplineCPUPrint = false
  val PiplineCPUwithForwardingPrint = false
  val RegPrint = false // 32 个寄存器状态打印
}

/**
  * <b>[[打印类型]]</b>
  * - Binary, Hex, Dec, Bool, Default
  */
object PrintKind extends Enumeration {
  val Binary, Hex, Dec, Bool, Default = Value
}

/**
  * <b>[[机器端序]]</b>
  * - Big_Endian : 大端序
  * - Little_Endian : 小端序
  */
object Endianness extends Enumeration {
  val Big_Endian = Value // 大端序
  val Little_Endian = Value // 小端序
}

/**
  * <b>[[指令 Kind]]</b>
  * - LUI, AUIPC, JAL, JALR : 单独指令
  * - B-Type : 分支跳转指令
  * - Load, Store : 内存操作指令
  * - I-Type : 立即数操作指令
  * - R-Type : 寄存器操作指令
  */
object InstKind extends Enumeration {
  val LUI, AUIPC, JAL, JALR = Value
  val BType = Value
  val Load, Store = Value
  val IType, ITypeW = Value
  val RType, RTypeW = Value
  val None = Value // 未知 (用于反向)
}

/**
  * <b>[[指令 Kind 和 Opcode 的对应]]</b>
  * <p>
  * 用于将指令 Kind 和 Opcode 一一对应
  * <p>
  */
object InstKindWithCode {
  /* inst kind -> opcode */
  val instKind2Code = Map(
    InstKind.LUI -> "0110111",
    InstKind.AUIPC -> "0010111",
    InstKind.JAL -> "1101111",
    InstKind.JALR -> "1100111",
    InstKind.BType -> "1100011",
    InstKind.Load -> "0000011",
    InstKind.Store -> "0100011",
    InstKind.IType -> "0010011",
    InstKind.ITypeW -> "0011011",
    InstKind.RType -> "0110011",
    InstKind.RTypeW -> "0111011"
  )

  /* opcode -> inst kind */
  val opcode2InstKind = instKind2Code.map(kv => (kv._2, kv._1))

  /* get opcode */

  def getCode(inst: InstKind.Value) = {
    instKind2Code.getOrElse(inst, "0000000")
  }

  def getBCode(inst: InstKind.Value) = {
    "b".appendedAll(getCode(inst))
  }

  /* get inst kind */

  def getInstKind(code: String) = {
    opcode2InstKind.getOrElse(code, "None")
  }

  def s(inst: InstKind.Value) = {
    InstKindWithCode.getBCode(inst) -> inst
  }

}

/**
  * <b>[[ALU 操作类型]]</b>
  * - ADD, SUB, SLL, SLT, SLTU, XOR, SRL, SRA, OR, AND : 分支无关
  * - BEQ, BNE, BLT, BGE, BLTU, BGEU : 分支相关
  */
object ALUOp extends Enumeration {
  val ADD, SUB, SLL, SLT, SLTU, XOR, SRL, SRA, OR, AND = Value
  val BEQ, BNE, BLT, BGE, BLTU, BGEU = Value

  /* 分支相关的 ALU 操作类型集合 */
  val ALUOpBranch = Array(
    ALUOp.BEQ,
    ALUOp.BNE,
    ALUOp.BLT,
    ALUOp.BGE,
    ALUOp.BLTU,
    ALUOp.BGEU
  )

  /* 判断当前 ALU 操作 是否是分支相关 */
  def isBranch(op: ALUOp.Value) = {
    ALUOpBranch.contains(op)
  }
}

/**
  * <b>[[ALU 操作类型 和 ALU 4 位操作码 的对应]]</b>
  * <p>
  * 用于将 ALU 操作类型 和 ALU 4 位操作码 一一对应
  * <p>
  */
object ALUOpWithCode {

  val defautCode = "0000" // 默认操作 : ADD

  /* ALU 操作类型 -> opcode */
  val op2Code = Map(
    ALUOp.ADD -> "0000",
    ALUOp.SUB -> "0001",
    ALUOp.SLL -> "0010",
    ALUOp.SLT -> "0100",
    ALUOp.SLTU -> "0110",
    ALUOp.XOR -> "1000",
    ALUOp.SRL -> "1010",
    ALUOp.SRA -> "1011",
    ALUOp.OR -> "1100",
    ALUOp.AND -> "1110",
    // B-type
    ALUOp.BEQ -> "0000",
    ALUOp.BNE -> "0010",
    ALUOp.BLT -> "1000",
    ALUOp.BGE -> "1010",
    ALUOp.BLTU -> "1100",
    ALUOp.BGEU -> "1110"
  )

  /* ALU 操作类型 (分支无关) -> opcode */
  val code2OpNormal =
    op2Code.filter(kv => !ALUOp.isBranch(kv._1)).map(kv => (kv._2, kv._1))

  /* ALU 操作类型 (分支相关) -> opcode */
  val code2OpBranch =
    op2Code.filter(kv => ALUOp.isBranch(kv._1)).map(kv => (kv._2, kv._1))

  /* get opcode */

  def getCode(op: ALUOp.Value) = {
    op2Code.getOrElse(op, defautCode)
  }

  def getBCode(op: ALUOp.Value) = {
    "b".appendedAll(getCode(op))
  }

  def getBCodeDefault() = {
    "b".appendedAll(defautCode)
  }

  /* get ALU 操作类型 */
  def getALUOp(code: String, isBranch: Boolean) = {
    if (isBranch)
      code2OpBranch.getOrElse(code, ALUOp.ADD)
    else
      code2OpNormal.getOrElse(code, ALUOp.ADD)
  }
}

/**
  * <b>[[寄存器命名]]</b>
  */
object RegName extends Enumeration {
  val zero, ra, sp, gp, tp, t0 = Value
  val t1, t2, s0_fp, s1 = Value
  val a0, a1, a2, a3, a4, a5, a6, a7 = Value
  val s2, s3, s4, s5, s6, s7, s8, s9, s10, s11 = Value
  val t3, t4, t5, t6 = Value
  val ft0, ft1, ft2, ft3, ft4, ft5, ft6, ft7 = Value
  val unknown = Value
}

object RegNameWithNum {
  val num2Name = RegName.values.map(v => v.id -> v).toMap

  def getRegName(num: Int) = {
    num2Name.getOrElse(num, RegName.unknown)
  }
}
