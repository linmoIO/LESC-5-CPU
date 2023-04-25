package Design

import chisel3._
import chisel3.util._

/**
 * <b>[[加法器]]</b>
 * <p>
 * 将 x 和 y 相加后输出
 * <p>
 * [[input]]
 *   - x
 *   - y
 * <p>
 * [[output]]
 *   - out : x + y
 */
class Adder extends Module {
  val io = IO(new Bundle {
    /* input */
    val x = Input(UInt(64.W))
    val y = Input(UInt(64.W))
    /* output */
    val out = Output(UInt(64.W))
  })
  io.out := 0.U
}

/**
 * <b>[[PC 寄存器]]</b>
 * <p>
 * PC 寄存器
 * <p>
 * [[input]]
 *   - in : 下一个 PC, 来自 PCSelectUnit.nextPC
 * <p>
 * [[output]]
 *   - out : 输出当前 PC
 */
class PCReg extends Module {
  val io = IO(new Bundle {
    /* input */
    val in = Input(UInt(64.W))
    /* output */
    val out = Output(UInt(64.W))
  })
  io.out := 0.U
}

/**
 * <b>[[指令存储单元]]</b>
 * <p>
 * 存储待执行的指令, 根据 PC 依次取出进行执行
 * <p>
 * [[input]]
 *   - address : PC, 即取值地址, 来自 PCReg.out
 * <p>
 * [[output]]
 *   - inst : 输出对应地址的指令
 */
class InstMemeory extends Module {
  val io = IO(new Bundle {
    /* input */
    val address = Input(UInt(64.W))
    /* output */
    val inst = Output(UInt(32.W))
  })
  io.inst := 0.U
}

/**
 * <b>[[控制单元]]</b>
 * <p>
 * 根据操作码生成对应的控制信号
 * <p>
 * [[input]]
 *   - opcode : 操作码, 来自 InstMemory.inst 的 [6-0]
 *              为指令的低 7 位
 * <p>
 * [[output]]
 *   - isJALR : 1 for jalr, 等同于 jumptype[0]
 *              为 true (jalr) 则 next_pc 来源于 ALU
 *   - isBType : 是否为 B-type 指令, 1 for B-type
 *   - isJump : 是否为 jump 指令, 1 for jal/jalr, 等同于 jumptype[1]

 *   - immALUToReg : 将 立即数/ALU的结果 放入寄存器,
 *                 1 for immediate, 0 for ALU's result
 *
 *   - memRead : 是否需要从 DataMemory 中读取数据
 *   - memWrite : 是否需要向 DataMemory 中写入数据
 *   - memValid : 是否要对 DataMemory 进行操作,
 *                memValid = memRead BitOR memWrite
 *
 *   - immRs2ToALU : 控制 ALU.y 的输入
 *              1 for immediate, 0 for RegUnit.readDataRs2
 *   - pcRs1ToALU : 控制 ALU.x 的输入
 *             1 for PCReg.out, 0 for RegUnit.readDataRs1
 *
 *   - isIType : 是否为 I-type 指令
 *   - isRType : 是否为 R-type 指令
 *   - isWord : 是否为 '*W' 型指令, 即按 word 处理
 *
 *   - ifWriteToReg : 是否要将结果写入寄存器
 *
 *   - isValidInst : 是否是有效的指令
 */
class ControlUnit extends Module {
  val io = IO(new Bundle {
    /* input */
    val opcode = Input(UInt(7.W))
    /* output */
    val isJALR = Output(Bool())
    val isBType = Output(Bool())
    val isJump = Output(Bool())
    val immALUToReg = Output(Bool())
    val memRead = Output(Bool())
    val memWrite = Output(Bool())
    val immRs2ToALU = Output(Bool())
    val pcRs1ToALU = Output(Bool())
    val isIType = Output(Bool())
    val isRType = Output(Bool())
    val isWord = Output(Bool())
    val ifWriteToReg = Output(Bool())
    val isValidInst = Output(Bool())
  })
  io.isJump := 0.U
  io.isBType := 0.U
  io.isJALR := 0.U
  io.immALUToReg := 0.U
  io.memRead := 0.U
  io.memWrite := 0.U
  io.immRs2ToALU := 0.U
  io.pcRs1ToALU := 0.U
  io.isIType := 0.U
  io.isRType := 0.U
  io.isWord := 0.U
  io.ifWriteToReg := 0.U
  io.isValidInst := 0.U
}

/**
 * <b>[[指令to立即数转换器]]</b>
 * <p>
 * 根据 32 位指令生成对应 type 的立即数
 * <p>
 * [[input]]
 *   - inst : 来自 InstMemory 取出的指令, 完整的 32 位
 * <p>
 * [[output]]
 *   - imm : 根据 32 位指令生成的对应的符号扩展的立即数
 */
class Inst2ImmUnit extends Module {
  val io = IO(new Bundle {
    /* input */
    val inst = Input(UInt(32.W))
    /* output */
    val imm = Output(UInt(64.W))
  })
  io.imm := 0.U
}

/**
 * <b>[[寄存器单元]]</b>
 * <p>
 * 由 32 个寄存器形成的寄存器单元, 执行 读/写寄存器 的操作
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
    val writeData = Input(UInt(64.W))
    /* output */
    val readDataRs1 = Output(UInt(64.W))
    val readDataRs2 = Output(UInt(64.W))
  })
  io.readDataRs1 := 0.U
  io.readDataRs2 := 0.U
}

/**
 * <b>[[ALU 控制单元]]</b>
 * <p>
 * 根据 ControlUnit 的控制信号、funct3 和 funct7 生成对应的 ALU 的控制信号
 * 指挥 ALU 的执行
 * <p>
 * [[input]]
 *   - isBType : 当前指令是否为 B-type 指令
 *   - isIType : 当前指令是否为 I-type 指令
 *   - isRType : 当前指令是否为 R-type 指令
 *   - isWord : 是否为 '*W' 型指令, 即按 word 处理
 *   - funct3 : 指令中的 3 位方法码, 来自于指令的 [14-12]
 *   - funct7 : 指令中的 7 位方法码, 来自于指令的 [31-25]
 * <p>
 * [[output]]
 *   - aluOperation : 根据输入生成的 6 位控制码
 *                    若为 R-type/B-type, 组成为 funct3|inst[30]|isWord|isBType
 *                    若为 I-type, 则为对应的 R-type 的控制码
 *                    若均不是, 则生成默认控制码(将执行 ADD 操作)
 */
class ALUControlUnit extends Module {
  val io = IO(new Bundle {
    /* input */
    val isBType = Input(Bool())
    val isIType = Input(Bool())
    val isRType = Input(Bool())
    val isWord = Input(Bool())
    val funct3 = Input(UInt(3.W))
    val funct7 = Input(UInt(7.W))
    /* output */
    val aluOperation = Output(UInt(6.W))
  })
  io.aluOperation := 0.U
}

/**
 * <b>[[ALU 运算单元]]</b>
 * <p>
 * 根据 ALU 控制单元传来的操作码, 对数据进行计算
 * <p>
 * [[input]]
 *   - aluOperation : 操作码, 来自 ALUControlUnit
 *   - x : 待计算的数据 1
 *   - y : 待计算的数据 2
 * <p>
 * [[output]]
 *   - result : 计算得到的结果
 */
class ALU extends Module {
  val io = IO(new Bundle {
    /* input */
    val aluOperation = Input(UInt(6.W))
    val x = Input(UInt(64.W))
    val y = Input(UInt(64.W))
    /* output */
    val result = Output(UInt(64.W))
  })
  io.result := 0.U
}

/**
 * <b>[[数据存储单元]]</b>
 * <p>
 * 存储数据, 根据指令进行 读/写
 * <p>
 * [[input]]
 *   - valid : 若 valid = true, 表示需要 读/写
 *   - memRead : 是否需要读
 *   - memWrite : 是否需要写
 *   - address : 读/写 的地址
 *   - writeData : 待写入的数据
 *   - bitType : 是否要按照 16/32/64位 进行 读/写, 为指令的 [13-12]
 *   - isUnsigned : 做 零扩展/符号扩展, 为指令的 [14]
 * <p>
 * [[output]]
 *   - readData : 读出的数据
 */
class DataMemory extends Module {
  val io = IO(new Bundle {
    /* input */
    val valid = Input(Bool())
    val memRead = Input(Bool())
    val memWrite = Input(Bool())
    val address = Input(UInt(64.W))
    val writeData = Input(UInt(64.W))
    val bitType = Input(UInt(2.W))
    val isUnsigned = Input(Bool())
    /* output */
    val readData = Output(UInt(64.W))
  })
  io.readData := 0.U
}

/**
 * <b>[[结果选择单元]]</b>
 * <p>
 * 根据控制信号选择所需要的结果
 * <p>
 * [[input]]
 *   - isJump : 若 isJump = True, 则将 PC+4 放入寄存器(保存返回地址)
 *   - immALUToReg : 将 立即数/ALU的结果 放入寄存器
 *   - memRead : 若 memRead = True, 则将 DataMemory 中取出的值放入寄存器
 *
 *   - readData : 从存储单元读取出的数据
 *   - aluResult : ALU 的计算结果
 *   - imm : 立即数
 *   - pcPlus4 : PC+4
 * <p>
 * [[output]]
 *   - out : 根据选择信号和输入的数据, 得出结果用于存入寄存器
 */
class ResSelectUnit extends Module {
  val io = IO(new Bundle {
    /* input */
    val isJump = Input(Bool())
    val immALUToReg = Input(Bool())
    val memRead = Input(Bool())
    val readData = Input(UInt(64.W))
    val aluResult = Input(UInt(64.W))
    val imm = Input(UInt(64.W))
    val pcPlus4 = Input(UInt(64.W))
    /* output */
    val out = Output(UInt(64.W))
  })
  io.out := 0.U
}

/**
 * <b>[[PC地址选择单元]]</b>
 * <p>
 * 用于根据输入的控制信号来选择对应的 PC 进行输出
 * <p>
 * [[input]]
 *   - pcPlus4 : PC+4
 *   - pcPlusImm : PC+immediate
 *
 *   - isJALR : 为 true 则 next_pc 来源于 ALU, 1 for jalr
 *   - isBType : 是否为 B-type 指令, 1 for B-type
 *   - isJump : 是否为 jump 指令, 1 for jal/jalr
 *   - isTrue : 对于 B-type 指令, ALU 计算的结果是否满足跳转条件
 *               来源于 ALU.result[0]
 *
 *   - aluResult : ALU 的计算结果
 * <p>
 * [[output]]
 *   - nextPC : 下一个 PC
 */
class PCSelectUnit extends Module {
  val io = IO(new Bundle {
    /* input */
    val pcPlus4 = Input(UInt(64.W))
    val pcPlusImm = Input(UInt(64.W))
    val isJALR = Input(Bool())
    val isBType = Input(Bool())
    val isJump = Input(Bool())
    val isTrue = Input(Bool())
    val aluResult = Input(UInt(64.W))
    /* output */
    val nextPC = Output(UInt(64.W))
  })
  io.nextPC := 0.U
}

/**
 * <b>[[单周期 CPU]]</b>
 * <p>
 * CPU 顶层架构
 * <p>
 * [[output]]
 *   - isValidInst : 当前执行的指令是否有效
 */
class SingleCycleCPU extends Module {
  val io = IO(new Bundle {
    val isValidInst = Output(Bool())
  })

  val pcReg = Module(new PCReg())
  val pcAdd4 = Module(new Adder())
  val pcAddImm = Module(new Adder())
  val instMemory = Module(new InstMemeory())
  val controlUnit = Module(new ControlUnit())
  val inst2ImmUnit = Module(new Inst2ImmUnit())
  val regUnit = Module(new RegUnit())
  val aluControlUnit = Module(new ALUControlUnit())
  val pcSelectUnit = Module(new PCSelectUnit())
  val alu = Module(new ALU())
  val dataMemory = Module(new DataMemory())
  val resSelectUnit = Module(new ResSelectUnit())

  pcReg.io.in := pcSelectUnit.io.nextPC

  pcAdd4.io.x := 4.U
  pcAdd4.io.y := pcReg.io.out

  pcAddImm.io.x := pcReg.io.out
  pcAddImm.io.y := inst2ImmUnit.io.imm

  instMemory.io.address := pcReg.io.out

  controlUnit.io.opcode := instMemory.io.inst(6, 0)

  inst2ImmUnit.io.inst := instMemory.io.inst

  regUnit.io.rs1 := instMemory.io.inst(19, 15)
  regUnit.io.rs2 := instMemory.io.inst(24, 20)
  regUnit.io.rd := instMemory.io.inst(11, 7)
  regUnit.io.writeEnable := controlUnit.io.ifWriteToReg
  regUnit.io.writeData := resSelectUnit.io.out

  pcSelectUnit.io.pcPlus4 := pcAdd4.io.out
  pcSelectUnit.io.pcPlusImm := pcAddImm.io.out
  pcSelectUnit.io.isJump := controlUnit.io.isJump
  pcSelectUnit.io.isBType := controlUnit.io.isBType
  pcSelectUnit.io.isJALR := controlUnit.io.isJALR
  pcSelectUnit.io.isTrue := alu.io.result(0)
  pcSelectUnit.io.aluResult := alu.io.result

  aluControlUnit.io.isBType := controlUnit.io.isBType
  aluControlUnit.io.isIType := controlUnit.io.isIType
  aluControlUnit.io.isRType := controlUnit.io.isRType
  aluControlUnit.io.isWord := controlUnit.io.isWord
  aluControlUnit.io.funct3 := instMemory.io.inst(14, 12)
  aluControlUnit.io.funct7 := instMemory.io.inst(31, 25)

  alu.io.aluOperation := aluControlUnit.io.aluOperation
  alu.io.x := Mux(
    controlUnit.io.pcRs1ToALU,
    pcReg.io.out,
    regUnit.io.readDataRs1
  )
  alu.io.y := Mux(
    controlUnit.io.immRs2ToALU,
    inst2ImmUnit.io.imm,
    regUnit.io.readDataRs2
  )

  dataMemory.io.valid := controlUnit.io.memRead & controlUnit.io.memWrite
  dataMemory.io.memRead := controlUnit.io.memRead
  dataMemory.io.memWrite := controlUnit.io.memWrite
  dataMemory.io.address := alu.io.result
  dataMemory.io.writeData := regUnit.io.readDataRs2
  dataMemory.io.bitType := instMemory.io.inst(13, 12)
  dataMemory.io.isUnsigned := instMemory.io.inst(14)

  resSelectUnit.io.memRead := controlUnit.io.memRead
  resSelectUnit.io.isJump := controlUnit.io.isJump
  resSelectUnit.io.immALUToReg := controlUnit.io.immALUToReg
  resSelectUnit.io.readData := dataMemory.io.readData
  resSelectUnit.io.aluResult := alu.io.result
  resSelectUnit.io.imm := inst2ImmUnit.io.imm
  resSelectUnit.io.pcPlus4 := pcAdd4.io.out

  io.isValidInst := controlUnit.io.isValidInst
}

object Design {
  def main(args: Array[String]) = {
    print(getVerilogString(new SingleCycleCPU()))

    print("\n[Success]\n")
  }
}
