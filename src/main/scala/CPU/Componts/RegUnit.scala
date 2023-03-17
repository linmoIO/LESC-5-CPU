package CPU.Componts

import chisel3._
import chisel3.util._
import CPU.CPUConfig._
import CPU._

/**
 * <b>[[寄存器单元]]</b>
 * <p>
 * 由 32 个寄存器形成的寄存器单元, 执行 读/写寄存器 的操作,
 * 注意诸如 x0 等特殊寄存器的处理,
 * 还需考虑是否要提前开栈(这一操作由操作系统完成, 但因为不支持特权模式, 故无法运行操作系统, 裸机需要主动提前开栈)
 * <p>
 * [[input]]
 *   - rs1 : rs1 寄存器, 根据指令的 [19-15] 得到
 *   - rs2 : rs2 寄存器, 根据指令的 [24-20] 得到
 *   - rd : rd 寄存器, 根据指令的 [11-7] 得到
 *   - writeEnable : 写使能, 来自于 ControlUnit.ifWriteToReg
 *   - writeData : 要写入的数据, 来自于 ResSelectUnit.out
 * <p>
 * [[output]]
 *   - readDataRs1 : 从 rs1 中读出的数据
 *   - readDataRs2 : 从 rs2 中读出的数据
 */
class RegUnit extends Module {
  val io = IO(new Bundle {
    /* input */
    val rs1 = Input(UInt(5.W))
    val rs2 = Input(UInt(5.W))
    val rd = Input(UInt(5.W))
    val writeEnable = Input(Bool())
    val writeData = Input(UInt(XLEN.W))
    /* output */
    val readDataRs1 = Output(UInt(XLEN.W))
    val readDataRs2 = Output(UInt(XLEN.W))
    val regAll = Output(Vec(32, UInt(XLEN.W)))
  })

  // 32 个寄存器, 64 位
  var regInitSeq = Seq.fill(REGISTE_NUM)(0.U(XLEN.W))
  // 对 sp 寄存器做初始化
  if (IF_RESERVE_STACK_SPACE) {
    regInitSeq = regInitSeq.updated(2, STACK_SIZE.U(XLEN.W))
  }

  val regGroup = RegInit(VecInit(regInitSeq))

  // X0 读出的数据为 0
  io.readDataRs1 := Mux(io.rs1 === 0.U, 0.U, regGroup(io.rs1))
  io.readDataRs2 := Mux(io.rs2 === 0.U, 0.U, regGroup(io.rs2))

  // 此处不允许写时读, 否则会产生回环
  // // 考虑写时读的问题, 读写转发
  // io.readDataRs1 := Mux(
  //   (io.writeEnable && (io.rs1 === io.rd)),
  //   io.writeData,
  //   regGroup(io.rs1)
  // )
  // io.readDataRs2 := Mux(
  //   (io.writeEnable && (io.rs2 === io.rd)),
  //   io.writeData,
  //   regGroup(io.rs2)
  // )

  // x0 不允许写
  when(io.writeEnable === true.B && io.rd =/= 0.U) {
    regGroup(io.rd) := io.writeData
  }

  io.regAll(0) := 0.U
  for (i <- 1 until 32) {
    io.regAll(i) := regGroup(i)
  }

  // **************** print **************** //
  val rs1UInt = Cat(0.U, io.rs1)
  val rs2UInt = Cat(0.U, io.rs2)
  val rdUInt = Cat(0.U, io.rd)

  val needBinary = List()
  val needDec =
    List(io.writeData, io.readDataRs1, io.readDataRs2, rs1UInt, rs2UInt, rdUInt)
  val needHex = List()
  val needBool = io.getElements.filter(data => data.isInstanceOf[Bool]).toList
  val needDelete = List(io.rs1, io.rs2, io.rd)
  val needAdd = List(rs1UInt, rs2UInt, rdUInt)

  if (DebugControl.RegUnitIOPrint) {
    CPUPrintf.printfIO(
      "INFO",
      this,
      io.getElements
        .filterNot(data => needDelete.contains(data))
        .toList
        .appendedAll(needAdd),
      needBinary,
      needDec,
      needHex,
      needBool
    )
  }

  if (DebugControl.RegPrint) { // 专门打印寄存器状态
    printf(cf"[寄存器状态] : \n")
    for (i <- 0 until 32) {
      printf(
        cf"${i} (${RegNameWithNum.getRegName(i)}) = ${Decimal(regGroup(i.U))} (0x${Hexadecimal(regGroup(i.U))})\t"
      )
      if ((i + 1) % 2 == 0) {
        printf("\n")
      }
    }
    printf("\n\n")
  }
}
