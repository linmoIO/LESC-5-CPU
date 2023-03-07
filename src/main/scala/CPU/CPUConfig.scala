package CPU

import math._

object CPUConfig {
  val XLEN = 64 // 64 位机器

  val INST_W = 32 // 指令宽度

  val BYTE_W = 8 // 字节宽度
  val HALFWORD_W = 16 // 半字宽度
  val WORD_W = 32 // 字宽度
  val DOUBLEWORD_W = 64 // 双字宽度

  val SHAMT_W = ceil(log(XLEN) / log(2)).toInt // 指令中的偏移量宽度 (shamt)

  val START_ADDRESS = 0x00000000 // 起始地址
  val ALU_OPERATION_W = 6 // ALU 操作码宽度
}

object DebugConfig {
  /* IO 打印信息控制 */
  val ControlUnitIOPrint = true
  val PCRegIOPrint = true
}
