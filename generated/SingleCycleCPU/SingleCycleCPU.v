module PCReg(
  input         clock,
  input         reset,
  input  [63:0] io_in,
  output [63:0] io_out
);
`ifdef RANDOMIZE_REG_INIT
  reg [63:0] _RAND_0;
`endif // RANDOMIZE_REG_INIT
  reg [63:0] pcReg; // @[PCReg.scala 26:22]
  assign io_out = pcReg; // @[PCReg.scala 29:10]
  always @(posedge clock) begin
    if (reset) begin // @[PCReg.scala 26:22]
      pcReg <= 64'h0; // @[PCReg.scala 26:22]
    end else begin
      pcReg <= io_in; // @[PCReg.scala 28:9]
    end
  end
// Register and memory initialization
`ifdef RANDOMIZE_GARBAGE_ASSIGN
`define RANDOMIZE
`endif
`ifdef RANDOMIZE_INVALID_ASSIGN
`define RANDOMIZE
`endif
`ifdef RANDOMIZE_REG_INIT
`define RANDOMIZE
`endif
`ifdef RANDOMIZE_MEM_INIT
`define RANDOMIZE
`endif
`ifndef RANDOM
`define RANDOM $random
`endif
`ifdef RANDOMIZE_MEM_INIT
  integer initvar;
`endif
`ifndef SYNTHESIS
`ifdef FIRRTL_BEFORE_INITIAL
`FIRRTL_BEFORE_INITIAL
`endif
initial begin
  `ifdef RANDOMIZE
    `ifdef INIT_RANDOM
      `INIT_RANDOM
    `endif
    `ifndef VERILATOR
      `ifdef RANDOMIZE_DELAY
        #`RANDOMIZE_DELAY begin end
      `else
        #0.002 begin end
      `endif
    `endif
`ifdef RANDOMIZE_REG_INIT
  _RAND_0 = {2{`RANDOM}};
  pcReg = _RAND_0[63:0];
`endif // RANDOMIZE_REG_INIT
  `endif // RANDOMIZE
end // initial
`ifdef FIRRTL_AFTER_INITIAL
`FIRRTL_AFTER_INITIAL
`endif
`endif // SYNTHESIS
endmodule
module Adder(
  input  [63:0] io_x,
  input  [63:0] io_y,
  output [63:0] io_out
);
  assign io_out = io_x + io_y; // @[CPUUtils.scala 36:18]
endmodule
module InstMemory(
  input         clock,
  input  [63:0] io_address,
  output [31:0] io_inst
);
`ifdef RANDOMIZE_MEM_INIT
  reg [31:0] _RAND_0;
  reg [31:0] _RAND_1;
  reg [31:0] _RAND_2;
  reg [31:0] _RAND_3;
`endif // RANDOMIZE_MEM_INIT
  reg [7:0] instMem_0 [0:1023]; // @[InstMemory.scala 32:20]
  wire  instMem_0_io_inst_MPORT_en; // @[InstMemory.scala 32:20]
  wire [9:0] instMem_0_io_inst_MPORT_addr; // @[InstMemory.scala 32:20]
  wire [7:0] instMem_0_io_inst_MPORT_data; // @[InstMemory.scala 32:20]
  reg [7:0] instMem_1 [0:1023]; // @[InstMemory.scala 32:20]
  wire  instMem_1_io_inst_MPORT_en; // @[InstMemory.scala 32:20]
  wire [9:0] instMem_1_io_inst_MPORT_addr; // @[InstMemory.scala 32:20]
  wire [7:0] instMem_1_io_inst_MPORT_data; // @[InstMemory.scala 32:20]
  reg [7:0] instMem_2 [0:1023]; // @[InstMemory.scala 32:20]
  wire  instMem_2_io_inst_MPORT_en; // @[InstMemory.scala 32:20]
  wire [9:0] instMem_2_io_inst_MPORT_addr; // @[InstMemory.scala 32:20]
  wire [7:0] instMem_2_io_inst_MPORT_data; // @[InstMemory.scala 32:20]
  reg [7:0] instMem_3 [0:1023]; // @[InstMemory.scala 32:20]
  wire  instMem_3_io_inst_MPORT_en; // @[InstMemory.scala 32:20]
  wire [9:0] instMem_3_io_inst_MPORT_addr; // @[InstMemory.scala 32:20]
  wire [7:0] instMem_3_io_inst_MPORT_data; // @[InstMemory.scala 32:20]
  wire [63:0] address = {{2'd0}, io_address[63:2]}; // @[InstMemory.scala 34:28]
  wire [15:0] io_inst_lo = {instMem_1_io_inst_MPORT_data,instMem_0_io_inst_MPORT_data}; // @[InstMemory.scala 37:36]
  wire [15:0] io_inst_hi = {instMem_3_io_inst_MPORT_data,instMem_2_io_inst_MPORT_data}; // @[InstMemory.scala 37:36]
  assign instMem_0_io_inst_MPORT_en = 1'h1;
  assign instMem_0_io_inst_MPORT_addr = address[9:0];
  assign instMem_0_io_inst_MPORT_data = instMem_0[instMem_0_io_inst_MPORT_addr]; // @[InstMemory.scala 32:20]
  assign instMem_1_io_inst_MPORT_en = 1'h1;
  assign instMem_1_io_inst_MPORT_addr = address[9:0];
  assign instMem_1_io_inst_MPORT_data = instMem_1[instMem_1_io_inst_MPORT_addr]; // @[InstMemory.scala 32:20]
  assign instMem_2_io_inst_MPORT_en = 1'h1;
  assign instMem_2_io_inst_MPORT_addr = address[9:0];
  assign instMem_2_io_inst_MPORT_data = instMem_2[instMem_2_io_inst_MPORT_addr]; // @[InstMemory.scala 32:20]
  assign instMem_3_io_inst_MPORT_en = 1'h1;
  assign instMem_3_io_inst_MPORT_addr = address[9:0];
  assign instMem_3_io_inst_MPORT_data = instMem_3[instMem_3_io_inst_MPORT_addr]; // @[InstMemory.scala 32:20]
  assign io_inst = {io_inst_hi,io_inst_lo}; // @[InstMemory.scala 37:36]
// Register and memory initialization
`ifdef RANDOMIZE_GARBAGE_ASSIGN
`define RANDOMIZE
`endif
`ifdef RANDOMIZE_INVALID_ASSIGN
`define RANDOMIZE
`endif
`ifdef RANDOMIZE_REG_INIT
`define RANDOMIZE
`endif
`ifdef RANDOMIZE_MEM_INIT
`define RANDOMIZE
`endif
`ifndef RANDOM
`define RANDOM $random
`endif
`ifdef RANDOMIZE_MEM_INIT
  integer initvar;
`endif
`ifndef SYNTHESIS
`ifdef FIRRTL_BEFORE_INITIAL
`FIRRTL_BEFORE_INITIAL
`endif
initial begin
  `ifdef RANDOMIZE
    `ifdef INIT_RANDOM
      `INIT_RANDOM
    `endif
    `ifndef VERILATOR
      `ifdef RANDOMIZE_DELAY
        #`RANDOMIZE_DELAY begin end
      `else
        #0.002 begin end
      `endif
    `endif
`ifdef RANDOMIZE_MEM_INIT
  _RAND_0 = {1{`RANDOM}};
  for (initvar = 0; initvar < 1024; initvar = initvar+1)
    instMem_0[initvar] = _RAND_0[7:0];
  _RAND_1 = {1{`RANDOM}};
  for (initvar = 0; initvar < 1024; initvar = initvar+1)
    instMem_1[initvar] = _RAND_1[7:0];
  _RAND_2 = {1{`RANDOM}};
  for (initvar = 0; initvar < 1024; initvar = initvar+1)
    instMem_2[initvar] = _RAND_2[7:0];
  _RAND_3 = {1{`RANDOM}};
  for (initvar = 0; initvar < 1024; initvar = initvar+1)
    instMem_3[initvar] = _RAND_3[7:0];
`endif // RANDOMIZE_MEM_INIT
  `endif // RANDOMIZE
end // initial
`ifdef FIRRTL_AFTER_INITIAL
`FIRRTL_AFTER_INITIAL
`endif
`endif // SYNTHESIS
endmodule
module ControlUnit(
  input  [6:0] io_opcode,
  output       io_isJALR,
  output       io_isBType,
  output       io_isJump,
  output       io_immALUToReg,
  output       io_memRead,
  output       io_memWrite,
  output       io_immRs2ToALU,
  output       io_pcRs1ToALU,
  output       io_isIType,
  output       io_isRType,
  output       io_isWord,
  output       io_ifWriteToReg,
  output       io_isValidInst
);
  wire  controlSignals_3 = 7'h37 == io_opcode; // @[Lookup.scala 31:38]
  wire  _controlSignals_T_3 = 7'h17 == io_opcode; // @[Lookup.scala 31:38]
  wire  _controlSignals_T_5 = 7'h6f == io_opcode; // @[Lookup.scala 31:38]
  wire  _controlSignals_T_7 = 7'h67 == io_opcode; // @[Lookup.scala 31:38]
  wire  _controlSignals_T_9 = 7'h63 == io_opcode; // @[Lookup.scala 31:38]
  wire  _controlSignals_T_11 = 7'h3 == io_opcode; // @[Lookup.scala 31:38]
  wire  _controlSignals_T_13 = 7'h23 == io_opcode; // @[Lookup.scala 31:38]
  wire  _controlSignals_T_15 = 7'h13 == io_opcode; // @[Lookup.scala 31:38]
  wire  _controlSignals_T_17 = 7'h1b == io_opcode; // @[Lookup.scala 31:38]
  wire  _controlSignals_T_19 = 7'h33 == io_opcode; // @[Lookup.scala 31:38]
  wire  _controlSignals_T_21 = 7'h3b == io_opcode; // @[Lookup.scala 31:38]
  wire  _controlSignals_T_30 = _controlSignals_T_5 ? 1'h0 : _controlSignals_T_7; // @[Lookup.scala 34:39]
  wire  _controlSignals_T_31 = _controlSignals_T_3 ? 1'h0 : _controlSignals_T_30; // @[Lookup.scala 34:39]
  wire  _controlSignals_T_39 = _controlSignals_T_7 ? 1'h0 : _controlSignals_T_9; // @[Lookup.scala 34:39]
  wire  _controlSignals_T_40 = _controlSignals_T_5 ? 1'h0 : _controlSignals_T_39; // @[Lookup.scala 34:39]
  wire  _controlSignals_T_41 = _controlSignals_T_3 ? 1'h0 : _controlSignals_T_40; // @[Lookup.scala 34:39]
  wire  _controlSignals_T_51 = _controlSignals_T_3 ? 1'h0 : _controlSignals_T_5 | _controlSignals_T_7; // @[Lookup.scala 34:39]
  wire  _controlSignals_T_68 = _controlSignals_T_9 ? 1'h0 : _controlSignals_T_11; // @[Lookup.scala 34:39]
  wire  _controlSignals_T_69 = _controlSignals_T_7 ? 1'h0 : _controlSignals_T_68; // @[Lookup.scala 34:39]
  wire  _controlSignals_T_70 = _controlSignals_T_5 ? 1'h0 : _controlSignals_T_69; // @[Lookup.scala 34:39]
  wire  _controlSignals_T_71 = _controlSignals_T_3 ? 1'h0 : _controlSignals_T_70; // @[Lookup.scala 34:39]
  wire  _controlSignals_T_77 = _controlSignals_T_11 ? 1'h0 : _controlSignals_T_13; // @[Lookup.scala 34:39]
  wire  _controlSignals_T_78 = _controlSignals_T_9 ? 1'h0 : _controlSignals_T_77; // @[Lookup.scala 34:39]
  wire  _controlSignals_T_79 = _controlSignals_T_7 ? 1'h0 : _controlSignals_T_78; // @[Lookup.scala 34:39]
  wire  _controlSignals_T_80 = _controlSignals_T_5 ? 1'h0 : _controlSignals_T_79; // @[Lookup.scala 34:39]
  wire  _controlSignals_T_81 = _controlSignals_T_3 ? 1'h0 : _controlSignals_T_80; // @[Lookup.scala 34:39]
  wire  _controlSignals_T_88 = _controlSignals_T_9 ? 1'h0 : _controlSignals_T_11 | (_controlSignals_T_13 | (
    _controlSignals_T_15 | _controlSignals_T_17)); // @[Lookup.scala 34:39]
  wire  _controlSignals_T_90 = _controlSignals_T_5 ? 1'h0 : _controlSignals_T_7 | _controlSignals_T_88; // @[Lookup.scala 34:39]
  wire  _controlSignals_T_106 = _controlSignals_T_13 ? 1'h0 : _controlSignals_T_15 | _controlSignals_T_17; // @[Lookup.scala 34:39]
  wire  _controlSignals_T_107 = _controlSignals_T_11 ? 1'h0 : _controlSignals_T_106; // @[Lookup.scala 34:39]
  wire  _controlSignals_T_108 = _controlSignals_T_9 ? 1'h0 : _controlSignals_T_107; // @[Lookup.scala 34:39]
  wire  _controlSignals_T_109 = _controlSignals_T_7 ? 1'h0 : _controlSignals_T_108; // @[Lookup.scala 34:39]
  wire  _controlSignals_T_110 = _controlSignals_T_5 ? 1'h0 : _controlSignals_T_109; // @[Lookup.scala 34:39]
  wire  _controlSignals_T_111 = _controlSignals_T_3 ? 1'h0 : _controlSignals_T_110; // @[Lookup.scala 34:39]
  wire  _controlSignals_T_114 = _controlSignals_T_17 ? 1'h0 : _controlSignals_T_19 | _controlSignals_T_21; // @[Lookup.scala 34:39]
  wire  _controlSignals_T_115 = _controlSignals_T_15 ? 1'h0 : _controlSignals_T_114; // @[Lookup.scala 34:39]
  wire  _controlSignals_T_116 = _controlSignals_T_13 ? 1'h0 : _controlSignals_T_115; // @[Lookup.scala 34:39]
  wire  _controlSignals_T_117 = _controlSignals_T_11 ? 1'h0 : _controlSignals_T_116; // @[Lookup.scala 34:39]
  wire  _controlSignals_T_118 = _controlSignals_T_9 ? 1'h0 : _controlSignals_T_117; // @[Lookup.scala 34:39]
  wire  _controlSignals_T_119 = _controlSignals_T_7 ? 1'h0 : _controlSignals_T_118; // @[Lookup.scala 34:39]
  wire  _controlSignals_T_120 = _controlSignals_T_5 ? 1'h0 : _controlSignals_T_119; // @[Lookup.scala 34:39]
  wire  _controlSignals_T_121 = _controlSignals_T_3 ? 1'h0 : _controlSignals_T_120; // @[Lookup.scala 34:39]
  wire  _controlSignals_T_123 = _controlSignals_T_19 ? 1'h0 : _controlSignals_T_21; // @[Lookup.scala 34:39]
  wire  _controlSignals_T_125 = _controlSignals_T_15 ? 1'h0 : _controlSignals_T_17 | _controlSignals_T_123; // @[Lookup.scala 34:39]
  wire  _controlSignals_T_126 = _controlSignals_T_13 ? 1'h0 : _controlSignals_T_125; // @[Lookup.scala 34:39]
  wire  _controlSignals_T_127 = _controlSignals_T_11 ? 1'h0 : _controlSignals_T_126; // @[Lookup.scala 34:39]
  wire  _controlSignals_T_128 = _controlSignals_T_9 ? 1'h0 : _controlSignals_T_127; // @[Lookup.scala 34:39]
  wire  _controlSignals_T_129 = _controlSignals_T_7 ? 1'h0 : _controlSignals_T_128; // @[Lookup.scala 34:39]
  wire  _controlSignals_T_130 = _controlSignals_T_5 ? 1'h0 : _controlSignals_T_129; // @[Lookup.scala 34:39]
  wire  _controlSignals_T_131 = _controlSignals_T_3 ? 1'h0 : _controlSignals_T_130; // @[Lookup.scala 34:39]
  wire  _controlSignals_T_136 = _controlSignals_T_13 ? 1'h0 : _controlSignals_T_15 | (_controlSignals_T_17 | (
    _controlSignals_T_19 | _controlSignals_T_21)); // @[Lookup.scala 34:39]
  wire  _controlSignals_T_138 = _controlSignals_T_9 ? 1'h0 : _controlSignals_T_11 | _controlSignals_T_136; // @[Lookup.scala 34:39]
  assign io_isJALR = controlSignals_3 ? 1'h0 : _controlSignals_T_31; // @[Lookup.scala 34:39]
  assign io_isBType = controlSignals_3 ? 1'h0 : _controlSignals_T_41; // @[Lookup.scala 34:39]
  assign io_isJump = controlSignals_3 ? 1'h0 : _controlSignals_T_51; // @[Lookup.scala 34:39]
  assign io_immALUToReg = 7'h37 == io_opcode; // @[Lookup.scala 31:38]
  assign io_memRead = controlSignals_3 ? 1'h0 : _controlSignals_T_71; // @[Lookup.scala 34:39]
  assign io_memWrite = controlSignals_3 ? 1'h0 : _controlSignals_T_81; // @[Lookup.scala 34:39]
  assign io_immRs2ToALU = controlSignals_3 ? 1'h0 : _controlSignals_T_3 | _controlSignals_T_90; // @[Lookup.scala 34:39]
  assign io_pcRs1ToALU = controlSignals_3 ? 1'h0 : _controlSignals_T_3; // @[Lookup.scala 34:39]
  assign io_isIType = controlSignals_3 ? 1'h0 : _controlSignals_T_111; // @[Lookup.scala 34:39]
  assign io_isRType = controlSignals_3 ? 1'h0 : _controlSignals_T_121; // @[Lookup.scala 34:39]
  assign io_isWord = controlSignals_3 ? 1'h0 : _controlSignals_T_131; // @[Lookup.scala 34:39]
  assign io_ifWriteToReg = controlSignals_3 | (_controlSignals_T_3 | (_controlSignals_T_5 | (_controlSignals_T_7 |
    _controlSignals_T_138))); // @[Lookup.scala 34:39]
  assign io_isValidInst = controlSignals_3 | (_controlSignals_T_3 | (_controlSignals_T_5 | (_controlSignals_T_7 | (
    _controlSignals_T_9 | (_controlSignals_T_11 | (_controlSignals_T_13 | (_controlSignals_T_15 | (_controlSignals_T_17
     | (_controlSignals_T_19 | _controlSignals_T_21))))))))); // @[Lookup.scala 34:39]
endmodule
module Inst2ImmUnit(
  input  [31:0] io_inst,
  output [63:0] io_imm
);
  wire [6:0] opcode = io_inst[6:0]; // @[Inst2ImmUnit.scala 28:23]
  wire [52:0] _immWire_T_2 = io_inst[31] ? 53'h1fffffffffffff : 53'h0; // @[Bitwise.scala 77:12]
  wire [63:0] _immWire_T_6 = {_immWire_T_2,io_inst[30:25],io_inst[24:21],io_inst[20]}; // @[Cat.scala 33:92]
  wire [63:0] _immWire_T_34 = {_immWire_T_2,io_inst[30:25],io_inst[11:8],io_inst[7]}; // @[Cat.scala 33:92]
  wire [51:0] _immWire_T_37 = io_inst[31] ? 52'hfffffffffffff : 52'h0; // @[Bitwise.scala 77:12]
  wire [63:0] _immWire_T_41 = {_immWire_T_37,io_inst[7],io_inst[30:25],io_inst[11:8],1'h0}; // @[Cat.scala 33:92]
  wire [32:0] _immWire_T_44 = io_inst[31] ? 33'h1ffffffff : 33'h0; // @[Bitwise.scala 77:12]
  wire [63:0] _immWire_T_48 = {_immWire_T_44,io_inst[30:20],io_inst[19:12],12'h0}; // @[Cat.scala 33:92]
  wire [43:0] _immWire_T_58 = io_inst[31] ? 44'hfffffffffff : 44'h0; // @[Bitwise.scala 77:12]
  wire [63:0] _immWire_T_63 = {_immWire_T_58,io_inst[19:12],io_inst[20],io_inst[30:25],io_inst[24:21],1'h0}; // @[Cat.scala 33:92]
  wire [63:0] _GEN_0 = 7'h6f == opcode ? _immWire_T_63 : 64'h0; // @[Inst2ImmUnit.scala 32:18 68:15]
  wire [63:0] _GEN_1 = 7'h17 == opcode ? _immWire_T_48 : _GEN_0; // @[Inst2ImmUnit.scala 32:18 63:15]
  wire [63:0] _GEN_2 = 7'h37 == opcode ? _immWire_T_48 : _GEN_1; // @[Inst2ImmUnit.scala 32:18 60:15]
  wire [63:0] _GEN_3 = 7'h63 == opcode ? _immWire_T_41 : _GEN_2; // @[Inst2ImmUnit.scala 32:18 55:15]
  wire [63:0] _GEN_4 = 7'h23 == opcode ? _immWire_T_34 : _GEN_3; // @[Inst2ImmUnit.scala 32:18 50:15]
  wire [63:0] _GEN_5 = 7'h1b == opcode ? _immWire_T_6 : _GEN_4; // @[Inst2ImmUnit.scala 32:18 45:15]
  wire [63:0] _GEN_6 = 7'h13 == opcode ? _immWire_T_6 : _GEN_5; // @[Inst2ImmUnit.scala 32:18 42:15]
  wire [63:0] _GEN_7 = 7'h3 == opcode ? _immWire_T_6 : _GEN_6; // @[Inst2ImmUnit.scala 32:18 39:15]
  assign io_imm = 7'h67 == opcode ? _immWire_T_6 : _GEN_7; // @[Inst2ImmUnit.scala 32:18 36:15]
endmodule
module RegUnit(
  input         clock,
  input         reset,
  input  [4:0]  io_rs1,
  input  [4:0]  io_rs2,
  input  [4:0]  io_rd,
  input         io_writeEnable,
  input  [63:0] io_writeData,
  output [63:0] io_readDataRs1,
  output [63:0] io_readDataRs2,
  output [63:0] io_regAll_1,
  output [63:0] io_regAll_2,
  output [63:0] io_regAll_3,
  output [63:0] io_regAll_4,
  output [63:0] io_regAll_5,
  output [63:0] io_regAll_6,
  output [63:0] io_regAll_7,
  output [63:0] io_regAll_8,
  output [63:0] io_regAll_9,
  output [63:0] io_regAll_10,
  output [63:0] io_regAll_11,
  output [63:0] io_regAll_12,
  output [63:0] io_regAll_13,
  output [63:0] io_regAll_14,
  output [63:0] io_regAll_15,
  output [63:0] io_regAll_16,
  output [63:0] io_regAll_17,
  output [63:0] io_regAll_18,
  output [63:0] io_regAll_19,
  output [63:0] io_regAll_20,
  output [63:0] io_regAll_21,
  output [63:0] io_regAll_22,
  output [63:0] io_regAll_23,
  output [63:0] io_regAll_24,
  output [63:0] io_regAll_25,
  output [63:0] io_regAll_26,
  output [63:0] io_regAll_27,
  output [63:0] io_regAll_28,
  output [63:0] io_regAll_29,
  output [63:0] io_regAll_30,
  output [63:0] io_regAll_31
);
`ifdef RANDOMIZE_REG_INIT
  reg [63:0] _RAND_0;
  reg [63:0] _RAND_1;
  reg [63:0] _RAND_2;
  reg [63:0] _RAND_3;
  reg [63:0] _RAND_4;
  reg [63:0] _RAND_5;
  reg [63:0] _RAND_6;
  reg [63:0] _RAND_7;
  reg [63:0] _RAND_8;
  reg [63:0] _RAND_9;
  reg [63:0] _RAND_10;
  reg [63:0] _RAND_11;
  reg [63:0] _RAND_12;
  reg [63:0] _RAND_13;
  reg [63:0] _RAND_14;
  reg [63:0] _RAND_15;
  reg [63:0] _RAND_16;
  reg [63:0] _RAND_17;
  reg [63:0] _RAND_18;
  reg [63:0] _RAND_19;
  reg [63:0] _RAND_20;
  reg [63:0] _RAND_21;
  reg [63:0] _RAND_22;
  reg [63:0] _RAND_23;
  reg [63:0] _RAND_24;
  reg [63:0] _RAND_25;
  reg [63:0] _RAND_26;
  reg [63:0] _RAND_27;
  reg [63:0] _RAND_28;
  reg [63:0] _RAND_29;
  reg [63:0] _RAND_30;
  reg [63:0] _RAND_31;
`endif // RANDOMIZE_REG_INIT
  reg [63:0] regGroup_0; // @[RegUnit.scala 47:25]
  reg [63:0] regGroup_1; // @[RegUnit.scala 47:25]
  reg [63:0] regGroup_2; // @[RegUnit.scala 47:25]
  reg [63:0] regGroup_3; // @[RegUnit.scala 47:25]
  reg [63:0] regGroup_4; // @[RegUnit.scala 47:25]
  reg [63:0] regGroup_5; // @[RegUnit.scala 47:25]
  reg [63:0] regGroup_6; // @[RegUnit.scala 47:25]
  reg [63:0] regGroup_7; // @[RegUnit.scala 47:25]
  reg [63:0] regGroup_8; // @[RegUnit.scala 47:25]
  reg [63:0] regGroup_9; // @[RegUnit.scala 47:25]
  reg [63:0] regGroup_10; // @[RegUnit.scala 47:25]
  reg [63:0] regGroup_11; // @[RegUnit.scala 47:25]
  reg [63:0] regGroup_12; // @[RegUnit.scala 47:25]
  reg [63:0] regGroup_13; // @[RegUnit.scala 47:25]
  reg [63:0] regGroup_14; // @[RegUnit.scala 47:25]
  reg [63:0] regGroup_15; // @[RegUnit.scala 47:25]
  reg [63:0] regGroup_16; // @[RegUnit.scala 47:25]
  reg [63:0] regGroup_17; // @[RegUnit.scala 47:25]
  reg [63:0] regGroup_18; // @[RegUnit.scala 47:25]
  reg [63:0] regGroup_19; // @[RegUnit.scala 47:25]
  reg [63:0] regGroup_20; // @[RegUnit.scala 47:25]
  reg [63:0] regGroup_21; // @[RegUnit.scala 47:25]
  reg [63:0] regGroup_22; // @[RegUnit.scala 47:25]
  reg [63:0] regGroup_23; // @[RegUnit.scala 47:25]
  reg [63:0] regGroup_24; // @[RegUnit.scala 47:25]
  reg [63:0] regGroup_25; // @[RegUnit.scala 47:25]
  reg [63:0] regGroup_26; // @[RegUnit.scala 47:25]
  reg [63:0] regGroup_27; // @[RegUnit.scala 47:25]
  reg [63:0] regGroup_28; // @[RegUnit.scala 47:25]
  reg [63:0] regGroup_29; // @[RegUnit.scala 47:25]
  reg [63:0] regGroup_30; // @[RegUnit.scala 47:25]
  reg [63:0] regGroup_31; // @[RegUnit.scala 47:25]
  wire [63:0] _GEN_1 = 5'h1 == io_rs1 ? regGroup_1 : regGroup_0; // @[RegUnit.scala 50:{24,24}]
  wire [63:0] _GEN_2 = 5'h2 == io_rs1 ? regGroup_2 : _GEN_1; // @[RegUnit.scala 50:{24,24}]
  wire [63:0] _GEN_3 = 5'h3 == io_rs1 ? regGroup_3 : _GEN_2; // @[RegUnit.scala 50:{24,24}]
  wire [63:0] _GEN_4 = 5'h4 == io_rs1 ? regGroup_4 : _GEN_3; // @[RegUnit.scala 50:{24,24}]
  wire [63:0] _GEN_5 = 5'h5 == io_rs1 ? regGroup_5 : _GEN_4; // @[RegUnit.scala 50:{24,24}]
  wire [63:0] _GEN_6 = 5'h6 == io_rs1 ? regGroup_6 : _GEN_5; // @[RegUnit.scala 50:{24,24}]
  wire [63:0] _GEN_7 = 5'h7 == io_rs1 ? regGroup_7 : _GEN_6; // @[RegUnit.scala 50:{24,24}]
  wire [63:0] _GEN_8 = 5'h8 == io_rs1 ? regGroup_8 : _GEN_7; // @[RegUnit.scala 50:{24,24}]
  wire [63:0] _GEN_9 = 5'h9 == io_rs1 ? regGroup_9 : _GEN_8; // @[RegUnit.scala 50:{24,24}]
  wire [63:0] _GEN_10 = 5'ha == io_rs1 ? regGroup_10 : _GEN_9; // @[RegUnit.scala 50:{24,24}]
  wire [63:0] _GEN_11 = 5'hb == io_rs1 ? regGroup_11 : _GEN_10; // @[RegUnit.scala 50:{24,24}]
  wire [63:0] _GEN_12 = 5'hc == io_rs1 ? regGroup_12 : _GEN_11; // @[RegUnit.scala 50:{24,24}]
  wire [63:0] _GEN_13 = 5'hd == io_rs1 ? regGroup_13 : _GEN_12; // @[RegUnit.scala 50:{24,24}]
  wire [63:0] _GEN_14 = 5'he == io_rs1 ? regGroup_14 : _GEN_13; // @[RegUnit.scala 50:{24,24}]
  wire [63:0] _GEN_15 = 5'hf == io_rs1 ? regGroup_15 : _GEN_14; // @[RegUnit.scala 50:{24,24}]
  wire [63:0] _GEN_16 = 5'h10 == io_rs1 ? regGroup_16 : _GEN_15; // @[RegUnit.scala 50:{24,24}]
  wire [63:0] _GEN_17 = 5'h11 == io_rs1 ? regGroup_17 : _GEN_16; // @[RegUnit.scala 50:{24,24}]
  wire [63:0] _GEN_18 = 5'h12 == io_rs1 ? regGroup_18 : _GEN_17; // @[RegUnit.scala 50:{24,24}]
  wire [63:0] _GEN_19 = 5'h13 == io_rs1 ? regGroup_19 : _GEN_18; // @[RegUnit.scala 50:{24,24}]
  wire [63:0] _GEN_20 = 5'h14 == io_rs1 ? regGroup_20 : _GEN_19; // @[RegUnit.scala 50:{24,24}]
  wire [63:0] _GEN_21 = 5'h15 == io_rs1 ? regGroup_21 : _GEN_20; // @[RegUnit.scala 50:{24,24}]
  wire [63:0] _GEN_22 = 5'h16 == io_rs1 ? regGroup_22 : _GEN_21; // @[RegUnit.scala 50:{24,24}]
  wire [63:0] _GEN_23 = 5'h17 == io_rs1 ? regGroup_23 : _GEN_22; // @[RegUnit.scala 50:{24,24}]
  wire [63:0] _GEN_24 = 5'h18 == io_rs1 ? regGroup_24 : _GEN_23; // @[RegUnit.scala 50:{24,24}]
  wire [63:0] _GEN_25 = 5'h19 == io_rs1 ? regGroup_25 : _GEN_24; // @[RegUnit.scala 50:{24,24}]
  wire [63:0] _GEN_26 = 5'h1a == io_rs1 ? regGroup_26 : _GEN_25; // @[RegUnit.scala 50:{24,24}]
  wire [63:0] _GEN_27 = 5'h1b == io_rs1 ? regGroup_27 : _GEN_26; // @[RegUnit.scala 50:{24,24}]
  wire [63:0] _GEN_28 = 5'h1c == io_rs1 ? regGroup_28 : _GEN_27; // @[RegUnit.scala 50:{24,24}]
  wire [63:0] _GEN_29 = 5'h1d == io_rs1 ? regGroup_29 : _GEN_28; // @[RegUnit.scala 50:{24,24}]
  wire [63:0] _GEN_30 = 5'h1e == io_rs1 ? regGroup_30 : _GEN_29; // @[RegUnit.scala 50:{24,24}]
  wire [63:0] _GEN_31 = 5'h1f == io_rs1 ? regGroup_31 : _GEN_30; // @[RegUnit.scala 50:{24,24}]
  wire [63:0] _GEN_33 = 5'h1 == io_rs2 ? regGroup_1 : regGroup_0; // @[RegUnit.scala 51:{24,24}]
  wire [63:0] _GEN_34 = 5'h2 == io_rs2 ? regGroup_2 : _GEN_33; // @[RegUnit.scala 51:{24,24}]
  wire [63:0] _GEN_35 = 5'h3 == io_rs2 ? regGroup_3 : _GEN_34; // @[RegUnit.scala 51:{24,24}]
  wire [63:0] _GEN_36 = 5'h4 == io_rs2 ? regGroup_4 : _GEN_35; // @[RegUnit.scala 51:{24,24}]
  wire [63:0] _GEN_37 = 5'h5 == io_rs2 ? regGroup_5 : _GEN_36; // @[RegUnit.scala 51:{24,24}]
  wire [63:0] _GEN_38 = 5'h6 == io_rs2 ? regGroup_6 : _GEN_37; // @[RegUnit.scala 51:{24,24}]
  wire [63:0] _GEN_39 = 5'h7 == io_rs2 ? regGroup_7 : _GEN_38; // @[RegUnit.scala 51:{24,24}]
  wire [63:0] _GEN_40 = 5'h8 == io_rs2 ? regGroup_8 : _GEN_39; // @[RegUnit.scala 51:{24,24}]
  wire [63:0] _GEN_41 = 5'h9 == io_rs2 ? regGroup_9 : _GEN_40; // @[RegUnit.scala 51:{24,24}]
  wire [63:0] _GEN_42 = 5'ha == io_rs2 ? regGroup_10 : _GEN_41; // @[RegUnit.scala 51:{24,24}]
  wire [63:0] _GEN_43 = 5'hb == io_rs2 ? regGroup_11 : _GEN_42; // @[RegUnit.scala 51:{24,24}]
  wire [63:0] _GEN_44 = 5'hc == io_rs2 ? regGroup_12 : _GEN_43; // @[RegUnit.scala 51:{24,24}]
  wire [63:0] _GEN_45 = 5'hd == io_rs2 ? regGroup_13 : _GEN_44; // @[RegUnit.scala 51:{24,24}]
  wire [63:0] _GEN_46 = 5'he == io_rs2 ? regGroup_14 : _GEN_45; // @[RegUnit.scala 51:{24,24}]
  wire [63:0] _GEN_47 = 5'hf == io_rs2 ? regGroup_15 : _GEN_46; // @[RegUnit.scala 51:{24,24}]
  wire [63:0] _GEN_48 = 5'h10 == io_rs2 ? regGroup_16 : _GEN_47; // @[RegUnit.scala 51:{24,24}]
  wire [63:0] _GEN_49 = 5'h11 == io_rs2 ? regGroup_17 : _GEN_48; // @[RegUnit.scala 51:{24,24}]
  wire [63:0] _GEN_50 = 5'h12 == io_rs2 ? regGroup_18 : _GEN_49; // @[RegUnit.scala 51:{24,24}]
  wire [63:0] _GEN_51 = 5'h13 == io_rs2 ? regGroup_19 : _GEN_50; // @[RegUnit.scala 51:{24,24}]
  wire [63:0] _GEN_52 = 5'h14 == io_rs2 ? regGroup_20 : _GEN_51; // @[RegUnit.scala 51:{24,24}]
  wire [63:0] _GEN_53 = 5'h15 == io_rs2 ? regGroup_21 : _GEN_52; // @[RegUnit.scala 51:{24,24}]
  wire [63:0] _GEN_54 = 5'h16 == io_rs2 ? regGroup_22 : _GEN_53; // @[RegUnit.scala 51:{24,24}]
  wire [63:0] _GEN_55 = 5'h17 == io_rs2 ? regGroup_23 : _GEN_54; // @[RegUnit.scala 51:{24,24}]
  wire [63:0] _GEN_56 = 5'h18 == io_rs2 ? regGroup_24 : _GEN_55; // @[RegUnit.scala 51:{24,24}]
  wire [63:0] _GEN_57 = 5'h19 == io_rs2 ? regGroup_25 : _GEN_56; // @[RegUnit.scala 51:{24,24}]
  wire [63:0] _GEN_58 = 5'h1a == io_rs2 ? regGroup_26 : _GEN_57; // @[RegUnit.scala 51:{24,24}]
  wire [63:0] _GEN_59 = 5'h1b == io_rs2 ? regGroup_27 : _GEN_58; // @[RegUnit.scala 51:{24,24}]
  wire [63:0] _GEN_60 = 5'h1c == io_rs2 ? regGroup_28 : _GEN_59; // @[RegUnit.scala 51:{24,24}]
  wire [63:0] _GEN_61 = 5'h1d == io_rs2 ? regGroup_29 : _GEN_60; // @[RegUnit.scala 51:{24,24}]
  wire [63:0] _GEN_62 = 5'h1e == io_rs2 ? regGroup_30 : _GEN_61; // @[RegUnit.scala 51:{24,24}]
  wire [63:0] _GEN_63 = 5'h1f == io_rs2 ? regGroup_31 : _GEN_62; // @[RegUnit.scala 51:{24,24}]
  assign io_readDataRs1 = io_rs1 == 5'h0 ? 64'h0 : _GEN_31; // @[RegUnit.scala 50:24]
  assign io_readDataRs2 = io_rs2 == 5'h0 ? 64'h0 : _GEN_63; // @[RegUnit.scala 51:24]
  assign io_regAll_1 = regGroup_1; // @[RegUnit.scala 76:18]
  assign io_regAll_2 = regGroup_2; // @[RegUnit.scala 76:18]
  assign io_regAll_3 = regGroup_3; // @[RegUnit.scala 76:18]
  assign io_regAll_4 = regGroup_4; // @[RegUnit.scala 76:18]
  assign io_regAll_5 = regGroup_5; // @[RegUnit.scala 76:18]
  assign io_regAll_6 = regGroup_6; // @[RegUnit.scala 76:18]
  assign io_regAll_7 = regGroup_7; // @[RegUnit.scala 76:18]
  assign io_regAll_8 = regGroup_8; // @[RegUnit.scala 76:18]
  assign io_regAll_9 = regGroup_9; // @[RegUnit.scala 76:18]
  assign io_regAll_10 = regGroup_10; // @[RegUnit.scala 76:18]
  assign io_regAll_11 = regGroup_11; // @[RegUnit.scala 76:18]
  assign io_regAll_12 = regGroup_12; // @[RegUnit.scala 76:18]
  assign io_regAll_13 = regGroup_13; // @[RegUnit.scala 76:18]
  assign io_regAll_14 = regGroup_14; // @[RegUnit.scala 76:18]
  assign io_regAll_15 = regGroup_15; // @[RegUnit.scala 76:18]
  assign io_regAll_16 = regGroup_16; // @[RegUnit.scala 76:18]
  assign io_regAll_17 = regGroup_17; // @[RegUnit.scala 76:18]
  assign io_regAll_18 = regGroup_18; // @[RegUnit.scala 76:18]
  assign io_regAll_19 = regGroup_19; // @[RegUnit.scala 76:18]
  assign io_regAll_20 = regGroup_20; // @[RegUnit.scala 76:18]
  assign io_regAll_21 = regGroup_21; // @[RegUnit.scala 76:18]
  assign io_regAll_22 = regGroup_22; // @[RegUnit.scala 76:18]
  assign io_regAll_23 = regGroup_23; // @[RegUnit.scala 76:18]
  assign io_regAll_24 = regGroup_24; // @[RegUnit.scala 76:18]
  assign io_regAll_25 = regGroup_25; // @[RegUnit.scala 76:18]
  assign io_regAll_26 = regGroup_26; // @[RegUnit.scala 76:18]
  assign io_regAll_27 = regGroup_27; // @[RegUnit.scala 76:18]
  assign io_regAll_28 = regGroup_28; // @[RegUnit.scala 76:18]
  assign io_regAll_29 = regGroup_29; // @[RegUnit.scala 76:18]
  assign io_regAll_30 = regGroup_30; // @[RegUnit.scala 76:18]
  assign io_regAll_31 = regGroup_31; // @[RegUnit.scala 76:18]
  always @(posedge clock) begin
    if (reset) begin // @[RegUnit.scala 47:25]
      regGroup_0 <= 64'h0; // @[RegUnit.scala 47:25]
    end else if (io_writeEnable & io_rd != 5'h0) begin // @[RegUnit.scala 70:52]
      if (5'h0 == io_rd) begin // @[RegUnit.scala 71:21]
        regGroup_0 <= io_writeData; // @[RegUnit.scala 71:21]
      end
    end
    if (reset) begin // @[RegUnit.scala 47:25]
      regGroup_1 <= 64'h0; // @[RegUnit.scala 47:25]
    end else if (io_writeEnable & io_rd != 5'h0) begin // @[RegUnit.scala 70:52]
      if (5'h1 == io_rd) begin // @[RegUnit.scala 71:21]
        regGroup_1 <= io_writeData; // @[RegUnit.scala 71:21]
      end
    end
    if (reset) begin // @[RegUnit.scala 47:25]
      regGroup_2 <= 64'h400; // @[RegUnit.scala 47:25]
    end else if (io_writeEnable & io_rd != 5'h0) begin // @[RegUnit.scala 70:52]
      if (5'h2 == io_rd) begin // @[RegUnit.scala 71:21]
        regGroup_2 <= io_writeData; // @[RegUnit.scala 71:21]
      end
    end
    if (reset) begin // @[RegUnit.scala 47:25]
      regGroup_3 <= 64'h0; // @[RegUnit.scala 47:25]
    end else if (io_writeEnable & io_rd != 5'h0) begin // @[RegUnit.scala 70:52]
      if (5'h3 == io_rd) begin // @[RegUnit.scala 71:21]
        regGroup_3 <= io_writeData; // @[RegUnit.scala 71:21]
      end
    end
    if (reset) begin // @[RegUnit.scala 47:25]
      regGroup_4 <= 64'h0; // @[RegUnit.scala 47:25]
    end else if (io_writeEnable & io_rd != 5'h0) begin // @[RegUnit.scala 70:52]
      if (5'h4 == io_rd) begin // @[RegUnit.scala 71:21]
        regGroup_4 <= io_writeData; // @[RegUnit.scala 71:21]
      end
    end
    if (reset) begin // @[RegUnit.scala 47:25]
      regGroup_5 <= 64'h0; // @[RegUnit.scala 47:25]
    end else if (io_writeEnable & io_rd != 5'h0) begin // @[RegUnit.scala 70:52]
      if (5'h5 == io_rd) begin // @[RegUnit.scala 71:21]
        regGroup_5 <= io_writeData; // @[RegUnit.scala 71:21]
      end
    end
    if (reset) begin // @[RegUnit.scala 47:25]
      regGroup_6 <= 64'h0; // @[RegUnit.scala 47:25]
    end else if (io_writeEnable & io_rd != 5'h0) begin // @[RegUnit.scala 70:52]
      if (5'h6 == io_rd) begin // @[RegUnit.scala 71:21]
        regGroup_6 <= io_writeData; // @[RegUnit.scala 71:21]
      end
    end
    if (reset) begin // @[RegUnit.scala 47:25]
      regGroup_7 <= 64'h0; // @[RegUnit.scala 47:25]
    end else if (io_writeEnable & io_rd != 5'h0) begin // @[RegUnit.scala 70:52]
      if (5'h7 == io_rd) begin // @[RegUnit.scala 71:21]
        regGroup_7 <= io_writeData; // @[RegUnit.scala 71:21]
      end
    end
    if (reset) begin // @[RegUnit.scala 47:25]
      regGroup_8 <= 64'h0; // @[RegUnit.scala 47:25]
    end else if (io_writeEnable & io_rd != 5'h0) begin // @[RegUnit.scala 70:52]
      if (5'h8 == io_rd) begin // @[RegUnit.scala 71:21]
        regGroup_8 <= io_writeData; // @[RegUnit.scala 71:21]
      end
    end
    if (reset) begin // @[RegUnit.scala 47:25]
      regGroup_9 <= 64'h0; // @[RegUnit.scala 47:25]
    end else if (io_writeEnable & io_rd != 5'h0) begin // @[RegUnit.scala 70:52]
      if (5'h9 == io_rd) begin // @[RegUnit.scala 71:21]
        regGroup_9 <= io_writeData; // @[RegUnit.scala 71:21]
      end
    end
    if (reset) begin // @[RegUnit.scala 47:25]
      regGroup_10 <= 64'h0; // @[RegUnit.scala 47:25]
    end else if (io_writeEnable & io_rd != 5'h0) begin // @[RegUnit.scala 70:52]
      if (5'ha == io_rd) begin // @[RegUnit.scala 71:21]
        regGroup_10 <= io_writeData; // @[RegUnit.scala 71:21]
      end
    end
    if (reset) begin // @[RegUnit.scala 47:25]
      regGroup_11 <= 64'h0; // @[RegUnit.scala 47:25]
    end else if (io_writeEnable & io_rd != 5'h0) begin // @[RegUnit.scala 70:52]
      if (5'hb == io_rd) begin // @[RegUnit.scala 71:21]
        regGroup_11 <= io_writeData; // @[RegUnit.scala 71:21]
      end
    end
    if (reset) begin // @[RegUnit.scala 47:25]
      regGroup_12 <= 64'h0; // @[RegUnit.scala 47:25]
    end else if (io_writeEnable & io_rd != 5'h0) begin // @[RegUnit.scala 70:52]
      if (5'hc == io_rd) begin // @[RegUnit.scala 71:21]
        regGroup_12 <= io_writeData; // @[RegUnit.scala 71:21]
      end
    end
    if (reset) begin // @[RegUnit.scala 47:25]
      regGroup_13 <= 64'h0; // @[RegUnit.scala 47:25]
    end else if (io_writeEnable & io_rd != 5'h0) begin // @[RegUnit.scala 70:52]
      if (5'hd == io_rd) begin // @[RegUnit.scala 71:21]
        regGroup_13 <= io_writeData; // @[RegUnit.scala 71:21]
      end
    end
    if (reset) begin // @[RegUnit.scala 47:25]
      regGroup_14 <= 64'h0; // @[RegUnit.scala 47:25]
    end else if (io_writeEnable & io_rd != 5'h0) begin // @[RegUnit.scala 70:52]
      if (5'he == io_rd) begin // @[RegUnit.scala 71:21]
        regGroup_14 <= io_writeData; // @[RegUnit.scala 71:21]
      end
    end
    if (reset) begin // @[RegUnit.scala 47:25]
      regGroup_15 <= 64'h0; // @[RegUnit.scala 47:25]
    end else if (io_writeEnable & io_rd != 5'h0) begin // @[RegUnit.scala 70:52]
      if (5'hf == io_rd) begin // @[RegUnit.scala 71:21]
        regGroup_15 <= io_writeData; // @[RegUnit.scala 71:21]
      end
    end
    if (reset) begin // @[RegUnit.scala 47:25]
      regGroup_16 <= 64'h0; // @[RegUnit.scala 47:25]
    end else if (io_writeEnable & io_rd != 5'h0) begin // @[RegUnit.scala 70:52]
      if (5'h10 == io_rd) begin // @[RegUnit.scala 71:21]
        regGroup_16 <= io_writeData; // @[RegUnit.scala 71:21]
      end
    end
    if (reset) begin // @[RegUnit.scala 47:25]
      regGroup_17 <= 64'h0; // @[RegUnit.scala 47:25]
    end else if (io_writeEnable & io_rd != 5'h0) begin // @[RegUnit.scala 70:52]
      if (5'h11 == io_rd) begin // @[RegUnit.scala 71:21]
        regGroup_17 <= io_writeData; // @[RegUnit.scala 71:21]
      end
    end
    if (reset) begin // @[RegUnit.scala 47:25]
      regGroup_18 <= 64'h0; // @[RegUnit.scala 47:25]
    end else if (io_writeEnable & io_rd != 5'h0) begin // @[RegUnit.scala 70:52]
      if (5'h12 == io_rd) begin // @[RegUnit.scala 71:21]
        regGroup_18 <= io_writeData; // @[RegUnit.scala 71:21]
      end
    end
    if (reset) begin // @[RegUnit.scala 47:25]
      regGroup_19 <= 64'h0; // @[RegUnit.scala 47:25]
    end else if (io_writeEnable & io_rd != 5'h0) begin // @[RegUnit.scala 70:52]
      if (5'h13 == io_rd) begin // @[RegUnit.scala 71:21]
        regGroup_19 <= io_writeData; // @[RegUnit.scala 71:21]
      end
    end
    if (reset) begin // @[RegUnit.scala 47:25]
      regGroup_20 <= 64'h0; // @[RegUnit.scala 47:25]
    end else if (io_writeEnable & io_rd != 5'h0) begin // @[RegUnit.scala 70:52]
      if (5'h14 == io_rd) begin // @[RegUnit.scala 71:21]
        regGroup_20 <= io_writeData; // @[RegUnit.scala 71:21]
      end
    end
    if (reset) begin // @[RegUnit.scala 47:25]
      regGroup_21 <= 64'h0; // @[RegUnit.scala 47:25]
    end else if (io_writeEnable & io_rd != 5'h0) begin // @[RegUnit.scala 70:52]
      if (5'h15 == io_rd) begin // @[RegUnit.scala 71:21]
        regGroup_21 <= io_writeData; // @[RegUnit.scala 71:21]
      end
    end
    if (reset) begin // @[RegUnit.scala 47:25]
      regGroup_22 <= 64'h0; // @[RegUnit.scala 47:25]
    end else if (io_writeEnable & io_rd != 5'h0) begin // @[RegUnit.scala 70:52]
      if (5'h16 == io_rd) begin // @[RegUnit.scala 71:21]
        regGroup_22 <= io_writeData; // @[RegUnit.scala 71:21]
      end
    end
    if (reset) begin // @[RegUnit.scala 47:25]
      regGroup_23 <= 64'h0; // @[RegUnit.scala 47:25]
    end else if (io_writeEnable & io_rd != 5'h0) begin // @[RegUnit.scala 70:52]
      if (5'h17 == io_rd) begin // @[RegUnit.scala 71:21]
        regGroup_23 <= io_writeData; // @[RegUnit.scala 71:21]
      end
    end
    if (reset) begin // @[RegUnit.scala 47:25]
      regGroup_24 <= 64'h0; // @[RegUnit.scala 47:25]
    end else if (io_writeEnable & io_rd != 5'h0) begin // @[RegUnit.scala 70:52]
      if (5'h18 == io_rd) begin // @[RegUnit.scala 71:21]
        regGroup_24 <= io_writeData; // @[RegUnit.scala 71:21]
      end
    end
    if (reset) begin // @[RegUnit.scala 47:25]
      regGroup_25 <= 64'h0; // @[RegUnit.scala 47:25]
    end else if (io_writeEnable & io_rd != 5'h0) begin // @[RegUnit.scala 70:52]
      if (5'h19 == io_rd) begin // @[RegUnit.scala 71:21]
        regGroup_25 <= io_writeData; // @[RegUnit.scala 71:21]
      end
    end
    if (reset) begin // @[RegUnit.scala 47:25]
      regGroup_26 <= 64'h0; // @[RegUnit.scala 47:25]
    end else if (io_writeEnable & io_rd != 5'h0) begin // @[RegUnit.scala 70:52]
      if (5'h1a == io_rd) begin // @[RegUnit.scala 71:21]
        regGroup_26 <= io_writeData; // @[RegUnit.scala 71:21]
      end
    end
    if (reset) begin // @[RegUnit.scala 47:25]
      regGroup_27 <= 64'h0; // @[RegUnit.scala 47:25]
    end else if (io_writeEnable & io_rd != 5'h0) begin // @[RegUnit.scala 70:52]
      if (5'h1b == io_rd) begin // @[RegUnit.scala 71:21]
        regGroup_27 <= io_writeData; // @[RegUnit.scala 71:21]
      end
    end
    if (reset) begin // @[RegUnit.scala 47:25]
      regGroup_28 <= 64'h0; // @[RegUnit.scala 47:25]
    end else if (io_writeEnable & io_rd != 5'h0) begin // @[RegUnit.scala 70:52]
      if (5'h1c == io_rd) begin // @[RegUnit.scala 71:21]
        regGroup_28 <= io_writeData; // @[RegUnit.scala 71:21]
      end
    end
    if (reset) begin // @[RegUnit.scala 47:25]
      regGroup_29 <= 64'h0; // @[RegUnit.scala 47:25]
    end else if (io_writeEnable & io_rd != 5'h0) begin // @[RegUnit.scala 70:52]
      if (5'h1d == io_rd) begin // @[RegUnit.scala 71:21]
        regGroup_29 <= io_writeData; // @[RegUnit.scala 71:21]
      end
    end
    if (reset) begin // @[RegUnit.scala 47:25]
      regGroup_30 <= 64'h0; // @[RegUnit.scala 47:25]
    end else if (io_writeEnable & io_rd != 5'h0) begin // @[RegUnit.scala 70:52]
      if (5'h1e == io_rd) begin // @[RegUnit.scala 71:21]
        regGroup_30 <= io_writeData; // @[RegUnit.scala 71:21]
      end
    end
    if (reset) begin // @[RegUnit.scala 47:25]
      regGroup_31 <= 64'h0; // @[RegUnit.scala 47:25]
    end else if (io_writeEnable & io_rd != 5'h0) begin // @[RegUnit.scala 70:52]
      if (5'h1f == io_rd) begin // @[RegUnit.scala 71:21]
        regGroup_31 <= io_writeData; // @[RegUnit.scala 71:21]
      end
    end
  end
// Register and memory initialization
`ifdef RANDOMIZE_GARBAGE_ASSIGN
`define RANDOMIZE
`endif
`ifdef RANDOMIZE_INVALID_ASSIGN
`define RANDOMIZE
`endif
`ifdef RANDOMIZE_REG_INIT
`define RANDOMIZE
`endif
`ifdef RANDOMIZE_MEM_INIT
`define RANDOMIZE
`endif
`ifndef RANDOM
`define RANDOM $random
`endif
`ifdef RANDOMIZE_MEM_INIT
  integer initvar;
`endif
`ifndef SYNTHESIS
`ifdef FIRRTL_BEFORE_INITIAL
`FIRRTL_BEFORE_INITIAL
`endif
initial begin
  `ifdef RANDOMIZE
    `ifdef INIT_RANDOM
      `INIT_RANDOM
    `endif
    `ifndef VERILATOR
      `ifdef RANDOMIZE_DELAY
        #`RANDOMIZE_DELAY begin end
      `else
        #0.002 begin end
      `endif
    `endif
`ifdef RANDOMIZE_REG_INIT
  _RAND_0 = {2{`RANDOM}};
  regGroup_0 = _RAND_0[63:0];
  _RAND_1 = {2{`RANDOM}};
  regGroup_1 = _RAND_1[63:0];
  _RAND_2 = {2{`RANDOM}};
  regGroup_2 = _RAND_2[63:0];
  _RAND_3 = {2{`RANDOM}};
  regGroup_3 = _RAND_3[63:0];
  _RAND_4 = {2{`RANDOM}};
  regGroup_4 = _RAND_4[63:0];
  _RAND_5 = {2{`RANDOM}};
  regGroup_5 = _RAND_5[63:0];
  _RAND_6 = {2{`RANDOM}};
  regGroup_6 = _RAND_6[63:0];
  _RAND_7 = {2{`RANDOM}};
  regGroup_7 = _RAND_7[63:0];
  _RAND_8 = {2{`RANDOM}};
  regGroup_8 = _RAND_8[63:0];
  _RAND_9 = {2{`RANDOM}};
  regGroup_9 = _RAND_9[63:0];
  _RAND_10 = {2{`RANDOM}};
  regGroup_10 = _RAND_10[63:0];
  _RAND_11 = {2{`RANDOM}};
  regGroup_11 = _RAND_11[63:0];
  _RAND_12 = {2{`RANDOM}};
  regGroup_12 = _RAND_12[63:0];
  _RAND_13 = {2{`RANDOM}};
  regGroup_13 = _RAND_13[63:0];
  _RAND_14 = {2{`RANDOM}};
  regGroup_14 = _RAND_14[63:0];
  _RAND_15 = {2{`RANDOM}};
  regGroup_15 = _RAND_15[63:0];
  _RAND_16 = {2{`RANDOM}};
  regGroup_16 = _RAND_16[63:0];
  _RAND_17 = {2{`RANDOM}};
  regGroup_17 = _RAND_17[63:0];
  _RAND_18 = {2{`RANDOM}};
  regGroup_18 = _RAND_18[63:0];
  _RAND_19 = {2{`RANDOM}};
  regGroup_19 = _RAND_19[63:0];
  _RAND_20 = {2{`RANDOM}};
  regGroup_20 = _RAND_20[63:0];
  _RAND_21 = {2{`RANDOM}};
  regGroup_21 = _RAND_21[63:0];
  _RAND_22 = {2{`RANDOM}};
  regGroup_22 = _RAND_22[63:0];
  _RAND_23 = {2{`RANDOM}};
  regGroup_23 = _RAND_23[63:0];
  _RAND_24 = {2{`RANDOM}};
  regGroup_24 = _RAND_24[63:0];
  _RAND_25 = {2{`RANDOM}};
  regGroup_25 = _RAND_25[63:0];
  _RAND_26 = {2{`RANDOM}};
  regGroup_26 = _RAND_26[63:0];
  _RAND_27 = {2{`RANDOM}};
  regGroup_27 = _RAND_27[63:0];
  _RAND_28 = {2{`RANDOM}};
  regGroup_28 = _RAND_28[63:0];
  _RAND_29 = {2{`RANDOM}};
  regGroup_29 = _RAND_29[63:0];
  _RAND_30 = {2{`RANDOM}};
  regGroup_30 = _RAND_30[63:0];
  _RAND_31 = {2{`RANDOM}};
  regGroup_31 = _RAND_31[63:0];
`endif // RANDOMIZE_REG_INIT
  `endif // RANDOMIZE
end // initial
`ifdef FIRRTL_AFTER_INITIAL
`FIRRTL_AFTER_INITIAL
`endif
`endif // SYNTHESIS
endmodule
module ALUControlUnit(
  input        io_isBType,
  input        io_isIType,
  input        io_isRType,
  input        io_isWord,
  input  [2:0] io_funct3,
  input  [6:0] io_funct7,
  output [5:0] io_aluOperation
);
  wire [3:0] _combine_T_1 = {io_funct3,io_funct7[5]}; // @[Cat.scala 33:92]
  wire [3:0] _combine_T_2 = {io_funct3,1'h0}; // @[Cat.scala 33:92]
  wire [3:0] _GEN_0 = io_funct3 == 3'h5 ? _combine_T_1 : _combine_T_2; // @[ALUControlUnit.scala 53:34 54:15 56:15]
  wire [3:0] _GEN_1 = io_isIType ? _GEN_0 : 4'h0; // @[ALUControlUnit.scala 52:37]
  wire [3:0] _GEN_2 = io_isBType ? _combine_T_2 : _GEN_1; // @[ALUControlUnit.scala 50:37 51:13]
  wire [3:0] combine = io_isRType ? _combine_T_1 : _GEN_2; // @[ALUControlUnit.scala 48:31 49:13]
  wire [4:0] io_aluOperation_hi = {combine,io_isWord}; // @[Cat.scala 33:92]
  assign io_aluOperation = {io_aluOperation_hi,io_isBType}; // @[Cat.scala 33:92]
endmodule
module PCSelectUnit(
  input  [63:0] io_pcPlus4,
  input  [63:0] io_pcPlusImm,
  input         io_isJALR,
  input         io_isBType,
  input         io_isJump,
  input         io_isTrue,
  input  [63:0] io_aluResult,
  output [63:0] io_nextPC
);
  wire [63:0] _GEN_0 = io_isJump | io_isBType & io_isTrue ? io_pcPlusImm : io_pcPlus4; // @[PCSelectUnit.scala 47:54 48:12]
  assign io_nextPC = io_isJALR ? io_aluResult : _GEN_0; // @[PCSelectUnit.scala 45:30 46:12]
endmodule
module ALU(
  input  [5:0]  io_aluOperation,
  input  [63:0] io_x,
  input  [63:0] io_y,
  output [63:0] io_result
);
  wire [3:0] combine = io_aluOperation[5:2]; // @[ALU.scala 36:32]
  wire  isWord = io_aluOperation[1]; // @[ALU.scala 37:31]
  wire  isBType = io_aluOperation[0]; // @[ALU.scala 38:32]
  wire [31:0] x32 = io_x[31:0]; // @[ALU.scala 41:17]
  wire [31:0] y32 = io_y[31:0]; // @[ALU.scala 42:17]
  wire [5:0] shamt = io_y[5:0]; // @[ALU.scala 45:19]
  wire [4:0] shamtW = io_y[4:0]; // @[ALU.scala 46:20]
  wire [64:0] _resWire_T = io_x + io_y; // @[ALU.scala 48:34]
  wire  _T_1 = 4'h0 == combine; // @[ALU.scala 51:21]
  wire  _T_2 = 4'h2 == combine; // @[ALU.scala 51:21]
  wire  _T_3 = 4'h8 == combine; // @[ALU.scala 51:21]
  wire [63:0] _resWire_T_3 = io_x; // @[ALU.scala 62:26]
  wire [63:0] _resWire_T_4 = io_y; // @[ALU.scala 62:40]
  wire  _resWire_T_5 = $signed(io_x) < $signed(io_y); // @[ALU.scala 62:33]
  wire  _T_4 = 4'ha == combine; // @[ALU.scala 51:21]
  wire  _T_5 = 4'hc == combine; // @[ALU.scala 51:21]
  wire  _resWire_T_9 = io_x < io_y; // @[ALU.scala 70:26]
  wire  _T_6 = 4'he == combine; // @[ALU.scala 51:21]
  wire [64:0] _GEN_0 = 4'he == combine ? {{64'd0}, io_x >= io_y} : _resWire_T; // @[ALU.scala 51:21 74:17]
  wire [64:0] _GEN_1 = 4'hc == combine ? {{64'd0}, io_x < io_y} : _GEN_0; // @[ALU.scala 51:21 70:17]
  wire [64:0] _GEN_2 = 4'ha == combine ? {{64'd0}, $signed(_resWire_T_3) >= $signed(_resWire_T_4)} : _GEN_1; // @[ALU.scala 51:21 66:17]
  wire [64:0] _GEN_3 = 4'h8 == combine ? {{64'd0}, $signed(_resWire_T_3) < $signed(_resWire_T_4)} : _GEN_2; // @[ALU.scala 51:21 62:17]
  wire [64:0] _GEN_4 = 4'h2 == combine ? {{64'd0}, io_x != io_y} : _GEN_3; // @[ALU.scala 51:21 58:17]
  wire [64:0] _GEN_5 = 4'h0 == combine ? {{64'd0}, io_x == io_y} : _GEN_4; // @[ALU.scala 51:21 54:17]
  wire [31:0] _resWire_T_12 = x32 + y32; // @[ALU.scala 82:43]
  wire  resWire_sign = _resWire_T_12[31]; // @[CPUUtils.scala 117:33]
  wire [31:0] _resWire_T_14 = resWire_sign ? 32'hffffffff : 32'h0; // @[Bitwise.scala 77:12]
  wire [63:0] _resWire_T_16 = {_resWire_T_14,_resWire_T_12}; // @[Cat.scala 33:92]
  wire [63:0] _resWire_T_18 = io_x + io_y; // @[ALU.scala 84:27]
  wire [63:0] _GEN_6 = isWord ? _resWire_T_16 : _resWire_T_18; // @[ALU.scala 81:33 82:19 84:19]
  wire [31:0] _resWire_T_20 = x32 - y32; // @[ALU.scala 90:43]
  wire  resWire_sign_1 = _resWire_T_20[31]; // @[CPUUtils.scala 117:33]
  wire [31:0] _resWire_T_22 = resWire_sign_1 ? 32'hffffffff : 32'h0; // @[Bitwise.scala 77:12]
  wire [63:0] _resWire_T_24 = {_resWire_T_22,_resWire_T_20}; // @[Cat.scala 33:92]
  wire [63:0] _resWire_T_26 = io_x - io_y; // @[ALU.scala 92:27]
  wire [63:0] _GEN_7 = isWord ? _resWire_T_24 : _resWire_T_26; // @[ALU.scala 89:33 90:19 92:19]
  wire [62:0] _GEN_21 = {{31'd0}, x32}; // @[ALU.scala 98:43]
  wire [62:0] _resWire_T_27 = _GEN_21 << shamtW; // @[ALU.scala 98:43]
  wire  resWire_sign_2 = _resWire_T_27[31]; // @[CPUUtils.scala 117:33]
  wire [31:0] _resWire_T_29 = resWire_sign_2 ? 32'hffffffff : 32'h0; // @[Bitwise.scala 77:12]
  wire [63:0] _resWire_T_31 = {_resWire_T_29,_resWire_T_27[31:0]}; // @[Cat.scala 33:92]
  wire [126:0] _GEN_22 = {{63'd0}, io_x}; // @[ALU.scala 100:27]
  wire [126:0] _resWire_T_32 = _GEN_22 << shamt; // @[ALU.scala 100:27]
  wire [126:0] _GEN_8 = isWord ? {{63'd0}, _resWire_T_31} : _resWire_T_32; // @[ALU.scala 100:19 97:33 98:19]
  wire [63:0] _resWire_T_37 = io_x ^ io_y; // @[ALU.scala 113:26]
  wire [31:0] _resWire_T_38 = x32 >> shamtW; // @[ALU.scala 118:43]
  wire  resWire_sign_3 = _resWire_T_38[31]; // @[CPUUtils.scala 117:33]
  wire [31:0] _resWire_T_40 = resWire_sign_3 ? 32'hffffffff : 32'h0; // @[Bitwise.scala 77:12]
  wire [63:0] _resWire_T_42 = {_resWire_T_40,_resWire_T_38}; // @[Cat.scala 33:92]
  wire [63:0] _resWire_T_43 = io_x >> shamt; // @[ALU.scala 120:27]
  wire [63:0] _GEN_9 = isWord ? _resWire_T_42 : _resWire_T_43; // @[ALU.scala 117:33 118:19 120:19]
  wire [31:0] _resWire_T_44 = io_x[31:0]; // @[ALU.scala 127:18]
  wire [31:0] _resWire_T_46 = $signed(_resWire_T_44) >>> shamtW; // @[ALU.scala 127:36]
  wire  resWire_sign_4 = _resWire_T_46[31]; // @[CPUUtils.scala 117:33]
  wire [31:0] _resWire_T_48 = resWire_sign_4 ? 32'hffffffff : 32'h0; // @[Bitwise.scala 77:12]
  wire [63:0] _resWire_T_50 = {_resWire_T_48,_resWire_T_46}; // @[Cat.scala 33:92]
  wire [63:0] _resWire_T_53 = $signed(io_x) >>> shamt; // @[ALU.scala 130:45]
  wire [63:0] _GEN_10 = isWord ? _resWire_T_50 : _resWire_T_53; // @[ALU.scala 125:33 126:19 130:19]
  wire [63:0] _resWire_T_54 = io_x | io_y; // @[ALU.scala 135:26]
  wire [63:0] _resWire_T_55 = io_x & io_y; // @[ALU.scala 139:26]
  wire [64:0] _GEN_11 = _T_6 ? {{1'd0}, _resWire_T_55} : _resWire_T; // @[ALU.scala 139:17 78:21]
  wire [64:0] _GEN_12 = _T_5 ? {{1'd0}, _resWire_T_54} : _GEN_11; // @[ALU.scala 135:17 78:21]
  wire [64:0] _GEN_13 = 4'hb == combine ? {{1'd0}, _GEN_10} : _GEN_12; // @[ALU.scala 78:21]
  wire [64:0] _GEN_14 = _T_4 ? {{1'd0}, _GEN_9} : _GEN_13; // @[ALU.scala 78:21]
  wire [64:0] _GEN_15 = _T_3 ? {{1'd0}, _resWire_T_37} : _GEN_14; // @[ALU.scala 113:17 78:21]
  wire [64:0] _GEN_16 = 4'h6 == combine ? {{64'd0}, _resWire_T_9} : _GEN_15; // @[ALU.scala 109:17 78:21]
  wire [64:0] _GEN_17 = 4'h4 == combine ? {{64'd0}, _resWire_T_5} : _GEN_16; // @[ALU.scala 105:17 78:21]
  wire [126:0] _GEN_18 = _T_2 ? _GEN_8 : {{62'd0}, _GEN_17}; // @[ALU.scala 78:21]
  wire [126:0] _GEN_19 = 4'h1 == combine ? {{63'd0}, _GEN_7} : _GEN_18; // @[ALU.scala 78:21]
  wire [126:0] _GEN_20 = _T_1 ? {{63'd0}, _GEN_6} : _GEN_19; // @[ALU.scala 78:21]
  wire [126:0] resWire = isBType ? {{62'd0}, _GEN_5} : _GEN_20; // @[ALU.scala 50:28]
  assign io_result = resWire[63:0]; // @[ALU.scala 144:13]
endmodule
module DataMemory(
  input         clock,
  input         io_memRead,
  input         io_memWrite,
  input  [63:0] io_address,
  input  [63:0] io_writeData,
  input  [1:0]  io_bitType,
  input         io_isUnsigned,
  output [63:0] io_readData
);
`ifdef RANDOMIZE_MEM_INIT
  reg [31:0] _RAND_0;
  reg [31:0] _RAND_1;
  reg [31:0] _RAND_2;
  reg [31:0] _RAND_3;
  reg [31:0] _RAND_4;
  reg [31:0] _RAND_5;
  reg [31:0] _RAND_6;
  reg [31:0] _RAND_7;
`endif // RANDOMIZE_MEM_INIT
  reg [7:0] dataMem_0 [0:4095]; // @[DataMemory.scala 51:20]
  wire  dataMem_0_readDataRaw_MPORT_en; // @[DataMemory.scala 51:20]
  wire [11:0] dataMem_0_readDataRaw_MPORT_addr; // @[DataMemory.scala 51:20]
  wire [7:0] dataMem_0_readDataRaw_MPORT_data; // @[DataMemory.scala 51:20]
  wire [7:0] dataMem_0_MPORT_data; // @[DataMemory.scala 51:20]
  wire [11:0] dataMem_0_MPORT_addr; // @[DataMemory.scala 51:20]
  wire  dataMem_0_MPORT_mask; // @[DataMemory.scala 51:20]
  wire  dataMem_0_MPORT_en; // @[DataMemory.scala 51:20]
  reg [7:0] dataMem_1 [0:4095]; // @[DataMemory.scala 51:20]
  wire  dataMem_1_readDataRaw_MPORT_en; // @[DataMemory.scala 51:20]
  wire [11:0] dataMem_1_readDataRaw_MPORT_addr; // @[DataMemory.scala 51:20]
  wire [7:0] dataMem_1_readDataRaw_MPORT_data; // @[DataMemory.scala 51:20]
  wire [7:0] dataMem_1_MPORT_data; // @[DataMemory.scala 51:20]
  wire [11:0] dataMem_1_MPORT_addr; // @[DataMemory.scala 51:20]
  wire  dataMem_1_MPORT_mask; // @[DataMemory.scala 51:20]
  wire  dataMem_1_MPORT_en; // @[DataMemory.scala 51:20]
  reg [7:0] dataMem_2 [0:4095]; // @[DataMemory.scala 51:20]
  wire  dataMem_2_readDataRaw_MPORT_en; // @[DataMemory.scala 51:20]
  wire [11:0] dataMem_2_readDataRaw_MPORT_addr; // @[DataMemory.scala 51:20]
  wire [7:0] dataMem_2_readDataRaw_MPORT_data; // @[DataMemory.scala 51:20]
  wire [7:0] dataMem_2_MPORT_data; // @[DataMemory.scala 51:20]
  wire [11:0] dataMem_2_MPORT_addr; // @[DataMemory.scala 51:20]
  wire  dataMem_2_MPORT_mask; // @[DataMemory.scala 51:20]
  wire  dataMem_2_MPORT_en; // @[DataMemory.scala 51:20]
  reg [7:0] dataMem_3 [0:4095]; // @[DataMemory.scala 51:20]
  wire  dataMem_3_readDataRaw_MPORT_en; // @[DataMemory.scala 51:20]
  wire [11:0] dataMem_3_readDataRaw_MPORT_addr; // @[DataMemory.scala 51:20]
  wire [7:0] dataMem_3_readDataRaw_MPORT_data; // @[DataMemory.scala 51:20]
  wire [7:0] dataMem_3_MPORT_data; // @[DataMemory.scala 51:20]
  wire [11:0] dataMem_3_MPORT_addr; // @[DataMemory.scala 51:20]
  wire  dataMem_3_MPORT_mask; // @[DataMemory.scala 51:20]
  wire  dataMem_3_MPORT_en; // @[DataMemory.scala 51:20]
  reg [7:0] dataMem_4 [0:4095]; // @[DataMemory.scala 51:20]
  wire  dataMem_4_readDataRaw_MPORT_en; // @[DataMemory.scala 51:20]
  wire [11:0] dataMem_4_readDataRaw_MPORT_addr; // @[DataMemory.scala 51:20]
  wire [7:0] dataMem_4_readDataRaw_MPORT_data; // @[DataMemory.scala 51:20]
  wire [7:0] dataMem_4_MPORT_data; // @[DataMemory.scala 51:20]
  wire [11:0] dataMem_4_MPORT_addr; // @[DataMemory.scala 51:20]
  wire  dataMem_4_MPORT_mask; // @[DataMemory.scala 51:20]
  wire  dataMem_4_MPORT_en; // @[DataMemory.scala 51:20]
  reg [7:0] dataMem_5 [0:4095]; // @[DataMemory.scala 51:20]
  wire  dataMem_5_readDataRaw_MPORT_en; // @[DataMemory.scala 51:20]
  wire [11:0] dataMem_5_readDataRaw_MPORT_addr; // @[DataMemory.scala 51:20]
  wire [7:0] dataMem_5_readDataRaw_MPORT_data; // @[DataMemory.scala 51:20]
  wire [7:0] dataMem_5_MPORT_data; // @[DataMemory.scala 51:20]
  wire [11:0] dataMem_5_MPORT_addr; // @[DataMemory.scala 51:20]
  wire  dataMem_5_MPORT_mask; // @[DataMemory.scala 51:20]
  wire  dataMem_5_MPORT_en; // @[DataMemory.scala 51:20]
  reg [7:0] dataMem_6 [0:4095]; // @[DataMemory.scala 51:20]
  wire  dataMem_6_readDataRaw_MPORT_en; // @[DataMemory.scala 51:20]
  wire [11:0] dataMem_6_readDataRaw_MPORT_addr; // @[DataMemory.scala 51:20]
  wire [7:0] dataMem_6_readDataRaw_MPORT_data; // @[DataMemory.scala 51:20]
  wire [7:0] dataMem_6_MPORT_data; // @[DataMemory.scala 51:20]
  wire [11:0] dataMem_6_MPORT_addr; // @[DataMemory.scala 51:20]
  wire  dataMem_6_MPORT_mask; // @[DataMemory.scala 51:20]
  wire  dataMem_6_MPORT_en; // @[DataMemory.scala 51:20]
  reg [7:0] dataMem_7 [0:4095]; // @[DataMemory.scala 51:20]
  wire  dataMem_7_readDataRaw_MPORT_en; // @[DataMemory.scala 51:20]
  wire [11:0] dataMem_7_readDataRaw_MPORT_addr; // @[DataMemory.scala 51:20]
  wire [7:0] dataMem_7_readDataRaw_MPORT_data; // @[DataMemory.scala 51:20]
  wire [7:0] dataMem_7_MPORT_data; // @[DataMemory.scala 51:20]
  wire [11:0] dataMem_7_MPORT_addr; // @[DataMemory.scala 51:20]
  wire  dataMem_7_MPORT_mask; // @[DataMemory.scala 51:20]
  wire  dataMem_7_MPORT_en; // @[DataMemory.scala 51:20]
  wire [60:0] address = io_address[63:3]; // @[DataMemory.scala 54:28]
  wire [63:0] index = io_address & 64'h7; // @[DataMemory.scala 55:26]
  wire [63:0] readDataRaw = {dataMem_7_readDataRaw_MPORT_data,dataMem_6_readDataRaw_MPORT_data,
    dataMem_5_readDataRaw_MPORT_data,dataMem_4_readDataRaw_MPORT_data,dataMem_3_readDataRaw_MPORT_data,
    dataMem_2_readDataRaw_MPORT_data,dataMem_1_readDataRaw_MPORT_data,dataMem_0_readDataRaw_MPORT_data}; // @[DataMemory.scala 62:43]
  wire  _T = index == 64'h0; // @[DataMemory.scala 66:14]
  wire [63:0] _GEN_0 = index == 64'h0 ? readDataRaw : 64'h0; // @[DataMemory.scala 66:23 67:23]
  wire  _T_1 = index == 64'h1; // @[DataMemory.scala 70:16]
  wire [63:0] _readDataIntercept_T_2 = {8'h0,readDataRaw[63:8]}; // @[Cat.scala 33:92]
  wire [63:0] _GEN_1 = index == 64'h1 ? _readDataIntercept_T_2 : _GEN_0; // @[DataMemory.scala 70:25 71:25]
  wire  _T_2 = index == 64'h2; // @[DataMemory.scala 70:16]
  wire [63:0] _readDataIntercept_T_4 = {16'h0,readDataRaw[63:16]}; // @[Cat.scala 33:92]
  wire [63:0] _GEN_2 = index == 64'h2 ? _readDataIntercept_T_4 : _GEN_1; // @[DataMemory.scala 70:25 71:25]
  wire  _T_3 = index == 64'h3; // @[DataMemory.scala 70:16]
  wire [63:0] _readDataIntercept_T_6 = {24'h0,readDataRaw[63:24]}; // @[Cat.scala 33:92]
  wire [63:0] _GEN_3 = index == 64'h3 ? _readDataIntercept_T_6 : _GEN_2; // @[DataMemory.scala 70:25 71:25]
  wire  _T_4 = index == 64'h4; // @[DataMemory.scala 70:16]
  wire [63:0] _readDataIntercept_T_8 = {32'h0,readDataRaw[63:32]}; // @[Cat.scala 33:92]
  wire [63:0] _GEN_4 = index == 64'h4 ? _readDataIntercept_T_8 : _GEN_3; // @[DataMemory.scala 70:25 71:25]
  wire  _T_5 = index == 64'h5; // @[DataMemory.scala 70:16]
  wire [63:0] _readDataIntercept_T_10 = {40'h0,readDataRaw[63:40]}; // @[Cat.scala 33:92]
  wire [63:0] _GEN_5 = index == 64'h5 ? _readDataIntercept_T_10 : _GEN_4; // @[DataMemory.scala 70:25 71:25]
  wire  _T_6 = index == 64'h6; // @[DataMemory.scala 70:16]
  wire [63:0] _readDataIntercept_T_12 = {48'h0,readDataRaw[63:48]}; // @[Cat.scala 33:92]
  wire [63:0] _GEN_6 = index == 64'h6 ? _readDataIntercept_T_12 : _GEN_5; // @[DataMemory.scala 70:25 71:25]
  wire  _T_7 = index == 64'h7; // @[DataMemory.scala 70:16]
  wire [63:0] _readDataIntercept_T_14 = {56'h0,readDataRaw[63:56]}; // @[Cat.scala 33:92]
  wire [63:0] readDataIntercept = index == 64'h7 ? _readDataIntercept_T_14 : _GEN_6; // @[DataMemory.scala 70:25 71:25]
  wire  _T_11 = 2'h0 == io_bitType; // @[DataMemory.scala 85:28]
  wire [63:0] _readDataMasked_T_2 = {56'h0,readDataIntercept[7:0]}; // @[Cat.scala 33:92]
  wire  _T_12 = 2'h1 == io_bitType; // @[DataMemory.scala 85:28]
  wire [63:0] _readDataMasked_T_5 = {48'h0,readDataIntercept[15:0]}; // @[Cat.scala 33:92]
  wire  _T_13 = 2'h2 == io_bitType; // @[DataMemory.scala 85:28]
  wire [63:0] _readDataMasked_T_8 = {32'h0,readDataIntercept[31:0]}; // @[Cat.scala 33:92]
  wire [63:0] _GEN_8 = 2'h2 == io_bitType ? _readDataMasked_T_8 : 64'h0; // @[DataMemory.scala 85:28 91:28]
  wire [63:0] _GEN_9 = 2'h1 == io_bitType ? _readDataMasked_T_5 : _GEN_8; // @[DataMemory.scala 85:28 88:28]
  wire [63:0] _GEN_10 = 2'h0 == io_bitType ? _readDataMasked_T_2 : _GEN_9; // @[DataMemory.scala 85:28 86:40]
  wire  readDataMasked_sign = readDataIntercept[7]; // @[CPUUtils.scala 117:33]
  wire [55:0] _readDataMasked_T_10 = readDataMasked_sign ? 56'hffffffffffffff : 56'h0; // @[Bitwise.scala 77:12]
  wire [63:0] _readDataMasked_T_12 = {_readDataMasked_T_10,readDataIntercept[7:0]}; // @[Cat.scala 33:92]
  wire  readDataMasked_sign_1 = readDataIntercept[15]; // @[CPUUtils.scala 117:33]
  wire [47:0] _readDataMasked_T_14 = readDataMasked_sign_1 ? 48'hffffffffffff : 48'h0; // @[Bitwise.scala 77:12]
  wire [63:0] _readDataMasked_T_16 = {_readDataMasked_T_14,readDataIntercept[15:0]}; // @[Cat.scala 33:92]
  wire  readDataMasked_sign_2 = readDataIntercept[31]; // @[CPUUtils.scala 117:33]
  wire [31:0] _readDataMasked_T_18 = readDataMasked_sign_2 ? 32'hffffffff : 32'h0; // @[Bitwise.scala 77:12]
  wire [63:0] _readDataMasked_T_20 = {_readDataMasked_T_18,readDataIntercept[31:0]}; // @[Cat.scala 33:92]
  wire [63:0] _GEN_11 = _T_13 ? _readDataMasked_T_20 : 64'h0; // @[DataMemory.scala 95:28 98:40]
  wire [63:0] _GEN_12 = _T_12 ? _readDataMasked_T_16 : _GEN_11; // @[DataMemory.scala 95:28 97:40]
  wire [63:0] _GEN_13 = _T_11 ? _readDataMasked_T_12 : _GEN_12; // @[DataMemory.scala 95:28 96:40]
  wire [63:0] _GEN_14 = io_isUnsigned ? _GEN_10 : _GEN_13; // @[DataMemory.scala 84:38]
  wire [63:0] _GEN_15 = io_bitType == 2'h3 ? readDataIntercept : _GEN_14; // @[DataMemory.scala 81:34 82:22]
  wire  _GEN_25 = _T_13 | 2'h3 == io_bitType; // @[DataMemory.scala 141:26 123:45]
  wire  _GEN_29 = _T_13 ? 1'h0 : 2'h3 == io_bitType; // @[DataMemory.scala 141:26 124:49]
  wire  _GEN_33 = _T_12 | (_T_13 | 2'h3 == io_bitType); // @[DataMemory.scala 141:26 123:45]
  wire  _GEN_35 = _T_12 ? 1'h0 : _GEN_25; // @[DataMemory.scala 141:26 124:49]
  wire  _GEN_37 = _T_12 ? 1'h0 : _GEN_29; // @[DataMemory.scala 141:26 124:49]
  wire  _GEN_41 = _T_11 | (_T_12 | (_T_13 | 2'h3 == io_bitType)); // @[DataMemory.scala 141:26 123:45]
  wire  _GEN_42 = _T_11 ? 1'h0 : _GEN_33; // @[DataMemory.scala 141:26 124:49]
  wire  _GEN_43 = _T_11 ? 1'h0 : _GEN_35; // @[DataMemory.scala 141:26 124:49]
  wire  _GEN_45 = _T_11 ? 1'h0 : _GEN_37; // @[DataMemory.scala 141:26 124:49]
  wire [7:0] _GEN_49 = _T ? io_writeData[7:0] : 8'h0; // @[DataMemory.scala 131:29 136:22]
  wire [7:0] _GEN_50 = _T ? io_writeData[15:8] : 8'h0; // @[DataMemory.scala 131:29 136:22]
  wire [7:0] _GEN_51 = _T ? io_writeData[23:16] : 8'h0; // @[DataMemory.scala 131:29 136:22]
  wire [7:0] _GEN_52 = _T ? io_writeData[31:24] : 8'h0; // @[DataMemory.scala 131:29 136:22]
  wire [7:0] _GEN_53 = _T ? io_writeData[39:32] : 8'h0; // @[DataMemory.scala 131:29 136:22]
  wire [7:0] _GEN_54 = _T ? io_writeData[47:40] : 8'h0; // @[DataMemory.scala 131:29 136:22]
  wire [7:0] _GEN_55 = _T ? io_writeData[55:48] : 8'h0; // @[DataMemory.scala 131:29 136:22]
  wire [7:0] _GEN_56 = _T ? io_writeData[63:56] : 8'h0; // @[DataMemory.scala 131:29 136:22]
  wire  _GEN_57 = _T & _GEN_41; // @[DataMemory.scala 131:29]
  wire  _GEN_58 = _T & _GEN_42; // @[DataMemory.scala 131:29]
  wire  _GEN_59 = _T & _GEN_43; // @[DataMemory.scala 131:29]
  wire  _GEN_61 = _T & _GEN_45; // @[DataMemory.scala 131:29]
  wire  _GEN_65 = 2'h3 == io_bitType ? 1'h0 : _GEN_57; // @[DataMemory.scala 141:26 122:40]
  wire  _GEN_69 = 2'h3 == io_bitType | _GEN_61; // @[DataMemory.scala 141:26 123:45]
  wire  _GEN_73 = _T_13 ? 1'h0 : _GEN_65; // @[DataMemory.scala 141:26 122:40]
  wire  _GEN_75 = _T_13 | (2'h3 == io_bitType | _GEN_59); // @[DataMemory.scala 141:26 123:45]
  wire  _GEN_77 = _T_13 | (2'h3 == io_bitType | _GEN_61); // @[DataMemory.scala 141:26 123:45]
  wire  _GEN_78 = _T_13 ? 1'h0 : _GEN_69; // @[DataMemory.scala 141:26 124:49]
  wire  _GEN_81 = _T_12 ? 1'h0 : _GEN_73; // @[DataMemory.scala 141:26 122:40]
  wire  _GEN_83 = _T_12 | (_T_13 | (2'h3 == io_bitType | _GEN_59)); // @[DataMemory.scala 141:26 123:45]
  wire  _GEN_84 = _T_12 ? 1'h0 : _GEN_75; // @[DataMemory.scala 141:26 124:49]
  wire  _GEN_85 = _T_12 ? 1'h0 : _GEN_77; // @[DataMemory.scala 141:26 124:49]
  wire  _GEN_86 = _T_12 ? 1'h0 : _GEN_78; // @[DataMemory.scala 141:26 124:49]
  wire  _GEN_89 = _T_11 ? 1'h0 : _GEN_81; // @[DataMemory.scala 141:26 122:40]
  wire  _GEN_90 = _T_11 | (_T_12 | (_T_13 | (2'h3 == io_bitType | _GEN_58))); // @[DataMemory.scala 141:26 123:45]
  wire  _GEN_91 = _T_11 ? 1'h0 : _GEN_83; // @[DataMemory.scala 141:26 124:49]
  wire  _GEN_92 = _T_11 ? 1'h0 : _GEN_84; // @[DataMemory.scala 141:26 124:49]
  wire  _GEN_93 = _T_11 ? 1'h0 : _GEN_85; // @[DataMemory.scala 141:26 124:49]
  wire  _GEN_94 = _T_11 ? 1'h0 : _GEN_86; // @[DataMemory.scala 141:26 124:49]
  wire [7:0] _GEN_97 = _T_1 ? 8'h0 : _GEN_49; // @[DataMemory.scala 131:29 133:22]
  wire [7:0] _GEN_98 = _T_1 ? io_writeData[7:0] : _GEN_50; // @[DataMemory.scala 131:29 136:22]
  wire [7:0] _GEN_99 = _T_1 ? io_writeData[15:8] : _GEN_51; // @[DataMemory.scala 131:29 136:22]
  wire [7:0] _GEN_100 = _T_1 ? io_writeData[23:16] : _GEN_52; // @[DataMemory.scala 131:29 136:22]
  wire [7:0] _GEN_101 = _T_1 ? io_writeData[31:24] : _GEN_53; // @[DataMemory.scala 131:29 136:22]
  wire [7:0] _GEN_102 = _T_1 ? io_writeData[39:32] : _GEN_54; // @[DataMemory.scala 131:29 136:22]
  wire [7:0] _GEN_103 = _T_1 ? io_writeData[47:40] : _GEN_55; // @[DataMemory.scala 131:29 136:22]
  wire [7:0] _GEN_104 = _T_1 ? io_writeData[55:48] : _GEN_56; // @[DataMemory.scala 131:29 136:22]
  wire  _GEN_105 = _T_1 ? _GEN_89 : _T & _GEN_41; // @[DataMemory.scala 131:29]
  wire  _GEN_106 = _T_1 ? _GEN_90 : _T & _GEN_42; // @[DataMemory.scala 131:29]
  wire  _GEN_107 = _T_1 ? _GEN_91 : _T & _GEN_43; // @[DataMemory.scala 131:29]
  wire  _GEN_108 = _T_1 ? _GEN_92 : _T & _GEN_43; // @[DataMemory.scala 131:29]
  wire  _GEN_109 = _T_1 ? _GEN_93 : _T & _GEN_45; // @[DataMemory.scala 131:29]
  wire  _GEN_110 = _T_1 ? _GEN_94 : _T & _GEN_45; // @[DataMemory.scala 131:29]
  wire  _GEN_113 = 2'h3 == io_bitType ? 1'h0 : _GEN_105; // @[DataMemory.scala 141:26 122:40]
  wire  _GEN_114 = 2'h3 == io_bitType ? 1'h0 : _GEN_106; // @[DataMemory.scala 141:26 122:40]
  wire  _GEN_118 = 2'h3 == io_bitType | _GEN_110; // @[DataMemory.scala 141:26 123:45]
  wire  _GEN_121 = _T_13 ? 1'h0 : _GEN_113; // @[DataMemory.scala 141:26 122:40]
  wire  _GEN_122 = _T_13 ? 1'h0 : _GEN_114; // @[DataMemory.scala 141:26 122:40]
  wire  _GEN_125 = _T_13 | (2'h3 == io_bitType | _GEN_109); // @[DataMemory.scala 141:26 123:45]
  wire  _GEN_126 = _T_13 | (2'h3 == io_bitType | _GEN_110); // @[DataMemory.scala 141:26 123:45]
  wire  _GEN_127 = _T_13 ? 1'h0 : _GEN_118; // @[DataMemory.scala 141:26 124:49]
  wire  _GEN_129 = _T_12 ? 1'h0 : _GEN_121; // @[DataMemory.scala 141:26 122:40]
  wire  _GEN_130 = _T_12 ? 1'h0 : _GEN_122; // @[DataMemory.scala 141:26 122:40]
  wire  _GEN_132 = _T_12 | (_T_13 | (2'h3 == io_bitType | _GEN_108)); // @[DataMemory.scala 141:26 123:45]
  wire  _GEN_133 = _T_12 ? 1'h0 : _GEN_125; // @[DataMemory.scala 141:26 124:49]
  wire  _GEN_134 = _T_12 ? 1'h0 : _GEN_126; // @[DataMemory.scala 141:26 124:49]
  wire  _GEN_135 = _T_12 ? 1'h0 : _GEN_127; // @[DataMemory.scala 141:26 124:49]
  wire  _GEN_137 = _T_11 ? 1'h0 : _GEN_129; // @[DataMemory.scala 141:26 122:40]
  wire  _GEN_138 = _T_11 ? 1'h0 : _GEN_130; // @[DataMemory.scala 141:26 122:40]
  wire  _GEN_139 = _T_11 | (_T_12 | (_T_13 | (2'h3 == io_bitType | _GEN_107))); // @[DataMemory.scala 141:26 123:45]
  wire  _GEN_140 = _T_11 ? 1'h0 : _GEN_132; // @[DataMemory.scala 141:26 124:49]
  wire  _GEN_141 = _T_11 ? 1'h0 : _GEN_133; // @[DataMemory.scala 141:26 124:49]
  wire  _GEN_142 = _T_11 ? 1'h0 : _GEN_134; // @[DataMemory.scala 141:26 124:49]
  wire  _GEN_143 = _T_11 ? 1'h0 : _GEN_135; // @[DataMemory.scala 141:26 124:49]
  wire [7:0] _GEN_145 = _T_2 ? 8'h0 : _GEN_97; // @[DataMemory.scala 131:29 133:22]
  wire [7:0] _GEN_146 = _T_2 ? 8'h0 : _GEN_98; // @[DataMemory.scala 131:29 133:22]
  wire [7:0] _GEN_147 = _T_2 ? io_writeData[7:0] : _GEN_99; // @[DataMemory.scala 131:29 136:22]
  wire [7:0] _GEN_148 = _T_2 ? io_writeData[15:8] : _GEN_100; // @[DataMemory.scala 131:29 136:22]
  wire [7:0] _GEN_149 = _T_2 ? io_writeData[23:16] : _GEN_101; // @[DataMemory.scala 131:29 136:22]
  wire [7:0] _GEN_150 = _T_2 ? io_writeData[31:24] : _GEN_102; // @[DataMemory.scala 131:29 136:22]
  wire [7:0] _GEN_151 = _T_2 ? io_writeData[39:32] : _GEN_103; // @[DataMemory.scala 131:29 136:22]
  wire [7:0] _GEN_152 = _T_2 ? io_writeData[47:40] : _GEN_104; // @[DataMemory.scala 131:29 136:22]
  wire  _GEN_153 = _T_2 ? _GEN_137 : _GEN_105; // @[DataMemory.scala 131:29]
  wire  _GEN_154 = _T_2 ? _GEN_138 : _GEN_106; // @[DataMemory.scala 131:29]
  wire  _GEN_155 = _T_2 ? _GEN_139 : _GEN_107; // @[DataMemory.scala 131:29]
  wire  _GEN_156 = _T_2 ? _GEN_140 : _GEN_108; // @[DataMemory.scala 131:29]
  wire  _GEN_157 = _T_2 ? _GEN_141 : _GEN_109; // @[DataMemory.scala 131:29]
  wire  _GEN_158 = _T_2 ? _GEN_142 : _GEN_110; // @[DataMemory.scala 131:29]
  wire  _GEN_159 = _T_2 ? _GEN_143 : _GEN_110; // @[DataMemory.scala 131:29]
  wire  _GEN_161 = 2'h3 == io_bitType ? 1'h0 : _GEN_153; // @[DataMemory.scala 141:26 122:40]
  wire  _GEN_162 = 2'h3 == io_bitType ? 1'h0 : _GEN_154; // @[DataMemory.scala 141:26 122:40]
  wire  _GEN_163 = 2'h3 == io_bitType ? 1'h0 : _GEN_155; // @[DataMemory.scala 141:26 122:40]
  wire  _GEN_167 = 2'h3 == io_bitType | _GEN_159; // @[DataMemory.scala 141:26 123:45]
  wire  _GEN_169 = _T_13 ? 1'h0 : _GEN_161; // @[DataMemory.scala 141:26 122:40]
  wire  _GEN_170 = _T_13 ? 1'h0 : _GEN_162; // @[DataMemory.scala 141:26 122:40]
  wire  _GEN_171 = _T_13 ? 1'h0 : _GEN_163; // @[DataMemory.scala 141:26 122:40]
  wire  _GEN_174 = _T_13 | (2'h3 == io_bitType | _GEN_158); // @[DataMemory.scala 141:26 123:45]
  wire  _GEN_175 = _T_13 | (2'h3 == io_bitType | _GEN_159); // @[DataMemory.scala 141:26 123:45]
  wire  _GEN_176 = _T_13 ? 1'h0 : _GEN_167; // @[DataMemory.scala 141:26 124:49]
  wire  _GEN_177 = _T_12 ? 1'h0 : _GEN_169; // @[DataMemory.scala 141:26 122:40]
  wire  _GEN_178 = _T_12 ? 1'h0 : _GEN_170; // @[DataMemory.scala 141:26 122:40]
  wire  _GEN_179 = _T_12 ? 1'h0 : _GEN_171; // @[DataMemory.scala 141:26 122:40]
  wire  _GEN_181 = _T_12 | (_T_13 | (2'h3 == io_bitType | _GEN_157)); // @[DataMemory.scala 141:26 123:45]
  wire  _GEN_182 = _T_12 ? 1'h0 : _GEN_174; // @[DataMemory.scala 141:26 124:49]
  wire  _GEN_183 = _T_12 ? 1'h0 : _GEN_175; // @[DataMemory.scala 141:26 124:49]
  wire  _GEN_184 = _T_12 ? 1'h0 : _GEN_176; // @[DataMemory.scala 141:26 124:49]
  wire  _GEN_185 = _T_11 ? 1'h0 : _GEN_177; // @[DataMemory.scala 141:26 122:40]
  wire  _GEN_186 = _T_11 ? 1'h0 : _GEN_178; // @[DataMemory.scala 141:26 122:40]
  wire  _GEN_187 = _T_11 ? 1'h0 : _GEN_179; // @[DataMemory.scala 141:26 122:40]
  wire  _GEN_188 = _T_11 | (_T_12 | (_T_13 | (2'h3 == io_bitType | _GEN_156))); // @[DataMemory.scala 141:26 123:45]
  wire  _GEN_189 = _T_11 ? 1'h0 : _GEN_181; // @[DataMemory.scala 141:26 124:49]
  wire  _GEN_190 = _T_11 ? 1'h0 : _GEN_182; // @[DataMemory.scala 141:26 124:49]
  wire  _GEN_191 = _T_11 ? 1'h0 : _GEN_183; // @[DataMemory.scala 141:26 124:49]
  wire  _GEN_192 = _T_11 ? 1'h0 : _GEN_184; // @[DataMemory.scala 141:26 124:49]
  wire [7:0] _GEN_193 = _T_3 ? 8'h0 : _GEN_145; // @[DataMemory.scala 131:29 133:22]
  wire [7:0] _GEN_194 = _T_3 ? 8'h0 : _GEN_146; // @[DataMemory.scala 131:29 133:22]
  wire [7:0] _GEN_195 = _T_3 ? 8'h0 : _GEN_147; // @[DataMemory.scala 131:29 133:22]
  wire [7:0] _GEN_196 = _T_3 ? io_writeData[7:0] : _GEN_148; // @[DataMemory.scala 131:29 136:22]
  wire [7:0] _GEN_197 = _T_3 ? io_writeData[15:8] : _GEN_149; // @[DataMemory.scala 131:29 136:22]
  wire [7:0] _GEN_198 = _T_3 ? io_writeData[23:16] : _GEN_150; // @[DataMemory.scala 131:29 136:22]
  wire [7:0] _GEN_199 = _T_3 ? io_writeData[31:24] : _GEN_151; // @[DataMemory.scala 131:29 136:22]
  wire [7:0] _GEN_200 = _T_3 ? io_writeData[39:32] : _GEN_152; // @[DataMemory.scala 131:29 136:22]
  wire  _GEN_201 = _T_3 ? _GEN_185 : _GEN_153; // @[DataMemory.scala 131:29]
  wire  _GEN_202 = _T_3 ? _GEN_186 : _GEN_154; // @[DataMemory.scala 131:29]
  wire  _GEN_203 = _T_3 ? _GEN_187 : _GEN_155; // @[DataMemory.scala 131:29]
  wire  _GEN_204 = _T_3 ? _GEN_188 : _GEN_156; // @[DataMemory.scala 131:29]
  wire  _GEN_205 = _T_3 ? _GEN_189 : _GEN_157; // @[DataMemory.scala 131:29]
  wire  _GEN_206 = _T_3 ? _GEN_190 : _GEN_158; // @[DataMemory.scala 131:29]
  wire  _GEN_207 = _T_3 ? _GEN_191 : _GEN_159; // @[DataMemory.scala 131:29]
  wire  _GEN_208 = _T_3 ? _GEN_192 : _GEN_159; // @[DataMemory.scala 131:29]
  wire  _GEN_209 = 2'h3 == io_bitType ? 1'h0 : _GEN_201; // @[DataMemory.scala 141:26 122:40]
  wire  _GEN_210 = 2'h3 == io_bitType ? 1'h0 : _GEN_202; // @[DataMemory.scala 141:26 122:40]
  wire  _GEN_211 = 2'h3 == io_bitType ? 1'h0 : _GEN_203; // @[DataMemory.scala 141:26 122:40]
  wire  _GEN_212 = 2'h3 == io_bitType ? 1'h0 : _GEN_204; // @[DataMemory.scala 141:26 122:40]
  wire  _GEN_217 = _T_13 ? 1'h0 : _GEN_209; // @[DataMemory.scala 141:26 122:40]
  wire  _GEN_218 = _T_13 ? 1'h0 : _GEN_210; // @[DataMemory.scala 141:26 122:40]
  wire  _GEN_219 = _T_13 ? 1'h0 : _GEN_211; // @[DataMemory.scala 141:26 122:40]
  wire  _GEN_220 = _T_13 ? 1'h0 : _GEN_212; // @[DataMemory.scala 141:26 122:40]
  wire  _GEN_223 = _T_13 | (2'h3 == io_bitType | _GEN_207); // @[DataMemory.scala 141:26 123:45]
  wire  _GEN_224 = _T_13 | (2'h3 == io_bitType | _GEN_208); // @[DataMemory.scala 141:26 123:45]
  wire  _GEN_225 = _T_12 ? 1'h0 : _GEN_217; // @[DataMemory.scala 141:26 122:40]
  wire  _GEN_226 = _T_12 ? 1'h0 : _GEN_218; // @[DataMemory.scala 141:26 122:40]
  wire  _GEN_227 = _T_12 ? 1'h0 : _GEN_219; // @[DataMemory.scala 141:26 122:40]
  wire  _GEN_228 = _T_12 ? 1'h0 : _GEN_220; // @[DataMemory.scala 141:26 122:40]
  wire  _GEN_230 = _T_12 | (_T_13 | (2'h3 == io_bitType | _GEN_206)); // @[DataMemory.scala 141:26 123:45]
  wire  _GEN_231 = _T_12 ? 1'h0 : _GEN_223; // @[DataMemory.scala 141:26 124:49]
  wire  _GEN_232 = _T_12 ? 1'h0 : _GEN_224; // @[DataMemory.scala 141:26 124:49]
  wire  _GEN_233 = _T_11 ? 1'h0 : _GEN_225; // @[DataMemory.scala 141:26 122:40]
  wire  _GEN_234 = _T_11 ? 1'h0 : _GEN_226; // @[DataMemory.scala 141:26 122:40]
  wire  _GEN_235 = _T_11 ? 1'h0 : _GEN_227; // @[DataMemory.scala 141:26 122:40]
  wire  _GEN_236 = _T_11 ? 1'h0 : _GEN_228; // @[DataMemory.scala 141:26 122:40]
  wire  _GEN_237 = _T_11 | (_T_12 | (_T_13 | (2'h3 == io_bitType | _GEN_205))); // @[DataMemory.scala 141:26 123:45]
  wire  _GEN_238 = _T_11 ? 1'h0 : _GEN_230; // @[DataMemory.scala 141:26 124:49]
  wire  _GEN_239 = _T_11 ? 1'h0 : _GEN_231; // @[DataMemory.scala 141:26 124:49]
  wire  _GEN_240 = _T_11 ? 1'h0 : _GEN_232; // @[DataMemory.scala 141:26 124:49]
  wire [7:0] _GEN_241 = _T_4 ? 8'h0 : _GEN_193; // @[DataMemory.scala 131:29 133:22]
  wire [7:0] _GEN_242 = _T_4 ? 8'h0 : _GEN_194; // @[DataMemory.scala 131:29 133:22]
  wire [7:0] _GEN_243 = _T_4 ? 8'h0 : _GEN_195; // @[DataMemory.scala 131:29 133:22]
  wire [7:0] _GEN_244 = _T_4 ? 8'h0 : _GEN_196; // @[DataMemory.scala 131:29 133:22]
  wire [7:0] _GEN_245 = _T_4 ? io_writeData[7:0] : _GEN_197; // @[DataMemory.scala 131:29 136:22]
  wire [7:0] _GEN_246 = _T_4 ? io_writeData[15:8] : _GEN_198; // @[DataMemory.scala 131:29 136:22]
  wire [7:0] _GEN_247 = _T_4 ? io_writeData[23:16] : _GEN_199; // @[DataMemory.scala 131:29 136:22]
  wire [7:0] _GEN_248 = _T_4 ? io_writeData[31:24] : _GEN_200; // @[DataMemory.scala 131:29 136:22]
  wire  _GEN_249 = _T_4 ? _GEN_233 : _GEN_201; // @[DataMemory.scala 131:29]
  wire  _GEN_250 = _T_4 ? _GEN_234 : _GEN_202; // @[DataMemory.scala 131:29]
  wire  _GEN_251 = _T_4 ? _GEN_235 : _GEN_203; // @[DataMemory.scala 131:29]
  wire  _GEN_252 = _T_4 ? _GEN_236 : _GEN_204; // @[DataMemory.scala 131:29]
  wire  _GEN_253 = _T_4 ? _GEN_237 : _GEN_205; // @[DataMemory.scala 131:29]
  wire  _GEN_254 = _T_4 ? _GEN_238 : _GEN_206; // @[DataMemory.scala 131:29]
  wire  _GEN_255 = _T_4 ? _GEN_239 : _GEN_207; // @[DataMemory.scala 131:29]
  wire  _GEN_256 = _T_4 ? _GEN_240 : _GEN_208; // @[DataMemory.scala 131:29]
  wire  _GEN_257 = 2'h3 == io_bitType ? 1'h0 : _GEN_249; // @[DataMemory.scala 141:26 122:40]
  wire  _GEN_258 = 2'h3 == io_bitType ? 1'h0 : _GEN_250; // @[DataMemory.scala 141:26 122:40]
  wire  _GEN_259 = 2'h3 == io_bitType ? 1'h0 : _GEN_251; // @[DataMemory.scala 141:26 122:40]
  wire  _GEN_260 = 2'h3 == io_bitType ? 1'h0 : _GEN_252; // @[DataMemory.scala 141:26 122:40]
  wire  _GEN_261 = 2'h3 == io_bitType ? 1'h0 : _GEN_253; // @[DataMemory.scala 141:26 122:40]
  wire  _GEN_265 = _T_13 ? 1'h0 : _GEN_257; // @[DataMemory.scala 141:26 122:40]
  wire  _GEN_266 = _T_13 ? 1'h0 : _GEN_258; // @[DataMemory.scala 141:26 122:40]
  wire  _GEN_267 = _T_13 ? 1'h0 : _GEN_259; // @[DataMemory.scala 141:26 122:40]
  wire  _GEN_268 = _T_13 ? 1'h0 : _GEN_260; // @[DataMemory.scala 141:26 122:40]
  wire  _GEN_269 = _T_13 ? 1'h0 : _GEN_261; // @[DataMemory.scala 141:26 122:40]
  wire  _GEN_272 = _T_13 | (2'h3 == io_bitType | _GEN_256); // @[DataMemory.scala 141:26 123:45]
  wire  _GEN_273 = _T_12 ? 1'h0 : _GEN_265; // @[DataMemory.scala 141:26 122:40]
  wire  _GEN_274 = _T_12 ? 1'h0 : _GEN_266; // @[DataMemory.scala 141:26 122:40]
  wire  _GEN_275 = _T_12 ? 1'h0 : _GEN_267; // @[DataMemory.scala 141:26 122:40]
  wire  _GEN_276 = _T_12 ? 1'h0 : _GEN_268; // @[DataMemory.scala 141:26 122:40]
  wire  _GEN_277 = _T_12 ? 1'h0 : _GEN_269; // @[DataMemory.scala 141:26 122:40]
  wire  _GEN_279 = _T_12 | (_T_13 | (2'h3 == io_bitType | _GEN_255)); // @[DataMemory.scala 141:26 123:45]
  wire  _GEN_280 = _T_12 ? 1'h0 : _GEN_272; // @[DataMemory.scala 141:26 124:49]
  wire  _GEN_281 = _T_11 ? 1'h0 : _GEN_273; // @[DataMemory.scala 141:26 122:40]
  wire  _GEN_282 = _T_11 ? 1'h0 : _GEN_274; // @[DataMemory.scala 141:26 122:40]
  wire  _GEN_283 = _T_11 ? 1'h0 : _GEN_275; // @[DataMemory.scala 141:26 122:40]
  wire  _GEN_284 = _T_11 ? 1'h0 : _GEN_276; // @[DataMemory.scala 141:26 122:40]
  wire  _GEN_285 = _T_11 ? 1'h0 : _GEN_277; // @[DataMemory.scala 141:26 122:40]
  wire  _GEN_286 = _T_11 | (_T_12 | (_T_13 | (2'h3 == io_bitType | _GEN_254))); // @[DataMemory.scala 141:26 123:45]
  wire  _GEN_287 = _T_11 ? 1'h0 : _GEN_279; // @[DataMemory.scala 141:26 124:49]
  wire  _GEN_288 = _T_11 ? 1'h0 : _GEN_280; // @[DataMemory.scala 141:26 124:49]
  wire [7:0] _GEN_289 = _T_5 ? 8'h0 : _GEN_241; // @[DataMemory.scala 131:29 133:22]
  wire [7:0] _GEN_290 = _T_5 ? 8'h0 : _GEN_242; // @[DataMemory.scala 131:29 133:22]
  wire [7:0] _GEN_291 = _T_5 ? 8'h0 : _GEN_243; // @[DataMemory.scala 131:29 133:22]
  wire [7:0] _GEN_292 = _T_5 ? 8'h0 : _GEN_244; // @[DataMemory.scala 131:29 133:22]
  wire [7:0] _GEN_293 = _T_5 ? 8'h0 : _GEN_245; // @[DataMemory.scala 131:29 133:22]
  wire [7:0] _GEN_294 = _T_5 ? io_writeData[7:0] : _GEN_246; // @[DataMemory.scala 131:29 136:22]
  wire [7:0] _GEN_295 = _T_5 ? io_writeData[15:8] : _GEN_247; // @[DataMemory.scala 131:29 136:22]
  wire [7:0] _GEN_296 = _T_5 ? io_writeData[23:16] : _GEN_248; // @[DataMemory.scala 131:29 136:22]
  wire  _GEN_297 = _T_5 ? _GEN_281 : _GEN_249; // @[DataMemory.scala 131:29]
  wire  _GEN_298 = _T_5 ? _GEN_282 : _GEN_250; // @[DataMemory.scala 131:29]
  wire  _GEN_299 = _T_5 ? _GEN_283 : _GEN_251; // @[DataMemory.scala 131:29]
  wire  _GEN_300 = _T_5 ? _GEN_284 : _GEN_252; // @[DataMemory.scala 131:29]
  wire  _GEN_301 = _T_5 ? _GEN_285 : _GEN_253; // @[DataMemory.scala 131:29]
  wire  _GEN_302 = _T_5 ? _GEN_286 : _GEN_254; // @[DataMemory.scala 131:29]
  wire  _GEN_303 = _T_5 ? _GEN_287 : _GEN_255; // @[DataMemory.scala 131:29]
  wire  _GEN_304 = _T_5 ? _GEN_288 : _GEN_256; // @[DataMemory.scala 131:29]
  wire  _GEN_305 = 2'h3 == io_bitType ? 1'h0 : _GEN_297; // @[DataMemory.scala 141:26 122:40]
  wire  _GEN_306 = 2'h3 == io_bitType ? 1'h0 : _GEN_298; // @[DataMemory.scala 141:26 122:40]
  wire  _GEN_307 = 2'h3 == io_bitType ? 1'h0 : _GEN_299; // @[DataMemory.scala 141:26 122:40]
  wire  _GEN_308 = 2'h3 == io_bitType ? 1'h0 : _GEN_300; // @[DataMemory.scala 141:26 122:40]
  wire  _GEN_309 = 2'h3 == io_bitType ? 1'h0 : _GEN_301; // @[DataMemory.scala 141:26 122:40]
  wire  _GEN_310 = 2'h3 == io_bitType ? 1'h0 : _GEN_302; // @[DataMemory.scala 141:26 122:40]
  wire  _GEN_313 = _T_13 ? 1'h0 : _GEN_305; // @[DataMemory.scala 141:26 122:40]
  wire  _GEN_314 = _T_13 ? 1'h0 : _GEN_306; // @[DataMemory.scala 141:26 122:40]
  wire  _GEN_315 = _T_13 ? 1'h0 : _GEN_307; // @[DataMemory.scala 141:26 122:40]
  wire  _GEN_316 = _T_13 ? 1'h0 : _GEN_308; // @[DataMemory.scala 141:26 122:40]
  wire  _GEN_317 = _T_13 ? 1'h0 : _GEN_309; // @[DataMemory.scala 141:26 122:40]
  wire  _GEN_318 = _T_13 ? 1'h0 : _GEN_310; // @[DataMemory.scala 141:26 122:40]
  wire  _GEN_321 = _T_12 ? 1'h0 : _GEN_313; // @[DataMemory.scala 141:26 122:40]
  wire  _GEN_322 = _T_12 ? 1'h0 : _GEN_314; // @[DataMemory.scala 141:26 122:40]
  wire  _GEN_323 = _T_12 ? 1'h0 : _GEN_315; // @[DataMemory.scala 141:26 122:40]
  wire  _GEN_324 = _T_12 ? 1'h0 : _GEN_316; // @[DataMemory.scala 141:26 122:40]
  wire  _GEN_325 = _T_12 ? 1'h0 : _GEN_317; // @[DataMemory.scala 141:26 122:40]
  wire  _GEN_326 = _T_12 ? 1'h0 : _GEN_318; // @[DataMemory.scala 141:26 122:40]
  wire  _GEN_328 = _T_12 | (_T_13 | (2'h3 == io_bitType | _GEN_304)); // @[DataMemory.scala 141:26 123:45]
  wire  _GEN_329 = _T_11 ? 1'h0 : _GEN_321; // @[DataMemory.scala 141:26 122:40]
  wire  _GEN_330 = _T_11 ? 1'h0 : _GEN_322; // @[DataMemory.scala 141:26 122:40]
  wire  _GEN_331 = _T_11 ? 1'h0 : _GEN_323; // @[DataMemory.scala 141:26 122:40]
  wire  _GEN_332 = _T_11 ? 1'h0 : _GEN_324; // @[DataMemory.scala 141:26 122:40]
  wire  _GEN_333 = _T_11 ? 1'h0 : _GEN_325; // @[DataMemory.scala 141:26 122:40]
  wire  _GEN_334 = _T_11 ? 1'h0 : _GEN_326; // @[DataMemory.scala 141:26 122:40]
  wire  _GEN_335 = _T_11 | (_T_12 | (_T_13 | (2'h3 == io_bitType | _GEN_303))); // @[DataMemory.scala 141:26 123:45]
  wire  _GEN_336 = _T_11 ? 1'h0 : _GEN_328; // @[DataMemory.scala 141:26 124:49]
  wire [7:0] _GEN_337 = _T_6 ? 8'h0 : _GEN_289; // @[DataMemory.scala 131:29 133:22]
  wire [7:0] _GEN_338 = _T_6 ? 8'h0 : _GEN_290; // @[DataMemory.scala 131:29 133:22]
  wire [7:0] _GEN_339 = _T_6 ? 8'h0 : _GEN_291; // @[DataMemory.scala 131:29 133:22]
  wire [7:0] _GEN_340 = _T_6 ? 8'h0 : _GEN_292; // @[DataMemory.scala 131:29 133:22]
  wire [7:0] _GEN_341 = _T_6 ? 8'h0 : _GEN_293; // @[DataMemory.scala 131:29 133:22]
  wire [7:0] _GEN_342 = _T_6 ? 8'h0 : _GEN_294; // @[DataMemory.scala 131:29 133:22]
  wire [7:0] _GEN_343 = _T_6 ? io_writeData[7:0] : _GEN_295; // @[DataMemory.scala 131:29 136:22]
  wire [7:0] _GEN_344 = _T_6 ? io_writeData[15:8] : _GEN_296; // @[DataMemory.scala 131:29 136:22]
  wire  _GEN_345 = _T_6 ? _GEN_329 : _GEN_297; // @[DataMemory.scala 131:29]
  wire  _GEN_346 = _T_6 ? _GEN_330 : _GEN_298; // @[DataMemory.scala 131:29]
  wire  _GEN_347 = _T_6 ? _GEN_331 : _GEN_299; // @[DataMemory.scala 131:29]
  wire  _GEN_348 = _T_6 ? _GEN_332 : _GEN_300; // @[DataMemory.scala 131:29]
  wire  _GEN_349 = _T_6 ? _GEN_333 : _GEN_301; // @[DataMemory.scala 131:29]
  wire  _GEN_350 = _T_6 ? _GEN_334 : _GEN_302; // @[DataMemory.scala 131:29]
  wire  _GEN_351 = _T_6 ? _GEN_335 : _GEN_303; // @[DataMemory.scala 131:29]
  wire  _GEN_352 = _T_6 ? _GEN_336 : _GEN_304; // @[DataMemory.scala 131:29]
  wire  _GEN_353 = 2'h3 == io_bitType ? 1'h0 : _GEN_345; // @[DataMemory.scala 141:26 122:40]
  wire  _GEN_354 = 2'h3 == io_bitType ? 1'h0 : _GEN_346; // @[DataMemory.scala 141:26 122:40]
  wire  _GEN_355 = 2'h3 == io_bitType ? 1'h0 : _GEN_347; // @[DataMemory.scala 141:26 122:40]
  wire  _GEN_356 = 2'h3 == io_bitType ? 1'h0 : _GEN_348; // @[DataMemory.scala 141:26 122:40]
  wire  _GEN_357 = 2'h3 == io_bitType ? 1'h0 : _GEN_349; // @[DataMemory.scala 141:26 122:40]
  wire  _GEN_358 = 2'h3 == io_bitType ? 1'h0 : _GEN_350; // @[DataMemory.scala 141:26 122:40]
  wire  _GEN_359 = 2'h3 == io_bitType ? 1'h0 : _GEN_351; // @[DataMemory.scala 141:26 122:40]
  wire  _GEN_361 = _T_13 ? 1'h0 : _GEN_353; // @[DataMemory.scala 141:26 122:40]
  wire  _GEN_362 = _T_13 ? 1'h0 : _GEN_354; // @[DataMemory.scala 141:26 122:40]
  wire  _GEN_363 = _T_13 ? 1'h0 : _GEN_355; // @[DataMemory.scala 141:26 122:40]
  wire  _GEN_364 = _T_13 ? 1'h0 : _GEN_356; // @[DataMemory.scala 141:26 122:40]
  wire  _GEN_365 = _T_13 ? 1'h0 : _GEN_357; // @[DataMemory.scala 141:26 122:40]
  wire  _GEN_366 = _T_13 ? 1'h0 : _GEN_358; // @[DataMemory.scala 141:26 122:40]
  wire  _GEN_367 = _T_13 ? 1'h0 : _GEN_359; // @[DataMemory.scala 141:26 122:40]
  wire  _GEN_369 = _T_12 ? 1'h0 : _GEN_361; // @[DataMemory.scala 141:26 122:40]
  wire  _GEN_370 = _T_12 ? 1'h0 : _GEN_362; // @[DataMemory.scala 141:26 122:40]
  wire  _GEN_371 = _T_12 ? 1'h0 : _GEN_363; // @[DataMemory.scala 141:26 122:40]
  wire  _GEN_372 = _T_12 ? 1'h0 : _GEN_364; // @[DataMemory.scala 141:26 122:40]
  wire  _GEN_373 = _T_12 ? 1'h0 : _GEN_365; // @[DataMemory.scala 141:26 122:40]
  wire  _GEN_374 = _T_12 ? 1'h0 : _GEN_366; // @[DataMemory.scala 141:26 122:40]
  wire  _GEN_375 = _T_12 ? 1'h0 : _GEN_367; // @[DataMemory.scala 141:26 122:40]
  wire  _GEN_377 = _T_11 ? 1'h0 : _GEN_369; // @[DataMemory.scala 141:26 122:40]
  wire  _GEN_378 = _T_11 ? 1'h0 : _GEN_370; // @[DataMemory.scala 141:26 122:40]
  wire  _GEN_379 = _T_11 ? 1'h0 : _GEN_371; // @[DataMemory.scala 141:26 122:40]
  wire  _GEN_380 = _T_11 ? 1'h0 : _GEN_372; // @[DataMemory.scala 141:26 122:40]
  wire  _GEN_381 = _T_11 ? 1'h0 : _GEN_373; // @[DataMemory.scala 141:26 122:40]
  wire  _GEN_382 = _T_11 ? 1'h0 : _GEN_374; // @[DataMemory.scala 141:26 122:40]
  wire  _GEN_383 = _T_11 ? 1'h0 : _GEN_375; // @[DataMemory.scala 141:26 122:40]
  wire  _GEN_384 = _T_11 | (_T_12 | (_T_13 | (2'h3 == io_bitType | _GEN_352))); // @[DataMemory.scala 141:26 123:45]
  assign dataMem_0_readDataRaw_MPORT_en = 1'h1;
  assign dataMem_0_readDataRaw_MPORT_addr = address[11:0];
  assign dataMem_0_readDataRaw_MPORT_data = dataMem_0[dataMem_0_readDataRaw_MPORT_addr]; // @[DataMemory.scala 51:20]
  assign dataMem_0_MPORT_data = _T_7 ? 8'h0 : _GEN_337;
  assign dataMem_0_MPORT_addr = address[11:0];
  assign dataMem_0_MPORT_mask = _T_7 ? _GEN_377 : _GEN_345;
  assign dataMem_0_MPORT_en = io_memWrite;
  assign dataMem_1_readDataRaw_MPORT_en = 1'h1;
  assign dataMem_1_readDataRaw_MPORT_addr = address[11:0];
  assign dataMem_1_readDataRaw_MPORT_data = dataMem_1[dataMem_1_readDataRaw_MPORT_addr]; // @[DataMemory.scala 51:20]
  assign dataMem_1_MPORT_data = _T_7 ? 8'h0 : _GEN_338;
  assign dataMem_1_MPORT_addr = address[11:0];
  assign dataMem_1_MPORT_mask = _T_7 ? _GEN_378 : _GEN_346;
  assign dataMem_1_MPORT_en = io_memWrite;
  assign dataMem_2_readDataRaw_MPORT_en = 1'h1;
  assign dataMem_2_readDataRaw_MPORT_addr = address[11:0];
  assign dataMem_2_readDataRaw_MPORT_data = dataMem_2[dataMem_2_readDataRaw_MPORT_addr]; // @[DataMemory.scala 51:20]
  assign dataMem_2_MPORT_data = _T_7 ? 8'h0 : _GEN_339;
  assign dataMem_2_MPORT_addr = address[11:0];
  assign dataMem_2_MPORT_mask = _T_7 ? _GEN_379 : _GEN_347;
  assign dataMem_2_MPORT_en = io_memWrite;
  assign dataMem_3_readDataRaw_MPORT_en = 1'h1;
  assign dataMem_3_readDataRaw_MPORT_addr = address[11:0];
  assign dataMem_3_readDataRaw_MPORT_data = dataMem_3[dataMem_3_readDataRaw_MPORT_addr]; // @[DataMemory.scala 51:20]
  assign dataMem_3_MPORT_data = _T_7 ? 8'h0 : _GEN_340;
  assign dataMem_3_MPORT_addr = address[11:0];
  assign dataMem_3_MPORT_mask = _T_7 ? _GEN_380 : _GEN_348;
  assign dataMem_3_MPORT_en = io_memWrite;
  assign dataMem_4_readDataRaw_MPORT_en = 1'h1;
  assign dataMem_4_readDataRaw_MPORT_addr = address[11:0];
  assign dataMem_4_readDataRaw_MPORT_data = dataMem_4[dataMem_4_readDataRaw_MPORT_addr]; // @[DataMemory.scala 51:20]
  assign dataMem_4_MPORT_data = _T_7 ? 8'h0 : _GEN_341;
  assign dataMem_4_MPORT_addr = address[11:0];
  assign dataMem_4_MPORT_mask = _T_7 ? _GEN_381 : _GEN_349;
  assign dataMem_4_MPORT_en = io_memWrite;
  assign dataMem_5_readDataRaw_MPORT_en = 1'h1;
  assign dataMem_5_readDataRaw_MPORT_addr = address[11:0];
  assign dataMem_5_readDataRaw_MPORT_data = dataMem_5[dataMem_5_readDataRaw_MPORT_addr]; // @[DataMemory.scala 51:20]
  assign dataMem_5_MPORT_data = _T_7 ? 8'h0 : _GEN_342;
  assign dataMem_5_MPORT_addr = address[11:0];
  assign dataMem_5_MPORT_mask = _T_7 ? _GEN_382 : _GEN_350;
  assign dataMem_5_MPORT_en = io_memWrite;
  assign dataMem_6_readDataRaw_MPORT_en = 1'h1;
  assign dataMem_6_readDataRaw_MPORT_addr = address[11:0];
  assign dataMem_6_readDataRaw_MPORT_data = dataMem_6[dataMem_6_readDataRaw_MPORT_addr]; // @[DataMemory.scala 51:20]
  assign dataMem_6_MPORT_data = _T_7 ? 8'h0 : _GEN_343;
  assign dataMem_6_MPORT_addr = address[11:0];
  assign dataMem_6_MPORT_mask = _T_7 ? _GEN_383 : _GEN_351;
  assign dataMem_6_MPORT_en = io_memWrite;
  assign dataMem_7_readDataRaw_MPORT_en = 1'h1;
  assign dataMem_7_readDataRaw_MPORT_addr = address[11:0];
  assign dataMem_7_readDataRaw_MPORT_data = dataMem_7[dataMem_7_readDataRaw_MPORT_addr]; // @[DataMemory.scala 51:20]
  assign dataMem_7_MPORT_data = _T_7 ? io_writeData[7:0] : _GEN_344;
  assign dataMem_7_MPORT_addr = address[11:0];
  assign dataMem_7_MPORT_mask = _T_7 ? _GEN_384 : _GEN_352;
  assign dataMem_7_MPORT_en = io_memWrite;
  assign io_readData = io_memRead ? _GEN_15 : 64'h0; // @[DataMemory.scala 80:31]
  always @(posedge clock) begin
    if (dataMem_0_MPORT_en & dataMem_0_MPORT_mask) begin
      dataMem_0[dataMem_0_MPORT_addr] <= dataMem_0_MPORT_data; // @[DataMemory.scala 51:20]
    end
    if (dataMem_1_MPORT_en & dataMem_1_MPORT_mask) begin
      dataMem_1[dataMem_1_MPORT_addr] <= dataMem_1_MPORT_data; // @[DataMemory.scala 51:20]
    end
    if (dataMem_2_MPORT_en & dataMem_2_MPORT_mask) begin
      dataMem_2[dataMem_2_MPORT_addr] <= dataMem_2_MPORT_data; // @[DataMemory.scala 51:20]
    end
    if (dataMem_3_MPORT_en & dataMem_3_MPORT_mask) begin
      dataMem_3[dataMem_3_MPORT_addr] <= dataMem_3_MPORT_data; // @[DataMemory.scala 51:20]
    end
    if (dataMem_4_MPORT_en & dataMem_4_MPORT_mask) begin
      dataMem_4[dataMem_4_MPORT_addr] <= dataMem_4_MPORT_data; // @[DataMemory.scala 51:20]
    end
    if (dataMem_5_MPORT_en & dataMem_5_MPORT_mask) begin
      dataMem_5[dataMem_5_MPORT_addr] <= dataMem_5_MPORT_data; // @[DataMemory.scala 51:20]
    end
    if (dataMem_6_MPORT_en & dataMem_6_MPORT_mask) begin
      dataMem_6[dataMem_6_MPORT_addr] <= dataMem_6_MPORT_data; // @[DataMemory.scala 51:20]
    end
    if (dataMem_7_MPORT_en & dataMem_7_MPORT_mask) begin
      dataMem_7[dataMem_7_MPORT_addr] <= dataMem_7_MPORT_data; // @[DataMemory.scala 51:20]
    end
  end
// Register and memory initialization
`ifdef RANDOMIZE_GARBAGE_ASSIGN
`define RANDOMIZE
`endif
`ifdef RANDOMIZE_INVALID_ASSIGN
`define RANDOMIZE
`endif
`ifdef RANDOMIZE_REG_INIT
`define RANDOMIZE
`endif
`ifdef RANDOMIZE_MEM_INIT
`define RANDOMIZE
`endif
`ifndef RANDOM
`define RANDOM $random
`endif
`ifdef RANDOMIZE_MEM_INIT
  integer initvar;
`endif
`ifndef SYNTHESIS
`ifdef FIRRTL_BEFORE_INITIAL
`FIRRTL_BEFORE_INITIAL
`endif
initial begin
  `ifdef RANDOMIZE
    `ifdef INIT_RANDOM
      `INIT_RANDOM
    `endif
    `ifndef VERILATOR
      `ifdef RANDOMIZE_DELAY
        #`RANDOMIZE_DELAY begin end
      `else
        #0.002 begin end
      `endif
    `endif
`ifdef RANDOMIZE_MEM_INIT
  _RAND_0 = {1{`RANDOM}};
  for (initvar = 0; initvar < 4096; initvar = initvar+1)
    dataMem_0[initvar] = _RAND_0[7:0];
  _RAND_1 = {1{`RANDOM}};
  for (initvar = 0; initvar < 4096; initvar = initvar+1)
    dataMem_1[initvar] = _RAND_1[7:0];
  _RAND_2 = {1{`RANDOM}};
  for (initvar = 0; initvar < 4096; initvar = initvar+1)
    dataMem_2[initvar] = _RAND_2[7:0];
  _RAND_3 = {1{`RANDOM}};
  for (initvar = 0; initvar < 4096; initvar = initvar+1)
    dataMem_3[initvar] = _RAND_3[7:0];
  _RAND_4 = {1{`RANDOM}};
  for (initvar = 0; initvar < 4096; initvar = initvar+1)
    dataMem_4[initvar] = _RAND_4[7:0];
  _RAND_5 = {1{`RANDOM}};
  for (initvar = 0; initvar < 4096; initvar = initvar+1)
    dataMem_5[initvar] = _RAND_5[7:0];
  _RAND_6 = {1{`RANDOM}};
  for (initvar = 0; initvar < 4096; initvar = initvar+1)
    dataMem_6[initvar] = _RAND_6[7:0];
  _RAND_7 = {1{`RANDOM}};
  for (initvar = 0; initvar < 4096; initvar = initvar+1)
    dataMem_7[initvar] = _RAND_7[7:0];
`endif // RANDOMIZE_MEM_INIT
  `endif // RANDOMIZE
end // initial
`ifdef FIRRTL_AFTER_INITIAL
`FIRRTL_AFTER_INITIAL
`endif
`endif // SYNTHESIS
endmodule
module ResSelectUnit(
  input         io_isJump,
  input         io_immALUToReg,
  input         io_memRead,
  input  [63:0] io_readData,
  input  [63:0] io_aluResult,
  input  [63:0] io_imm,
  input  [63:0] io_pcPlus4,
  output [63:0] io_out
);
  wire [63:0] _GEN_0 = io_immALUToReg ? io_imm : io_aluResult; // @[ResSelectUnit.scala 47:41 48:13]
  wire [63:0] _GEN_1 = io_isJump ? io_pcPlus4 : _GEN_0; // @[ResSelectUnit.scala 45:36 46:13]
  assign io_out = io_memRead ? io_readData : _GEN_1; // @[ResSelectUnit.scala 43:31 44:13]
endmodule
module SingleCycleCPU(
  input         clock,
  input         reset,
  output        io_isValidInst,
  output [63:0] io_pc,
  output [63:0] io_nextPC,
  output [31:0] io_inst,
  output [5:0]  io_aluOperation,
  output [63:0] io_imm,
  output [63:0] io_aluResult,
  output [6:0]  io_opcode,
  output        io_isTrue,
  output        io_isJALR,
  output        io_isBType,
  output        io_isJump,
  output        io_immALUToReg,
  output        io_memRead,
  output        io_memWrite,
  output        io_immRs2ToALU,
  output [63:0] io_aluY,
  output        io_pcRs1ToALU,
  output [63:0] io_aluX,
  output        io_isIType,
  output        io_isRType,
  output        io_isWord,
  output        io_ifWriteToReg,
  output [4:0]  io_rs1,
  output [63:0] io_readDataRs1,
  output [4:0]  io_rs2,
  output [63:0] io_readDataRs2,
  output [4:0]  io_rd,
  output [63:0] io_resultToReg,
  output [1:0]  io_bitType,
  output        io_isUnsigned,
  output [63:0] io_readData,
  output [63:0] io_regAll_0,
  output [63:0] io_regAll_1,
  output [63:0] io_regAll_2,
  output [63:0] io_regAll_3,
  output [63:0] io_regAll_4,
  output [63:0] io_regAll_5,
  output [63:0] io_regAll_6,
  output [63:0] io_regAll_7,
  output [63:0] io_regAll_8,
  output [63:0] io_regAll_9,
  output [63:0] io_regAll_10,
  output [63:0] io_regAll_11,
  output [63:0] io_regAll_12,
  output [63:0] io_regAll_13,
  output [63:0] io_regAll_14,
  output [63:0] io_regAll_15,
  output [63:0] io_regAll_16,
  output [63:0] io_regAll_17,
  output [63:0] io_regAll_18,
  output [63:0] io_regAll_19,
  output [63:0] io_regAll_20,
  output [63:0] io_regAll_21,
  output [63:0] io_regAll_22,
  output [63:0] io_regAll_23,
  output [63:0] io_regAll_24,
  output [63:0] io_regAll_25,
  output [63:0] io_regAll_26,
  output [63:0] io_regAll_27,
  output [63:0] io_regAll_28,
  output [63:0] io_regAll_29,
  output [63:0] io_regAll_30,
  output [63:0] io_regAll_31
);
  wire  pcReg_clock; // @[SingleCycleCPU.scala 83:21]
  wire  pcReg_reset; // @[SingleCycleCPU.scala 83:21]
  wire [63:0] pcReg_io_in; // @[SingleCycleCPU.scala 83:21]
  wire [63:0] pcReg_io_out; // @[SingleCycleCPU.scala 83:21]
  wire [63:0] pcAdd4_io_x; // @[SingleCycleCPU.scala 84:22]
  wire [63:0] pcAdd4_io_y; // @[SingleCycleCPU.scala 84:22]
  wire [63:0] pcAdd4_io_out; // @[SingleCycleCPU.scala 84:22]
  wire [63:0] pcAddImm_io_x; // @[SingleCycleCPU.scala 85:24]
  wire [63:0] pcAddImm_io_y; // @[SingleCycleCPU.scala 85:24]
  wire [63:0] pcAddImm_io_out; // @[SingleCycleCPU.scala 85:24]
  wire  instMemory_clock; // @[SingleCycleCPU.scala 86:26]
  wire [63:0] instMemory_io_address; // @[SingleCycleCPU.scala 86:26]
  wire [31:0] instMemory_io_inst; // @[SingleCycleCPU.scala 86:26]
  wire [6:0] controlUnit_io_opcode; // @[SingleCycleCPU.scala 87:27]
  wire  controlUnit_io_isJALR; // @[SingleCycleCPU.scala 87:27]
  wire  controlUnit_io_isBType; // @[SingleCycleCPU.scala 87:27]
  wire  controlUnit_io_isJump; // @[SingleCycleCPU.scala 87:27]
  wire  controlUnit_io_immALUToReg; // @[SingleCycleCPU.scala 87:27]
  wire  controlUnit_io_memRead; // @[SingleCycleCPU.scala 87:27]
  wire  controlUnit_io_memWrite; // @[SingleCycleCPU.scala 87:27]
  wire  controlUnit_io_immRs2ToALU; // @[SingleCycleCPU.scala 87:27]
  wire  controlUnit_io_pcRs1ToALU; // @[SingleCycleCPU.scala 87:27]
  wire  controlUnit_io_isIType; // @[SingleCycleCPU.scala 87:27]
  wire  controlUnit_io_isRType; // @[SingleCycleCPU.scala 87:27]
  wire  controlUnit_io_isWord; // @[SingleCycleCPU.scala 87:27]
  wire  controlUnit_io_ifWriteToReg; // @[SingleCycleCPU.scala 87:27]
  wire  controlUnit_io_isValidInst; // @[SingleCycleCPU.scala 87:27]
  wire [31:0] inst2ImmUnit_io_inst; // @[SingleCycleCPU.scala 88:28]
  wire [63:0] inst2ImmUnit_io_imm; // @[SingleCycleCPU.scala 88:28]
  wire  regUnit_clock; // @[SingleCycleCPU.scala 89:23]
  wire  regUnit_reset; // @[SingleCycleCPU.scala 89:23]
  wire [4:0] regUnit_io_rs1; // @[SingleCycleCPU.scala 89:23]
  wire [4:0] regUnit_io_rs2; // @[SingleCycleCPU.scala 89:23]
  wire [4:0] regUnit_io_rd; // @[SingleCycleCPU.scala 89:23]
  wire  regUnit_io_writeEnable; // @[SingleCycleCPU.scala 89:23]
  wire [63:0] regUnit_io_writeData; // @[SingleCycleCPU.scala 89:23]
  wire [63:0] regUnit_io_readDataRs1; // @[SingleCycleCPU.scala 89:23]
  wire [63:0] regUnit_io_readDataRs2; // @[SingleCycleCPU.scala 89:23]
  wire [63:0] regUnit_io_regAll_1; // @[SingleCycleCPU.scala 89:23]
  wire [63:0] regUnit_io_regAll_2; // @[SingleCycleCPU.scala 89:23]
  wire [63:0] regUnit_io_regAll_3; // @[SingleCycleCPU.scala 89:23]
  wire [63:0] regUnit_io_regAll_4; // @[SingleCycleCPU.scala 89:23]
  wire [63:0] regUnit_io_regAll_5; // @[SingleCycleCPU.scala 89:23]
  wire [63:0] regUnit_io_regAll_6; // @[SingleCycleCPU.scala 89:23]
  wire [63:0] regUnit_io_regAll_7; // @[SingleCycleCPU.scala 89:23]
  wire [63:0] regUnit_io_regAll_8; // @[SingleCycleCPU.scala 89:23]
  wire [63:0] regUnit_io_regAll_9; // @[SingleCycleCPU.scala 89:23]
  wire [63:0] regUnit_io_regAll_10; // @[SingleCycleCPU.scala 89:23]
  wire [63:0] regUnit_io_regAll_11; // @[SingleCycleCPU.scala 89:23]
  wire [63:0] regUnit_io_regAll_12; // @[SingleCycleCPU.scala 89:23]
  wire [63:0] regUnit_io_regAll_13; // @[SingleCycleCPU.scala 89:23]
  wire [63:0] regUnit_io_regAll_14; // @[SingleCycleCPU.scala 89:23]
  wire [63:0] regUnit_io_regAll_15; // @[SingleCycleCPU.scala 89:23]
  wire [63:0] regUnit_io_regAll_16; // @[SingleCycleCPU.scala 89:23]
  wire [63:0] regUnit_io_regAll_17; // @[SingleCycleCPU.scala 89:23]
  wire [63:0] regUnit_io_regAll_18; // @[SingleCycleCPU.scala 89:23]
  wire [63:0] regUnit_io_regAll_19; // @[SingleCycleCPU.scala 89:23]
  wire [63:0] regUnit_io_regAll_20; // @[SingleCycleCPU.scala 89:23]
  wire [63:0] regUnit_io_regAll_21; // @[SingleCycleCPU.scala 89:23]
  wire [63:0] regUnit_io_regAll_22; // @[SingleCycleCPU.scala 89:23]
  wire [63:0] regUnit_io_regAll_23; // @[SingleCycleCPU.scala 89:23]
  wire [63:0] regUnit_io_regAll_24; // @[SingleCycleCPU.scala 89:23]
  wire [63:0] regUnit_io_regAll_25; // @[SingleCycleCPU.scala 89:23]
  wire [63:0] regUnit_io_regAll_26; // @[SingleCycleCPU.scala 89:23]
  wire [63:0] regUnit_io_regAll_27; // @[SingleCycleCPU.scala 89:23]
  wire [63:0] regUnit_io_regAll_28; // @[SingleCycleCPU.scala 89:23]
  wire [63:0] regUnit_io_regAll_29; // @[SingleCycleCPU.scala 89:23]
  wire [63:0] regUnit_io_regAll_30; // @[SingleCycleCPU.scala 89:23]
  wire [63:0] regUnit_io_regAll_31; // @[SingleCycleCPU.scala 89:23]
  wire  aluControlUnit_io_isBType; // @[SingleCycleCPU.scala 90:30]
  wire  aluControlUnit_io_isIType; // @[SingleCycleCPU.scala 90:30]
  wire  aluControlUnit_io_isRType; // @[SingleCycleCPU.scala 90:30]
  wire  aluControlUnit_io_isWord; // @[SingleCycleCPU.scala 90:30]
  wire [2:0] aluControlUnit_io_funct3; // @[SingleCycleCPU.scala 90:30]
  wire [6:0] aluControlUnit_io_funct7; // @[SingleCycleCPU.scala 90:30]
  wire [5:0] aluControlUnit_io_aluOperation; // @[SingleCycleCPU.scala 90:30]
  wire [63:0] pcSelectUnit_io_pcPlus4; // @[SingleCycleCPU.scala 91:28]
  wire [63:0] pcSelectUnit_io_pcPlusImm; // @[SingleCycleCPU.scala 91:28]
  wire  pcSelectUnit_io_isJALR; // @[SingleCycleCPU.scala 91:28]
  wire  pcSelectUnit_io_isBType; // @[SingleCycleCPU.scala 91:28]
  wire  pcSelectUnit_io_isJump; // @[SingleCycleCPU.scala 91:28]
  wire  pcSelectUnit_io_isTrue; // @[SingleCycleCPU.scala 91:28]
  wire [63:0] pcSelectUnit_io_aluResult; // @[SingleCycleCPU.scala 91:28]
  wire [63:0] pcSelectUnit_io_nextPC; // @[SingleCycleCPU.scala 91:28]
  wire [5:0] alu_io_aluOperation; // @[SingleCycleCPU.scala 92:19]
  wire [63:0] alu_io_x; // @[SingleCycleCPU.scala 92:19]
  wire [63:0] alu_io_y; // @[SingleCycleCPU.scala 92:19]
  wire [63:0] alu_io_result; // @[SingleCycleCPU.scala 92:19]
  wire  dataMemory_clock; // @[SingleCycleCPU.scala 93:26]
  wire  dataMemory_io_memRead; // @[SingleCycleCPU.scala 93:26]
  wire  dataMemory_io_memWrite; // @[SingleCycleCPU.scala 93:26]
  wire [63:0] dataMemory_io_address; // @[SingleCycleCPU.scala 93:26]
  wire [63:0] dataMemory_io_writeData; // @[SingleCycleCPU.scala 93:26]
  wire [1:0] dataMemory_io_bitType; // @[SingleCycleCPU.scala 93:26]
  wire  dataMemory_io_isUnsigned; // @[SingleCycleCPU.scala 93:26]
  wire [63:0] dataMemory_io_readData; // @[SingleCycleCPU.scala 93:26]
  wire  resSelectUnit_io_isJump; // @[SingleCycleCPU.scala 94:29]
  wire  resSelectUnit_io_immALUToReg; // @[SingleCycleCPU.scala 94:29]
  wire  resSelectUnit_io_memRead; // @[SingleCycleCPU.scala 94:29]
  wire [63:0] resSelectUnit_io_readData; // @[SingleCycleCPU.scala 94:29]
  wire [63:0] resSelectUnit_io_aluResult; // @[SingleCycleCPU.scala 94:29]
  wire [63:0] resSelectUnit_io_imm; // @[SingleCycleCPU.scala 94:29]
  wire [63:0] resSelectUnit_io_pcPlus4; // @[SingleCycleCPU.scala 94:29]
  wire [63:0] resSelectUnit_io_out; // @[SingleCycleCPU.scala 94:29]
  PCReg pcReg ( // @[SingleCycleCPU.scala 83:21]
    .clock(pcReg_clock),
    .reset(pcReg_reset),
    .io_in(pcReg_io_in),
    .io_out(pcReg_io_out)
  );
  Adder pcAdd4 ( // @[SingleCycleCPU.scala 84:22]
    .io_x(pcAdd4_io_x),
    .io_y(pcAdd4_io_y),
    .io_out(pcAdd4_io_out)
  );
  Adder pcAddImm ( // @[SingleCycleCPU.scala 85:24]
    .io_x(pcAddImm_io_x),
    .io_y(pcAddImm_io_y),
    .io_out(pcAddImm_io_out)
  );
  InstMemory instMemory ( // @[SingleCycleCPU.scala 86:26]
    .clock(instMemory_clock),
    .io_address(instMemory_io_address),
    .io_inst(instMemory_io_inst)
  );
  ControlUnit controlUnit ( // @[SingleCycleCPU.scala 87:27]
    .io_opcode(controlUnit_io_opcode),
    .io_isJALR(controlUnit_io_isJALR),
    .io_isBType(controlUnit_io_isBType),
    .io_isJump(controlUnit_io_isJump),
    .io_immALUToReg(controlUnit_io_immALUToReg),
    .io_memRead(controlUnit_io_memRead),
    .io_memWrite(controlUnit_io_memWrite),
    .io_immRs2ToALU(controlUnit_io_immRs2ToALU),
    .io_pcRs1ToALU(controlUnit_io_pcRs1ToALU),
    .io_isIType(controlUnit_io_isIType),
    .io_isRType(controlUnit_io_isRType),
    .io_isWord(controlUnit_io_isWord),
    .io_ifWriteToReg(controlUnit_io_ifWriteToReg),
    .io_isValidInst(controlUnit_io_isValidInst)
  );
  Inst2ImmUnit inst2ImmUnit ( // @[SingleCycleCPU.scala 88:28]
    .io_inst(inst2ImmUnit_io_inst),
    .io_imm(inst2ImmUnit_io_imm)
  );
  RegUnit regUnit ( // @[SingleCycleCPU.scala 89:23]
    .clock(regUnit_clock),
    .reset(regUnit_reset),
    .io_rs1(regUnit_io_rs1),
    .io_rs2(regUnit_io_rs2),
    .io_rd(regUnit_io_rd),
    .io_writeEnable(regUnit_io_writeEnable),
    .io_writeData(regUnit_io_writeData),
    .io_readDataRs1(regUnit_io_readDataRs1),
    .io_readDataRs2(regUnit_io_readDataRs2),
    .io_regAll_1(regUnit_io_regAll_1),
    .io_regAll_2(regUnit_io_regAll_2),
    .io_regAll_3(regUnit_io_regAll_3),
    .io_regAll_4(regUnit_io_regAll_4),
    .io_regAll_5(regUnit_io_regAll_5),
    .io_regAll_6(regUnit_io_regAll_6),
    .io_regAll_7(regUnit_io_regAll_7),
    .io_regAll_8(regUnit_io_regAll_8),
    .io_regAll_9(regUnit_io_regAll_9),
    .io_regAll_10(regUnit_io_regAll_10),
    .io_regAll_11(regUnit_io_regAll_11),
    .io_regAll_12(regUnit_io_regAll_12),
    .io_regAll_13(regUnit_io_regAll_13),
    .io_regAll_14(regUnit_io_regAll_14),
    .io_regAll_15(regUnit_io_regAll_15),
    .io_regAll_16(regUnit_io_regAll_16),
    .io_regAll_17(regUnit_io_regAll_17),
    .io_regAll_18(regUnit_io_regAll_18),
    .io_regAll_19(regUnit_io_regAll_19),
    .io_regAll_20(regUnit_io_regAll_20),
    .io_regAll_21(regUnit_io_regAll_21),
    .io_regAll_22(regUnit_io_regAll_22),
    .io_regAll_23(regUnit_io_regAll_23),
    .io_regAll_24(regUnit_io_regAll_24),
    .io_regAll_25(regUnit_io_regAll_25),
    .io_regAll_26(regUnit_io_regAll_26),
    .io_regAll_27(regUnit_io_regAll_27),
    .io_regAll_28(regUnit_io_regAll_28),
    .io_regAll_29(regUnit_io_regAll_29),
    .io_regAll_30(regUnit_io_regAll_30),
    .io_regAll_31(regUnit_io_regAll_31)
  );
  ALUControlUnit aluControlUnit ( // @[SingleCycleCPU.scala 90:30]
    .io_isBType(aluControlUnit_io_isBType),
    .io_isIType(aluControlUnit_io_isIType),
    .io_isRType(aluControlUnit_io_isRType),
    .io_isWord(aluControlUnit_io_isWord),
    .io_funct3(aluControlUnit_io_funct3),
    .io_funct7(aluControlUnit_io_funct7),
    .io_aluOperation(aluControlUnit_io_aluOperation)
  );
  PCSelectUnit pcSelectUnit ( // @[SingleCycleCPU.scala 91:28]
    .io_pcPlus4(pcSelectUnit_io_pcPlus4),
    .io_pcPlusImm(pcSelectUnit_io_pcPlusImm),
    .io_isJALR(pcSelectUnit_io_isJALR),
    .io_isBType(pcSelectUnit_io_isBType),
    .io_isJump(pcSelectUnit_io_isJump),
    .io_isTrue(pcSelectUnit_io_isTrue),
    .io_aluResult(pcSelectUnit_io_aluResult),
    .io_nextPC(pcSelectUnit_io_nextPC)
  );
  ALU alu ( // @[SingleCycleCPU.scala 92:19]
    .io_aluOperation(alu_io_aluOperation),
    .io_x(alu_io_x),
    .io_y(alu_io_y),
    .io_result(alu_io_result)
  );
  DataMemory dataMemory ( // @[SingleCycleCPU.scala 93:26]
    .clock(dataMemory_clock),
    .io_memRead(dataMemory_io_memRead),
    .io_memWrite(dataMemory_io_memWrite),
    .io_address(dataMemory_io_address),
    .io_writeData(dataMemory_io_writeData),
    .io_bitType(dataMemory_io_bitType),
    .io_isUnsigned(dataMemory_io_isUnsigned),
    .io_readData(dataMemory_io_readData)
  );
  ResSelectUnit resSelectUnit ( // @[SingleCycleCPU.scala 94:29]
    .io_isJump(resSelectUnit_io_isJump),
    .io_immALUToReg(resSelectUnit_io_immALUToReg),
    .io_memRead(resSelectUnit_io_memRead),
    .io_readData(resSelectUnit_io_readData),
    .io_aluResult(resSelectUnit_io_aluResult),
    .io_imm(resSelectUnit_io_imm),
    .io_pcPlus4(resSelectUnit_io_pcPlus4),
    .io_out(resSelectUnit_io_out)
  );
  assign io_isValidInst = controlUnit_io_isValidInst; // @[SingleCycleCPU.scala 98:18]
  assign io_pc = pcReg_io_out; // @[SingleCycleCPU.scala 99:9]
  assign io_nextPC = pcSelectUnit_io_nextPC; // @[SingleCycleCPU.scala 129:13]
  assign io_inst = instMemory_io_inst; // @[SingleCycleCPU.scala 100:11]
  assign io_aluOperation = alu_io_aluOperation; // @[SingleCycleCPU.scala 122:19]
  assign io_imm = inst2ImmUnit_io_imm; // @[SingleCycleCPU.scala 123:10]
  assign io_aluResult = alu_io_result; // @[SingleCycleCPU.scala 103:16]
  assign io_opcode = controlUnit_io_opcode; // @[SingleCycleCPU.scala 106:13]
  assign io_isTrue = pcSelectUnit_io_isTrue; // @[SingleCycleCPU.scala 105:13]
  assign io_isJALR = controlUnit_io_isJALR; // @[SingleCycleCPU.scala 107:13]
  assign io_isBType = controlUnit_io_isBType; // @[SingleCycleCPU.scala 108:14]
  assign io_isJump = controlUnit_io_isJump; // @[SingleCycleCPU.scala 109:13]
  assign io_immALUToReg = controlUnit_io_immALUToReg; // @[SingleCycleCPU.scala 110:18]
  assign io_memRead = controlUnit_io_memRead; // @[SingleCycleCPU.scala 111:14]
  assign io_memWrite = controlUnit_io_memWrite; // @[SingleCycleCPU.scala 112:15]
  assign io_immRs2ToALU = controlUnit_io_immRs2ToALU; // @[SingleCycleCPU.scala 113:18]
  assign io_aluY = alu_io_y; // @[SingleCycleCPU.scala 114:11]
  assign io_pcRs1ToALU = controlUnit_io_pcRs1ToALU; // @[SingleCycleCPU.scala 115:17]
  assign io_aluX = alu_io_x; // @[SingleCycleCPU.scala 116:11]
  assign io_isIType = controlUnit_io_isIType; // @[SingleCycleCPU.scala 117:14]
  assign io_isRType = controlUnit_io_isRType; // @[SingleCycleCPU.scala 118:14]
  assign io_isWord = controlUnit_io_isWord; // @[SingleCycleCPU.scala 119:13]
  assign io_ifWriteToReg = controlUnit_io_ifWriteToReg; // @[SingleCycleCPU.scala 120:19]
  assign io_rs1 = regUnit_io_rs1; // @[SingleCycleCPU.scala 124:10]
  assign io_readDataRs1 = regUnit_io_readDataRs1; // @[SingleCycleCPU.scala 125:18]
  assign io_rs2 = regUnit_io_rs2; // @[SingleCycleCPU.scala 126:10]
  assign io_readDataRs2 = regUnit_io_readDataRs2; // @[SingleCycleCPU.scala 127:18]
  assign io_rd = regUnit_io_rd; // @[SingleCycleCPU.scala 128:9]
  assign io_resultToReg = resSelectUnit_io_out; // @[SingleCycleCPU.scala 101:18]
  assign io_bitType = dataMemory_io_bitType; // @[SingleCycleCPU.scala 131:14]
  assign io_isUnsigned = dataMemory_io_isUnsigned; // @[SingleCycleCPU.scala 132:17]
  assign io_readData = dataMemory_io_readData; // @[SingleCycleCPU.scala 102:15]
  assign io_regAll_0 = 64'h0; // @[SingleCycleCPU.scala 135:18]
  assign io_regAll_1 = regUnit_io_regAll_1; // @[SingleCycleCPU.scala 135:18]
  assign io_regAll_2 = regUnit_io_regAll_2; // @[SingleCycleCPU.scala 135:18]
  assign io_regAll_3 = regUnit_io_regAll_3; // @[SingleCycleCPU.scala 135:18]
  assign io_regAll_4 = regUnit_io_regAll_4; // @[SingleCycleCPU.scala 135:18]
  assign io_regAll_5 = regUnit_io_regAll_5; // @[SingleCycleCPU.scala 135:18]
  assign io_regAll_6 = regUnit_io_regAll_6; // @[SingleCycleCPU.scala 135:18]
  assign io_regAll_7 = regUnit_io_regAll_7; // @[SingleCycleCPU.scala 135:18]
  assign io_regAll_8 = regUnit_io_regAll_8; // @[SingleCycleCPU.scala 135:18]
  assign io_regAll_9 = regUnit_io_regAll_9; // @[SingleCycleCPU.scala 135:18]
  assign io_regAll_10 = regUnit_io_regAll_10; // @[SingleCycleCPU.scala 135:18]
  assign io_regAll_11 = regUnit_io_regAll_11; // @[SingleCycleCPU.scala 135:18]
  assign io_regAll_12 = regUnit_io_regAll_12; // @[SingleCycleCPU.scala 135:18]
  assign io_regAll_13 = regUnit_io_regAll_13; // @[SingleCycleCPU.scala 135:18]
  assign io_regAll_14 = regUnit_io_regAll_14; // @[SingleCycleCPU.scala 135:18]
  assign io_regAll_15 = regUnit_io_regAll_15; // @[SingleCycleCPU.scala 135:18]
  assign io_regAll_16 = regUnit_io_regAll_16; // @[SingleCycleCPU.scala 135:18]
  assign io_regAll_17 = regUnit_io_regAll_17; // @[SingleCycleCPU.scala 135:18]
  assign io_regAll_18 = regUnit_io_regAll_18; // @[SingleCycleCPU.scala 135:18]
  assign io_regAll_19 = regUnit_io_regAll_19; // @[SingleCycleCPU.scala 135:18]
  assign io_regAll_20 = regUnit_io_regAll_20; // @[SingleCycleCPU.scala 135:18]
  assign io_regAll_21 = regUnit_io_regAll_21; // @[SingleCycleCPU.scala 135:18]
  assign io_regAll_22 = regUnit_io_regAll_22; // @[SingleCycleCPU.scala 135:18]
  assign io_regAll_23 = regUnit_io_regAll_23; // @[SingleCycleCPU.scala 135:18]
  assign io_regAll_24 = regUnit_io_regAll_24; // @[SingleCycleCPU.scala 135:18]
  assign io_regAll_25 = regUnit_io_regAll_25; // @[SingleCycleCPU.scala 135:18]
  assign io_regAll_26 = regUnit_io_regAll_26; // @[SingleCycleCPU.scala 135:18]
  assign io_regAll_27 = regUnit_io_regAll_27; // @[SingleCycleCPU.scala 135:18]
  assign io_regAll_28 = regUnit_io_regAll_28; // @[SingleCycleCPU.scala 135:18]
  assign io_regAll_29 = regUnit_io_regAll_29; // @[SingleCycleCPU.scala 135:18]
  assign io_regAll_30 = regUnit_io_regAll_30; // @[SingleCycleCPU.scala 135:18]
  assign io_regAll_31 = regUnit_io_regAll_31; // @[SingleCycleCPU.scala 135:18]
  assign pcReg_clock = clock;
  assign pcReg_reset = reset;
  assign pcReg_io_in = pcSelectUnit_io_nextPC; // @[SingleCycleCPU.scala 140:15]
  assign pcAdd4_io_x = 64'h4; // @[SingleCycleCPU.scala 142:15]
  assign pcAdd4_io_y = pcReg_io_out; // @[SingleCycleCPU.scala 143:15]
  assign pcAddImm_io_x = pcReg_io_out; // @[SingleCycleCPU.scala 145:17]
  assign pcAddImm_io_y = inst2ImmUnit_io_imm; // @[SingleCycleCPU.scala 146:17]
  assign instMemory_clock = clock;
  assign instMemory_io_address = pcReg_io_out; // @[SingleCycleCPU.scala 148:25]
  assign controlUnit_io_opcode = instMemory_io_inst[6:0]; // @[SingleCycleCPU.scala 150:46]
  assign inst2ImmUnit_io_inst = instMemory_io_inst; // @[SingleCycleCPU.scala 152:24]
  assign regUnit_clock = clock;
  assign regUnit_reset = reset;
  assign regUnit_io_rs1 = instMemory_io_inst[19:15]; // @[SingleCycleCPU.scala 154:39]
  assign regUnit_io_rs2 = instMemory_io_inst[24:20]; // @[SingleCycleCPU.scala 155:39]
  assign regUnit_io_rd = instMemory_io_inst[11:7]; // @[SingleCycleCPU.scala 156:38]
  assign regUnit_io_writeEnable = controlUnit_io_ifWriteToReg; // @[SingleCycleCPU.scala 157:26]
  assign regUnit_io_writeData = resSelectUnit_io_out; // @[SingleCycleCPU.scala 158:24]
  assign aluControlUnit_io_isBType = controlUnit_io_isBType; // @[SingleCycleCPU.scala 168:29]
  assign aluControlUnit_io_isIType = controlUnit_io_isIType; // @[SingleCycleCPU.scala 169:29]
  assign aluControlUnit_io_isRType = controlUnit_io_isRType; // @[SingleCycleCPU.scala 170:29]
  assign aluControlUnit_io_isWord = controlUnit_io_isWord; // @[SingleCycleCPU.scala 171:28]
  assign aluControlUnit_io_funct3 = instMemory_io_inst[14:12]; // @[SingleCycleCPU.scala 172:49]
  assign aluControlUnit_io_funct7 = instMemory_io_inst[31:25]; // @[SingleCycleCPU.scala 173:49]
  assign pcSelectUnit_io_pcPlus4 = pcAdd4_io_out; // @[SingleCycleCPU.scala 160:27]
  assign pcSelectUnit_io_pcPlusImm = pcAddImm_io_out; // @[SingleCycleCPU.scala 161:29]
  assign pcSelectUnit_io_isJALR = controlUnit_io_isJALR; // @[SingleCycleCPU.scala 164:26]
  assign pcSelectUnit_io_isBType = controlUnit_io_isBType; // @[SingleCycleCPU.scala 163:27]
  assign pcSelectUnit_io_isJump = controlUnit_io_isJump; // @[SingleCycleCPU.scala 162:26]
  assign pcSelectUnit_io_isTrue = alu_io_result[0]; // @[SingleCycleCPU.scala 165:42]
  assign pcSelectUnit_io_aluResult = alu_io_result; // @[SingleCycleCPU.scala 166:29]
  assign alu_io_aluOperation = aluControlUnit_io_aluOperation; // @[SingleCycleCPU.scala 175:23]
  assign alu_io_x = controlUnit_io_pcRs1ToALU ? pcReg_io_out : regUnit_io_readDataRs1; // @[SingleCycleCPU.scala 176:18]
  assign alu_io_y = controlUnit_io_immRs2ToALU ? inst2ImmUnit_io_imm : regUnit_io_readDataRs2; // @[SingleCycleCPU.scala 181:18]
  assign dataMemory_clock = clock;
  assign dataMemory_io_memRead = controlUnit_io_memRead; // @[SingleCycleCPU.scala 187:25]
  assign dataMemory_io_memWrite = controlUnit_io_memWrite; // @[SingleCycleCPU.scala 188:26]
  assign dataMemory_io_address = alu_io_result; // @[SingleCycleCPU.scala 189:25]
  assign dataMemory_io_writeData = regUnit_io_readDataRs2; // @[SingleCycleCPU.scala 190:27]
  assign dataMemory_io_bitType = instMemory_io_inst[13:12]; // @[SingleCycleCPU.scala 191:46]
  assign dataMemory_io_isUnsigned = instMemory_io_inst[14]; // @[SingleCycleCPU.scala 192:49]
  assign resSelectUnit_io_isJump = controlUnit_io_isJump; // @[SingleCycleCPU.scala 195:27]
  assign resSelectUnit_io_immALUToReg = controlUnit_io_immALUToReg; // @[SingleCycleCPU.scala 196:32]
  assign resSelectUnit_io_memRead = controlUnit_io_memRead; // @[SingleCycleCPU.scala 194:28]
  assign resSelectUnit_io_readData = dataMemory_io_readData; // @[SingleCycleCPU.scala 197:29]
  assign resSelectUnit_io_aluResult = alu_io_result; // @[SingleCycleCPU.scala 198:30]
  assign resSelectUnit_io_imm = inst2ImmUnit_io_imm; // @[SingleCycleCPU.scala 199:24]
  assign resSelectUnit_io_pcPlus4 = pcAdd4_io_out; // @[SingleCycleCPU.scala 200:28]
endmodule
