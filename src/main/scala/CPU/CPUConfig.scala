package CPU

import math._

object CPUConfig {
  val XLEN = 64 // 64 位机器

  val CPU_ENDIAN = Endianness.Little_Endian // 大端序

  val DATA_BYTE = XLEN / 8 // 数据单位的字节大小
  val DATA_MEMORY_OFFSET =
    ceil(log(DATA_BYTE) / log(2)).toInt // 数据内存地址寻址偏移量 (按字节)
  // val DATA_MEMORY_SIZE = 8
  val DATA_MEMORY_SIZE = 8 * 1024 // 数据内存大小, 8 * 1024 * 8B = 64KB

  val INST_W = 32 // 指令宽度
  val INST_BYTE = INST_W / 8 // 指令单位的字节大小
  val INST_MEMORY_OFFSET =
    ceil(log(INST_BYTE) / log(2)).toInt // 指令内存地址寻址偏移量 (按字节)
  // val INST_MEMORY_SIZE = 128 // 指令内存大小, 8 * 1024 * 4B = 32KB
  val INST_MEMORY_SIZE = 8 * 1024 // 指令内存大小, 8 * 1024 * 4B = 32KB

  val BYTE_W = 8 // 字节宽度
  val HALFWORD_W = 16 // 半字宽度
  val WORD_W = 32 // 字宽度
  val DOUBLEWORD_W = 64 // 双字宽度

  val START_ADDRESS = 0x00000000 // 起始地址

  val REGISTE_NUM = 32 // 寄存器个数

  val ALU_OPERATION_W = 6 // ALU 操作码宽度
  val SHAMT_W = ceil(log(XLEN) / log(2)).toInt // 指令中的偏移量宽度 (shamt)

  val HEX_INST_DIR = "src/test/hex/inst"
  val HEX_DATA_DIR = "src/test/hex/data"
}

object DebugConfig {
  /* IO 打印信息控制 */
  val ControlUnitIOPrint = false
  val PCRegIOPrint = false
  val ALUControlUnitIOPrint = false
  val Inst2ImmUnitIOPrint = false
  val ALUIOPrint = false
  val RegUnitIOPrint = false
  val InstMemoryIOPrint = true
}

// 端序
object Endianness extends Enumeration {
  val Big_Endian = Value // 大端序
  val Little_Endian = Value // 小端序
}

/* 指令 Kind */
object InstKind extends Enumeration {
  val LUI, AUIPC, JAL, JALR = Value
  val BType = Value
  val Load, Store = Value
  val IType, ITypeW = Value
  val RType, RTypeW = Value
}

/* 指令 Kind 转为 7 位操作码 */
object InstKind2Opcode {
  val map = Map(
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

  def getOpcode(inst: InstKind.Value) = {
    map.get(inst).getOrElse("0000000")
  }

  def getBOpcode(inst: InstKind.Value) = {
    "b".appendedAll(map.get(inst).getOrElse("0000000"))
  }
}

/* ALU 操作类型 */
object ALUOperation extends Enumeration {
  val ADD, SUB, SLL, SLT, SLTU, XOR, SRL, SRA, OR, AND = Value
  val BEQ, BNE, BLT, BGE, BLTU, BGEU = Value
}

/* ALU 操作类型转为对应的 4 位操作码 */
/* 用于将 I-Type 指令和 R-Type 指令对齐 */
object ALUOperation2Opcode {
  val defautOpcode = "0000"

  val operation2Opcode = Map(
    ALUOperation.ADD -> "0000",
    ALUOperation.SUB -> "0001",
    ALUOperation.SLL -> "0010",
    ALUOperation.SLT -> "0100",
    ALUOperation.SLTU -> "0110",
    ALUOperation.XOR -> "1000",
    ALUOperation.SRL -> "1010",
    ALUOperation.SRA -> "1011",
    ALUOperation.OR -> "1100",
    ALUOperation.AND -> "1110",
    // B-type
    ALUOperation.BEQ -> "0000",
    ALUOperation.BNE -> "0010",
    ALUOperation.BLT -> "1000",
    ALUOperation.BGE -> "1010",
    ALUOperation.BLTU -> "1100",
    ALUOperation.BGEU -> "1110"
  )

  def getOpcode(op: ALUOperation.Value) = {
    operation2Opcode.get(op).getOrElse(defautOpcode)
  }

  def getBOpcode(op: ALUOperation.Value) = {
    "b".appendedAll(operation2Opcode.get(op).getOrElse(defautOpcode))
  }

  def getBOpcodeDefault() = {
    "b".appendedAll(defautOpcode)
  }
}
