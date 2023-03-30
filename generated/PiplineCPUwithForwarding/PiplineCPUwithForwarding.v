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
module RegUnitWithForwarding(
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
  reg [63:0] regGroup_0; // @[RegUnit.scala 74:25]
  reg [63:0] regGroup_1; // @[RegUnit.scala 74:25]
  reg [63:0] regGroup_2; // @[RegUnit.scala 74:25]
  reg [63:0] regGroup_3; // @[RegUnit.scala 74:25]
  reg [63:0] regGroup_4; // @[RegUnit.scala 74:25]
  reg [63:0] regGroup_5; // @[RegUnit.scala 74:25]
  reg [63:0] regGroup_6; // @[RegUnit.scala 74:25]
  reg [63:0] regGroup_7; // @[RegUnit.scala 74:25]
  reg [63:0] regGroup_8; // @[RegUnit.scala 74:25]
  reg [63:0] regGroup_9; // @[RegUnit.scala 74:25]
  reg [63:0] regGroup_10; // @[RegUnit.scala 74:25]
  reg [63:0] regGroup_11; // @[RegUnit.scala 74:25]
  reg [63:0] regGroup_12; // @[RegUnit.scala 74:25]
  reg [63:0] regGroup_13; // @[RegUnit.scala 74:25]
  reg [63:0] regGroup_14; // @[RegUnit.scala 74:25]
  reg [63:0] regGroup_15; // @[RegUnit.scala 74:25]
  reg [63:0] regGroup_16; // @[RegUnit.scala 74:25]
  reg [63:0] regGroup_17; // @[RegUnit.scala 74:25]
  reg [63:0] regGroup_18; // @[RegUnit.scala 74:25]
  reg [63:0] regGroup_19; // @[RegUnit.scala 74:25]
  reg [63:0] regGroup_20; // @[RegUnit.scala 74:25]
  reg [63:0] regGroup_21; // @[RegUnit.scala 74:25]
  reg [63:0] regGroup_22; // @[RegUnit.scala 74:25]
  reg [63:0] regGroup_23; // @[RegUnit.scala 74:25]
  reg [63:0] regGroup_24; // @[RegUnit.scala 74:25]
  reg [63:0] regGroup_25; // @[RegUnit.scala 74:25]
  reg [63:0] regGroup_26; // @[RegUnit.scala 74:25]
  reg [63:0] regGroup_27; // @[RegUnit.scala 74:25]
  reg [63:0] regGroup_28; // @[RegUnit.scala 74:25]
  reg [63:0] regGroup_29; // @[RegUnit.scala 74:25]
  reg [63:0] regGroup_30; // @[RegUnit.scala 74:25]
  reg [63:0] regGroup_31; // @[RegUnit.scala 74:25]
  wire  _readDataRs1_T_1 = io_writeEnable & io_rs1 == io_rd; // @[RegUnit.scala 23:21]
  wire [63:0] _GEN_65 = 5'h1 == io_rs1 ? regGroup_1 : regGroup_0; // @[RegUnit.scala 22:{21,21}]
  wire [63:0] _GEN_66 = 5'h2 == io_rs1 ? regGroup_2 : _GEN_65; // @[RegUnit.scala 22:{21,21}]
  wire [63:0] _GEN_67 = 5'h3 == io_rs1 ? regGroup_3 : _GEN_66; // @[RegUnit.scala 22:{21,21}]
  wire [63:0] _GEN_68 = 5'h4 == io_rs1 ? regGroup_4 : _GEN_67; // @[RegUnit.scala 22:{21,21}]
  wire [63:0] _GEN_69 = 5'h5 == io_rs1 ? regGroup_5 : _GEN_68; // @[RegUnit.scala 22:{21,21}]
  wire [63:0] _GEN_70 = 5'h6 == io_rs1 ? regGroup_6 : _GEN_69; // @[RegUnit.scala 22:{21,21}]
  wire [63:0] _GEN_71 = 5'h7 == io_rs1 ? regGroup_7 : _GEN_70; // @[RegUnit.scala 22:{21,21}]
  wire [63:0] _GEN_72 = 5'h8 == io_rs1 ? regGroup_8 : _GEN_71; // @[RegUnit.scala 22:{21,21}]
  wire [63:0] _GEN_73 = 5'h9 == io_rs1 ? regGroup_9 : _GEN_72; // @[RegUnit.scala 22:{21,21}]
  wire [63:0] _GEN_74 = 5'ha == io_rs1 ? regGroup_10 : _GEN_73; // @[RegUnit.scala 22:{21,21}]
  wire [63:0] _GEN_75 = 5'hb == io_rs1 ? regGroup_11 : _GEN_74; // @[RegUnit.scala 22:{21,21}]
  wire [63:0] _GEN_76 = 5'hc == io_rs1 ? regGroup_12 : _GEN_75; // @[RegUnit.scala 22:{21,21}]
  wire [63:0] _GEN_77 = 5'hd == io_rs1 ? regGroup_13 : _GEN_76; // @[RegUnit.scala 22:{21,21}]
  wire [63:0] _GEN_78 = 5'he == io_rs1 ? regGroup_14 : _GEN_77; // @[RegUnit.scala 22:{21,21}]
  wire [63:0] _GEN_79 = 5'hf == io_rs1 ? regGroup_15 : _GEN_78; // @[RegUnit.scala 22:{21,21}]
  wire [63:0] _GEN_80 = 5'h10 == io_rs1 ? regGroup_16 : _GEN_79; // @[RegUnit.scala 22:{21,21}]
  wire [63:0] _GEN_81 = 5'h11 == io_rs1 ? regGroup_17 : _GEN_80; // @[RegUnit.scala 22:{21,21}]
  wire [63:0] _GEN_82 = 5'h12 == io_rs1 ? regGroup_18 : _GEN_81; // @[RegUnit.scala 22:{21,21}]
  wire [63:0] _GEN_83 = 5'h13 == io_rs1 ? regGroup_19 : _GEN_82; // @[RegUnit.scala 22:{21,21}]
  wire [63:0] _GEN_84 = 5'h14 == io_rs1 ? regGroup_20 : _GEN_83; // @[RegUnit.scala 22:{21,21}]
  wire [63:0] _GEN_85 = 5'h15 == io_rs1 ? regGroup_21 : _GEN_84; // @[RegUnit.scala 22:{21,21}]
  wire [63:0] _GEN_86 = 5'h16 == io_rs1 ? regGroup_22 : _GEN_85; // @[RegUnit.scala 22:{21,21}]
  wire [63:0] _GEN_87 = 5'h17 == io_rs1 ? regGroup_23 : _GEN_86; // @[RegUnit.scala 22:{21,21}]
  wire [63:0] _GEN_88 = 5'h18 == io_rs1 ? regGroup_24 : _GEN_87; // @[RegUnit.scala 22:{21,21}]
  wire [63:0] _GEN_89 = 5'h19 == io_rs1 ? regGroup_25 : _GEN_88; // @[RegUnit.scala 22:{21,21}]
  wire [63:0] _GEN_90 = 5'h1a == io_rs1 ? regGroup_26 : _GEN_89; // @[RegUnit.scala 22:{21,21}]
  wire [63:0] _GEN_91 = 5'h1b == io_rs1 ? regGroup_27 : _GEN_90; // @[RegUnit.scala 22:{21,21}]
  wire [63:0] _GEN_92 = 5'h1c == io_rs1 ? regGroup_28 : _GEN_91; // @[RegUnit.scala 22:{21,21}]
  wire [63:0] _GEN_93 = 5'h1d == io_rs1 ? regGroup_29 : _GEN_92; // @[RegUnit.scala 22:{21,21}]
  wire [63:0] _GEN_94 = 5'h1e == io_rs1 ? regGroup_30 : _GEN_93; // @[RegUnit.scala 22:{21,21}]
  wire [63:0] _GEN_95 = 5'h1f == io_rs1 ? regGroup_31 : _GEN_94; // @[RegUnit.scala 22:{21,21}]
  wire [63:0] readDataRs1 = _readDataRs1_T_1 ? io_writeData : _GEN_95; // @[RegUnit.scala 22:21]
  wire  _readDataRs2_T_1 = io_writeEnable & io_rs2 == io_rd; // @[RegUnit.scala 29:21]
  wire [63:0] _GEN_97 = 5'h1 == io_rs2 ? regGroup_1 : regGroup_0; // @[RegUnit.scala 28:{21,21}]
  wire [63:0] _GEN_98 = 5'h2 == io_rs2 ? regGroup_2 : _GEN_97; // @[RegUnit.scala 28:{21,21}]
  wire [63:0] _GEN_99 = 5'h3 == io_rs2 ? regGroup_3 : _GEN_98; // @[RegUnit.scala 28:{21,21}]
  wire [63:0] _GEN_100 = 5'h4 == io_rs2 ? regGroup_4 : _GEN_99; // @[RegUnit.scala 28:{21,21}]
  wire [63:0] _GEN_101 = 5'h5 == io_rs2 ? regGroup_5 : _GEN_100; // @[RegUnit.scala 28:{21,21}]
  wire [63:0] _GEN_102 = 5'h6 == io_rs2 ? regGroup_6 : _GEN_101; // @[RegUnit.scala 28:{21,21}]
  wire [63:0] _GEN_103 = 5'h7 == io_rs2 ? regGroup_7 : _GEN_102; // @[RegUnit.scala 28:{21,21}]
  wire [63:0] _GEN_104 = 5'h8 == io_rs2 ? regGroup_8 : _GEN_103; // @[RegUnit.scala 28:{21,21}]
  wire [63:0] _GEN_105 = 5'h9 == io_rs2 ? regGroup_9 : _GEN_104; // @[RegUnit.scala 28:{21,21}]
  wire [63:0] _GEN_106 = 5'ha == io_rs2 ? regGroup_10 : _GEN_105; // @[RegUnit.scala 28:{21,21}]
  wire [63:0] _GEN_107 = 5'hb == io_rs2 ? regGroup_11 : _GEN_106; // @[RegUnit.scala 28:{21,21}]
  wire [63:0] _GEN_108 = 5'hc == io_rs2 ? regGroup_12 : _GEN_107; // @[RegUnit.scala 28:{21,21}]
  wire [63:0] _GEN_109 = 5'hd == io_rs2 ? regGroup_13 : _GEN_108; // @[RegUnit.scala 28:{21,21}]
  wire [63:0] _GEN_110 = 5'he == io_rs2 ? regGroup_14 : _GEN_109; // @[RegUnit.scala 28:{21,21}]
  wire [63:0] _GEN_111 = 5'hf == io_rs2 ? regGroup_15 : _GEN_110; // @[RegUnit.scala 28:{21,21}]
  wire [63:0] _GEN_112 = 5'h10 == io_rs2 ? regGroup_16 : _GEN_111; // @[RegUnit.scala 28:{21,21}]
  wire [63:0] _GEN_113 = 5'h11 == io_rs2 ? regGroup_17 : _GEN_112; // @[RegUnit.scala 28:{21,21}]
  wire [63:0] _GEN_114 = 5'h12 == io_rs2 ? regGroup_18 : _GEN_113; // @[RegUnit.scala 28:{21,21}]
  wire [63:0] _GEN_115 = 5'h13 == io_rs2 ? regGroup_19 : _GEN_114; // @[RegUnit.scala 28:{21,21}]
  wire [63:0] _GEN_116 = 5'h14 == io_rs2 ? regGroup_20 : _GEN_115; // @[RegUnit.scala 28:{21,21}]
  wire [63:0] _GEN_117 = 5'h15 == io_rs2 ? regGroup_21 : _GEN_116; // @[RegUnit.scala 28:{21,21}]
  wire [63:0] _GEN_118 = 5'h16 == io_rs2 ? regGroup_22 : _GEN_117; // @[RegUnit.scala 28:{21,21}]
  wire [63:0] _GEN_119 = 5'h17 == io_rs2 ? regGroup_23 : _GEN_118; // @[RegUnit.scala 28:{21,21}]
  wire [63:0] _GEN_120 = 5'h18 == io_rs2 ? regGroup_24 : _GEN_119; // @[RegUnit.scala 28:{21,21}]
  wire [63:0] _GEN_121 = 5'h19 == io_rs2 ? regGroup_25 : _GEN_120; // @[RegUnit.scala 28:{21,21}]
  wire [63:0] _GEN_122 = 5'h1a == io_rs2 ? regGroup_26 : _GEN_121; // @[RegUnit.scala 28:{21,21}]
  wire [63:0] _GEN_123 = 5'h1b == io_rs2 ? regGroup_27 : _GEN_122; // @[RegUnit.scala 28:{21,21}]
  wire [63:0] _GEN_124 = 5'h1c == io_rs2 ? regGroup_28 : _GEN_123; // @[RegUnit.scala 28:{21,21}]
  wire [63:0] _GEN_125 = 5'h1d == io_rs2 ? regGroup_29 : _GEN_124; // @[RegUnit.scala 28:{21,21}]
  wire [63:0] _GEN_126 = 5'h1e == io_rs2 ? regGroup_30 : _GEN_125; // @[RegUnit.scala 28:{21,21}]
  wire [63:0] _GEN_127 = 5'h1f == io_rs2 ? regGroup_31 : _GEN_126; // @[RegUnit.scala 28:{21,21}]
  wire [63:0] readDataRs2 = _readDataRs2_T_1 ? io_writeData : _GEN_127; // @[RegUnit.scala 28:21]
  assign io_readDataRs1 = io_rs1 == 5'h0 ? 64'h0 : readDataRs1; // @[RegUnit.scala 100:24]
  assign io_readDataRs2 = io_rs2 == 5'h0 ? 64'h0 : readDataRs2; // @[RegUnit.scala 101:24]
  assign io_regAll_1 = regGroup_1; // @[RegUnit.scala 116:18]
  assign io_regAll_2 = regGroup_2; // @[RegUnit.scala 116:18]
  assign io_regAll_3 = regGroup_3; // @[RegUnit.scala 116:18]
  assign io_regAll_4 = regGroup_4; // @[RegUnit.scala 116:18]
  assign io_regAll_5 = regGroup_5; // @[RegUnit.scala 116:18]
  assign io_regAll_6 = regGroup_6; // @[RegUnit.scala 116:18]
  assign io_regAll_7 = regGroup_7; // @[RegUnit.scala 116:18]
  assign io_regAll_8 = regGroup_8; // @[RegUnit.scala 116:18]
  assign io_regAll_9 = regGroup_9; // @[RegUnit.scala 116:18]
  assign io_regAll_10 = regGroup_10; // @[RegUnit.scala 116:18]
  assign io_regAll_11 = regGroup_11; // @[RegUnit.scala 116:18]
  assign io_regAll_12 = regGroup_12; // @[RegUnit.scala 116:18]
  assign io_regAll_13 = regGroup_13; // @[RegUnit.scala 116:18]
  assign io_regAll_14 = regGroup_14; // @[RegUnit.scala 116:18]
  assign io_regAll_15 = regGroup_15; // @[RegUnit.scala 116:18]
  assign io_regAll_16 = regGroup_16; // @[RegUnit.scala 116:18]
  assign io_regAll_17 = regGroup_17; // @[RegUnit.scala 116:18]
  assign io_regAll_18 = regGroup_18; // @[RegUnit.scala 116:18]
  assign io_regAll_19 = regGroup_19; // @[RegUnit.scala 116:18]
  assign io_regAll_20 = regGroup_20; // @[RegUnit.scala 116:18]
  assign io_regAll_21 = regGroup_21; // @[RegUnit.scala 116:18]
  assign io_regAll_22 = regGroup_22; // @[RegUnit.scala 116:18]
  assign io_regAll_23 = regGroup_23; // @[RegUnit.scala 116:18]
  assign io_regAll_24 = regGroup_24; // @[RegUnit.scala 116:18]
  assign io_regAll_25 = regGroup_25; // @[RegUnit.scala 116:18]
  assign io_regAll_26 = regGroup_26; // @[RegUnit.scala 116:18]
  assign io_regAll_27 = regGroup_27; // @[RegUnit.scala 116:18]
  assign io_regAll_28 = regGroup_28; // @[RegUnit.scala 116:18]
  assign io_regAll_29 = regGroup_29; // @[RegUnit.scala 116:18]
  assign io_regAll_30 = regGroup_30; // @[RegUnit.scala 116:18]
  assign io_regAll_31 = regGroup_31; // @[RegUnit.scala 116:18]
  always @(posedge clock) begin
    if (reset) begin // @[RegUnit.scala 74:25]
      regGroup_0 <= 64'h0; // @[RegUnit.scala 74:25]
    end else if (io_writeEnable & io_rd != 5'h0) begin // @[RegUnit.scala 110:52]
      if (5'h0 == io_rd) begin // @[RegUnit.scala 111:21]
        regGroup_0 <= io_writeData; // @[RegUnit.scala 111:21]
      end
    end
    if (reset) begin // @[RegUnit.scala 74:25]
      regGroup_1 <= 64'h0; // @[RegUnit.scala 74:25]
    end else if (io_writeEnable & io_rd != 5'h0) begin // @[RegUnit.scala 110:52]
      if (5'h1 == io_rd) begin // @[RegUnit.scala 111:21]
        regGroup_1 <= io_writeData; // @[RegUnit.scala 111:21]
      end
    end
    if (reset) begin // @[RegUnit.scala 74:25]
      regGroup_2 <= 64'h400; // @[RegUnit.scala 74:25]
    end else if (io_writeEnable & io_rd != 5'h0) begin // @[RegUnit.scala 110:52]
      if (5'h2 == io_rd) begin // @[RegUnit.scala 111:21]
        regGroup_2 <= io_writeData; // @[RegUnit.scala 111:21]
      end
    end
    if (reset) begin // @[RegUnit.scala 74:25]
      regGroup_3 <= 64'h0; // @[RegUnit.scala 74:25]
    end else if (io_writeEnable & io_rd != 5'h0) begin // @[RegUnit.scala 110:52]
      if (5'h3 == io_rd) begin // @[RegUnit.scala 111:21]
        regGroup_3 <= io_writeData; // @[RegUnit.scala 111:21]
      end
    end
    if (reset) begin // @[RegUnit.scala 74:25]
      regGroup_4 <= 64'h0; // @[RegUnit.scala 74:25]
    end else if (io_writeEnable & io_rd != 5'h0) begin // @[RegUnit.scala 110:52]
      if (5'h4 == io_rd) begin // @[RegUnit.scala 111:21]
        regGroup_4 <= io_writeData; // @[RegUnit.scala 111:21]
      end
    end
    if (reset) begin // @[RegUnit.scala 74:25]
      regGroup_5 <= 64'h0; // @[RegUnit.scala 74:25]
    end else if (io_writeEnable & io_rd != 5'h0) begin // @[RegUnit.scala 110:52]
      if (5'h5 == io_rd) begin // @[RegUnit.scala 111:21]
        regGroup_5 <= io_writeData; // @[RegUnit.scala 111:21]
      end
    end
    if (reset) begin // @[RegUnit.scala 74:25]
      regGroup_6 <= 64'h0; // @[RegUnit.scala 74:25]
    end else if (io_writeEnable & io_rd != 5'h0) begin // @[RegUnit.scala 110:52]
      if (5'h6 == io_rd) begin // @[RegUnit.scala 111:21]
        regGroup_6 <= io_writeData; // @[RegUnit.scala 111:21]
      end
    end
    if (reset) begin // @[RegUnit.scala 74:25]
      regGroup_7 <= 64'h0; // @[RegUnit.scala 74:25]
    end else if (io_writeEnable & io_rd != 5'h0) begin // @[RegUnit.scala 110:52]
      if (5'h7 == io_rd) begin // @[RegUnit.scala 111:21]
        regGroup_7 <= io_writeData; // @[RegUnit.scala 111:21]
      end
    end
    if (reset) begin // @[RegUnit.scala 74:25]
      regGroup_8 <= 64'h0; // @[RegUnit.scala 74:25]
    end else if (io_writeEnable & io_rd != 5'h0) begin // @[RegUnit.scala 110:52]
      if (5'h8 == io_rd) begin // @[RegUnit.scala 111:21]
        regGroup_8 <= io_writeData; // @[RegUnit.scala 111:21]
      end
    end
    if (reset) begin // @[RegUnit.scala 74:25]
      regGroup_9 <= 64'h0; // @[RegUnit.scala 74:25]
    end else if (io_writeEnable & io_rd != 5'h0) begin // @[RegUnit.scala 110:52]
      if (5'h9 == io_rd) begin // @[RegUnit.scala 111:21]
        regGroup_9 <= io_writeData; // @[RegUnit.scala 111:21]
      end
    end
    if (reset) begin // @[RegUnit.scala 74:25]
      regGroup_10 <= 64'h0; // @[RegUnit.scala 74:25]
    end else if (io_writeEnable & io_rd != 5'h0) begin // @[RegUnit.scala 110:52]
      if (5'ha == io_rd) begin // @[RegUnit.scala 111:21]
        regGroup_10 <= io_writeData; // @[RegUnit.scala 111:21]
      end
    end
    if (reset) begin // @[RegUnit.scala 74:25]
      regGroup_11 <= 64'h0; // @[RegUnit.scala 74:25]
    end else if (io_writeEnable & io_rd != 5'h0) begin // @[RegUnit.scala 110:52]
      if (5'hb == io_rd) begin // @[RegUnit.scala 111:21]
        regGroup_11 <= io_writeData; // @[RegUnit.scala 111:21]
      end
    end
    if (reset) begin // @[RegUnit.scala 74:25]
      regGroup_12 <= 64'h0; // @[RegUnit.scala 74:25]
    end else if (io_writeEnable & io_rd != 5'h0) begin // @[RegUnit.scala 110:52]
      if (5'hc == io_rd) begin // @[RegUnit.scala 111:21]
        regGroup_12 <= io_writeData; // @[RegUnit.scala 111:21]
      end
    end
    if (reset) begin // @[RegUnit.scala 74:25]
      regGroup_13 <= 64'h0; // @[RegUnit.scala 74:25]
    end else if (io_writeEnable & io_rd != 5'h0) begin // @[RegUnit.scala 110:52]
      if (5'hd == io_rd) begin // @[RegUnit.scala 111:21]
        regGroup_13 <= io_writeData; // @[RegUnit.scala 111:21]
      end
    end
    if (reset) begin // @[RegUnit.scala 74:25]
      regGroup_14 <= 64'h0; // @[RegUnit.scala 74:25]
    end else if (io_writeEnable & io_rd != 5'h0) begin // @[RegUnit.scala 110:52]
      if (5'he == io_rd) begin // @[RegUnit.scala 111:21]
        regGroup_14 <= io_writeData; // @[RegUnit.scala 111:21]
      end
    end
    if (reset) begin // @[RegUnit.scala 74:25]
      regGroup_15 <= 64'h0; // @[RegUnit.scala 74:25]
    end else if (io_writeEnable & io_rd != 5'h0) begin // @[RegUnit.scala 110:52]
      if (5'hf == io_rd) begin // @[RegUnit.scala 111:21]
        regGroup_15 <= io_writeData; // @[RegUnit.scala 111:21]
      end
    end
    if (reset) begin // @[RegUnit.scala 74:25]
      regGroup_16 <= 64'h0; // @[RegUnit.scala 74:25]
    end else if (io_writeEnable & io_rd != 5'h0) begin // @[RegUnit.scala 110:52]
      if (5'h10 == io_rd) begin // @[RegUnit.scala 111:21]
        regGroup_16 <= io_writeData; // @[RegUnit.scala 111:21]
      end
    end
    if (reset) begin // @[RegUnit.scala 74:25]
      regGroup_17 <= 64'h0; // @[RegUnit.scala 74:25]
    end else if (io_writeEnable & io_rd != 5'h0) begin // @[RegUnit.scala 110:52]
      if (5'h11 == io_rd) begin // @[RegUnit.scala 111:21]
        regGroup_17 <= io_writeData; // @[RegUnit.scala 111:21]
      end
    end
    if (reset) begin // @[RegUnit.scala 74:25]
      regGroup_18 <= 64'h0; // @[RegUnit.scala 74:25]
    end else if (io_writeEnable & io_rd != 5'h0) begin // @[RegUnit.scala 110:52]
      if (5'h12 == io_rd) begin // @[RegUnit.scala 111:21]
        regGroup_18 <= io_writeData; // @[RegUnit.scala 111:21]
      end
    end
    if (reset) begin // @[RegUnit.scala 74:25]
      regGroup_19 <= 64'h0; // @[RegUnit.scala 74:25]
    end else if (io_writeEnable & io_rd != 5'h0) begin // @[RegUnit.scala 110:52]
      if (5'h13 == io_rd) begin // @[RegUnit.scala 111:21]
        regGroup_19 <= io_writeData; // @[RegUnit.scala 111:21]
      end
    end
    if (reset) begin // @[RegUnit.scala 74:25]
      regGroup_20 <= 64'h0; // @[RegUnit.scala 74:25]
    end else if (io_writeEnable & io_rd != 5'h0) begin // @[RegUnit.scala 110:52]
      if (5'h14 == io_rd) begin // @[RegUnit.scala 111:21]
        regGroup_20 <= io_writeData; // @[RegUnit.scala 111:21]
      end
    end
    if (reset) begin // @[RegUnit.scala 74:25]
      regGroup_21 <= 64'h0; // @[RegUnit.scala 74:25]
    end else if (io_writeEnable & io_rd != 5'h0) begin // @[RegUnit.scala 110:52]
      if (5'h15 == io_rd) begin // @[RegUnit.scala 111:21]
        regGroup_21 <= io_writeData; // @[RegUnit.scala 111:21]
      end
    end
    if (reset) begin // @[RegUnit.scala 74:25]
      regGroup_22 <= 64'h0; // @[RegUnit.scala 74:25]
    end else if (io_writeEnable & io_rd != 5'h0) begin // @[RegUnit.scala 110:52]
      if (5'h16 == io_rd) begin // @[RegUnit.scala 111:21]
        regGroup_22 <= io_writeData; // @[RegUnit.scala 111:21]
      end
    end
    if (reset) begin // @[RegUnit.scala 74:25]
      regGroup_23 <= 64'h0; // @[RegUnit.scala 74:25]
    end else if (io_writeEnable & io_rd != 5'h0) begin // @[RegUnit.scala 110:52]
      if (5'h17 == io_rd) begin // @[RegUnit.scala 111:21]
        regGroup_23 <= io_writeData; // @[RegUnit.scala 111:21]
      end
    end
    if (reset) begin // @[RegUnit.scala 74:25]
      regGroup_24 <= 64'h0; // @[RegUnit.scala 74:25]
    end else if (io_writeEnable & io_rd != 5'h0) begin // @[RegUnit.scala 110:52]
      if (5'h18 == io_rd) begin // @[RegUnit.scala 111:21]
        regGroup_24 <= io_writeData; // @[RegUnit.scala 111:21]
      end
    end
    if (reset) begin // @[RegUnit.scala 74:25]
      regGroup_25 <= 64'h0; // @[RegUnit.scala 74:25]
    end else if (io_writeEnable & io_rd != 5'h0) begin // @[RegUnit.scala 110:52]
      if (5'h19 == io_rd) begin // @[RegUnit.scala 111:21]
        regGroup_25 <= io_writeData; // @[RegUnit.scala 111:21]
      end
    end
    if (reset) begin // @[RegUnit.scala 74:25]
      regGroup_26 <= 64'h0; // @[RegUnit.scala 74:25]
    end else if (io_writeEnable & io_rd != 5'h0) begin // @[RegUnit.scala 110:52]
      if (5'h1a == io_rd) begin // @[RegUnit.scala 111:21]
        regGroup_26 <= io_writeData; // @[RegUnit.scala 111:21]
      end
    end
    if (reset) begin // @[RegUnit.scala 74:25]
      regGroup_27 <= 64'h0; // @[RegUnit.scala 74:25]
    end else if (io_writeEnable & io_rd != 5'h0) begin // @[RegUnit.scala 110:52]
      if (5'h1b == io_rd) begin // @[RegUnit.scala 111:21]
        regGroup_27 <= io_writeData; // @[RegUnit.scala 111:21]
      end
    end
    if (reset) begin // @[RegUnit.scala 74:25]
      regGroup_28 <= 64'h0; // @[RegUnit.scala 74:25]
    end else if (io_writeEnable & io_rd != 5'h0) begin // @[RegUnit.scala 110:52]
      if (5'h1c == io_rd) begin // @[RegUnit.scala 111:21]
        regGroup_28 <= io_writeData; // @[RegUnit.scala 111:21]
      end
    end
    if (reset) begin // @[RegUnit.scala 74:25]
      regGroup_29 <= 64'h0; // @[RegUnit.scala 74:25]
    end else if (io_writeEnable & io_rd != 5'h0) begin // @[RegUnit.scala 110:52]
      if (5'h1d == io_rd) begin // @[RegUnit.scala 111:21]
        regGroup_29 <= io_writeData; // @[RegUnit.scala 111:21]
      end
    end
    if (reset) begin // @[RegUnit.scala 74:25]
      regGroup_30 <= 64'h0; // @[RegUnit.scala 74:25]
    end else if (io_writeEnable & io_rd != 5'h0) begin // @[RegUnit.scala 110:52]
      if (5'h1e == io_rd) begin // @[RegUnit.scala 111:21]
        regGroup_30 <= io_writeData; // @[RegUnit.scala 111:21]
      end
    end
    if (reset) begin // @[RegUnit.scala 74:25]
      regGroup_31 <= 64'h0; // @[RegUnit.scala 74:25]
    end else if (io_writeEnable & io_rd != 5'h0) begin // @[RegUnit.scala 110:52]
      if (5'h1f == io_rd) begin // @[RegUnit.scala 111:21]
        regGroup_31 <= io_writeData; // @[RegUnit.scala 111:21]
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
  wire  resWire_sign = _resWire_T_12[31]; // @[CPUUtils.scala 114:33]
  wire [31:0] _resWire_T_14 = resWire_sign ? 32'hffffffff : 32'h0; // @[Bitwise.scala 77:12]
  wire [63:0] _resWire_T_16 = {_resWire_T_14,_resWire_T_12}; // @[Cat.scala 33:92]
  wire [63:0] _resWire_T_18 = io_x + io_y; // @[ALU.scala 84:27]
  wire [63:0] _GEN_6 = isWord ? _resWire_T_16 : _resWire_T_18; // @[ALU.scala 81:33 82:19 84:19]
  wire [31:0] _resWire_T_20 = x32 - y32; // @[ALU.scala 90:43]
  wire  resWire_sign_1 = _resWire_T_20[31]; // @[CPUUtils.scala 114:33]
  wire [31:0] _resWire_T_22 = resWire_sign_1 ? 32'hffffffff : 32'h0; // @[Bitwise.scala 77:12]
  wire [63:0] _resWire_T_24 = {_resWire_T_22,_resWire_T_20}; // @[Cat.scala 33:92]
  wire [63:0] _resWire_T_26 = io_x - io_y; // @[ALU.scala 92:27]
  wire [63:0] _GEN_7 = isWord ? _resWire_T_24 : _resWire_T_26; // @[ALU.scala 89:33 90:19 92:19]
  wire [62:0] _GEN_21 = {{31'd0}, x32}; // @[ALU.scala 98:43]
  wire [62:0] _resWire_T_27 = _GEN_21 << shamtW; // @[ALU.scala 98:43]
  wire  resWire_sign_2 = _resWire_T_27[31]; // @[CPUUtils.scala 114:33]
  wire [31:0] _resWire_T_29 = resWire_sign_2 ? 32'hffffffff : 32'h0; // @[Bitwise.scala 77:12]
  wire [63:0] _resWire_T_31 = {_resWire_T_29,_resWire_T_27[31:0]}; // @[Cat.scala 33:92]
  wire [126:0] _GEN_22 = {{63'd0}, io_x}; // @[ALU.scala 100:27]
  wire [126:0] _resWire_T_32 = _GEN_22 << shamt; // @[ALU.scala 100:27]
  wire [126:0] _GEN_8 = isWord ? {{63'd0}, _resWire_T_31} : _resWire_T_32; // @[ALU.scala 100:19 97:33 98:19]
  wire [63:0] _resWire_T_37 = io_x ^ io_y; // @[ALU.scala 113:26]
  wire [31:0] _resWire_T_38 = x32 >> shamtW; // @[ALU.scala 118:43]
  wire  resWire_sign_3 = _resWire_T_38[31]; // @[CPUUtils.scala 114:33]
  wire [31:0] _resWire_T_40 = resWire_sign_3 ? 32'hffffffff : 32'h0; // @[Bitwise.scala 77:12]
  wire [63:0] _resWire_T_42 = {_resWire_T_40,_resWire_T_38}; // @[Cat.scala 33:92]
  wire [63:0] _resWire_T_43 = io_x >> shamt; // @[ALU.scala 120:27]
  wire [63:0] _GEN_9 = isWord ? _resWire_T_42 : _resWire_T_43; // @[ALU.scala 117:33 118:19 120:19]
  wire [31:0] _resWire_T_44 = io_x[31:0]; // @[ALU.scala 127:18]
  wire [31:0] _resWire_T_46 = $signed(_resWire_T_44) >>> shamtW; // @[ALU.scala 127:36]
  wire  resWire_sign_4 = _resWire_T_46[31]; // @[CPUUtils.scala 114:33]
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
  wire  readDataMasked_sign = readDataIntercept[7]; // @[CPUUtils.scala 114:33]
  wire [55:0] _readDataMasked_T_10 = readDataMasked_sign ? 56'hffffffffffffff : 56'h0; // @[Bitwise.scala 77:12]
  wire [63:0] _readDataMasked_T_12 = {_readDataMasked_T_10,readDataIntercept[7:0]}; // @[Cat.scala 33:92]
  wire  readDataMasked_sign_1 = readDataIntercept[15]; // @[CPUUtils.scala 114:33]
  wire [47:0] _readDataMasked_T_14 = readDataMasked_sign_1 ? 48'hffffffffffff : 48'h0; // @[Bitwise.scala 77:12]
  wire [63:0] _readDataMasked_T_16 = {_readDataMasked_T_14,readDataIntercept[15:0]}; // @[Cat.scala 33:92]
  wire  readDataMasked_sign_2 = readDataIntercept[31]; // @[CPUUtils.scala 114:33]
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
module IFIDStageRegs(
  input         clock,
  input         reset,
  input         io_stall,
  input         io_flush,
  input  [63:0] io_in_pc,
  input  [31:0] io_in_inst,
  output [63:0] io_out_pc,
  output [31:0] io_out_inst
);
`ifdef RANDOMIZE_REG_INIT
  reg [63:0] _RAND_0;
  reg [31:0] _RAND_1;
`endif // RANDOMIZE_REG_INIT
  reg [63:0] reg_pc; // @[GeneralStageRegs.scala 43:20]
  reg [31:0] reg_inst; // @[GeneralStageRegs.scala 43:20]
  assign io_out_pc = io_flush ? 64'h0 : reg_pc; // @[GeneralStageRegs.scala 53:18 54:12 56:12]
  assign io_out_inst = io_flush ? 32'h0 : reg_inst; // @[GeneralStageRegs.scala 53:18 54:12 56:12]
  always @(posedge clock) begin
    if (reset) begin // @[GeneralStageRegs.scala 43:20]
      reg_pc <= 64'h0; // @[GeneralStageRegs.scala 43:20]
    end else if (!(io_stall)) begin // @[GeneralStageRegs.scala 46:18]
      reg_pc <= io_in_pc; // @[GeneralStageRegs.scala 49:9]
    end
    if (reset) begin // @[GeneralStageRegs.scala 43:20]
      reg_inst <= 32'h0; // @[GeneralStageRegs.scala 43:20]
    end else if (!(io_stall)) begin // @[GeneralStageRegs.scala 46:18]
      reg_inst <= io_in_inst; // @[GeneralStageRegs.scala 49:9]
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
  reg_pc = _RAND_0[63:0];
  _RAND_1 = {1{`RANDOM}};
  reg_inst = _RAND_1[31:0];
`endif // RANDOMIZE_REG_INIT
  `endif // RANDOMIZE
end // initial
`ifdef FIRRTL_AFTER_INITIAL
`FIRRTL_AFTER_INITIAL
`endif
`endif // SYNTHESIS
endmodule
module IDEXEStageRegs(
  input         clock,
  input         reset,
  input         io_flush,
  input  [63:0] io_in_pc,
  input  [31:0] io_in_inst,
  input         io_in_isJALR,
  input         io_in_isBType,
  input         io_in_isJump,
  input         io_in_immALUToReg,
  input         io_in_memRead,
  input         io_in_memWrite,
  input         io_in_writeEnable,
  input  [5:0]  io_in_aluOperation,
  input  [63:0] io_in_readDataRs2,
  input  [4:0]  io_in_rd,
  input  [63:0] io_in_aluX,
  input  [63:0] io_in_aluY,
  input  [63:0] io_in_imm,
  output [63:0] io_out_pc,
  output [31:0] io_out_inst,
  output        io_out_isJALR,
  output        io_out_isBType,
  output        io_out_isJump,
  output        io_out_immALUToReg,
  output        io_out_memRead,
  output        io_out_memWrite,
  output        io_out_writeEnable,
  output [5:0]  io_out_aluOperation,
  output [63:0] io_out_readDataRs2,
  output [4:0]  io_out_rd,
  output [63:0] io_out_aluX,
  output [63:0] io_out_aluY,
  output [63:0] io_out_imm
);
`ifdef RANDOMIZE_REG_INIT
  reg [63:0] _RAND_0;
  reg [31:0] _RAND_1;
  reg [31:0] _RAND_2;
  reg [31:0] _RAND_3;
  reg [31:0] _RAND_4;
  reg [31:0] _RAND_5;
  reg [31:0] _RAND_6;
  reg [31:0] _RAND_7;
  reg [31:0] _RAND_8;
  reg [31:0] _RAND_9;
  reg [63:0] _RAND_10;
  reg [31:0] _RAND_11;
  reg [63:0] _RAND_12;
  reg [63:0] _RAND_13;
  reg [63:0] _RAND_14;
`endif // RANDOMIZE_REG_INIT
  reg [63:0] reg_pc; // @[GeneralStageRegs.scala 43:20]
  reg [31:0] reg_inst; // @[GeneralStageRegs.scala 43:20]
  reg  reg_isJALR; // @[GeneralStageRegs.scala 43:20]
  reg  reg_isBType; // @[GeneralStageRegs.scala 43:20]
  reg  reg_isJump; // @[GeneralStageRegs.scala 43:20]
  reg  reg_immALUToReg; // @[GeneralStageRegs.scala 43:20]
  reg  reg_memRead; // @[GeneralStageRegs.scala 43:20]
  reg  reg_memWrite; // @[GeneralStageRegs.scala 43:20]
  reg  reg_writeEnable; // @[GeneralStageRegs.scala 43:20]
  reg [5:0] reg_aluOperation; // @[GeneralStageRegs.scala 43:20]
  reg [63:0] reg_readDataRs2; // @[GeneralStageRegs.scala 43:20]
  reg [4:0] reg_rd; // @[GeneralStageRegs.scala 43:20]
  reg [63:0] reg_aluX; // @[GeneralStageRegs.scala 43:20]
  reg [63:0] reg_aluY; // @[GeneralStageRegs.scala 43:20]
  reg [63:0] reg_imm; // @[GeneralStageRegs.scala 43:20]
  assign io_out_pc = io_flush ? 64'h0 : reg_pc; // @[GeneralStageRegs.scala 53:18 54:12 56:12]
  assign io_out_inst = io_flush ? 32'h0 : reg_inst; // @[GeneralStageRegs.scala 53:18 54:12 56:12]
  assign io_out_isJALR = io_flush ? 1'h0 : reg_isJALR; // @[GeneralStageRegs.scala 53:18 54:12 56:12]
  assign io_out_isBType = io_flush ? 1'h0 : reg_isBType; // @[GeneralStageRegs.scala 53:18 54:12 56:12]
  assign io_out_isJump = io_flush ? 1'h0 : reg_isJump; // @[GeneralStageRegs.scala 53:18 54:12 56:12]
  assign io_out_immALUToReg = io_flush ? 1'h0 : reg_immALUToReg; // @[GeneralStageRegs.scala 53:18 54:12 56:12]
  assign io_out_memRead = io_flush ? 1'h0 : reg_memRead; // @[GeneralStageRegs.scala 53:18 54:12 56:12]
  assign io_out_memWrite = io_flush ? 1'h0 : reg_memWrite; // @[GeneralStageRegs.scala 53:18 54:12 56:12]
  assign io_out_writeEnable = io_flush ? 1'h0 : reg_writeEnable; // @[GeneralStageRegs.scala 53:18 54:12 56:12]
  assign io_out_aluOperation = io_flush ? 6'h0 : reg_aluOperation; // @[GeneralStageRegs.scala 53:18 54:12 56:12]
  assign io_out_readDataRs2 = io_flush ? 64'h0 : reg_readDataRs2; // @[GeneralStageRegs.scala 53:18 54:12 56:12]
  assign io_out_rd = io_flush ? 5'h0 : reg_rd; // @[GeneralStageRegs.scala 53:18 54:12 56:12]
  assign io_out_aluX = io_flush ? 64'h0 : reg_aluX; // @[GeneralStageRegs.scala 53:18 54:12 56:12]
  assign io_out_aluY = io_flush ? 64'h0 : reg_aluY; // @[GeneralStageRegs.scala 53:18 54:12 56:12]
  assign io_out_imm = io_flush ? 64'h0 : reg_imm; // @[GeneralStageRegs.scala 53:18 54:12 56:12]
  always @(posedge clock) begin
    if (reset) begin // @[GeneralStageRegs.scala 43:20]
      reg_pc <= 64'h0; // @[GeneralStageRegs.scala 43:20]
    end else begin
      reg_pc <= io_in_pc;
    end
    if (reset) begin // @[GeneralStageRegs.scala 43:20]
      reg_inst <= 32'h0; // @[GeneralStageRegs.scala 43:20]
    end else begin
      reg_inst <= io_in_inst;
    end
    if (reset) begin // @[GeneralStageRegs.scala 43:20]
      reg_isJALR <= 1'h0; // @[GeneralStageRegs.scala 43:20]
    end else begin
      reg_isJALR <= io_in_isJALR;
    end
    if (reset) begin // @[GeneralStageRegs.scala 43:20]
      reg_isBType <= 1'h0; // @[GeneralStageRegs.scala 43:20]
    end else begin
      reg_isBType <= io_in_isBType;
    end
    if (reset) begin // @[GeneralStageRegs.scala 43:20]
      reg_isJump <= 1'h0; // @[GeneralStageRegs.scala 43:20]
    end else begin
      reg_isJump <= io_in_isJump;
    end
    if (reset) begin // @[GeneralStageRegs.scala 43:20]
      reg_immALUToReg <= 1'h0; // @[GeneralStageRegs.scala 43:20]
    end else begin
      reg_immALUToReg <= io_in_immALUToReg;
    end
    if (reset) begin // @[GeneralStageRegs.scala 43:20]
      reg_memRead <= 1'h0; // @[GeneralStageRegs.scala 43:20]
    end else begin
      reg_memRead <= io_in_memRead;
    end
    if (reset) begin // @[GeneralStageRegs.scala 43:20]
      reg_memWrite <= 1'h0; // @[GeneralStageRegs.scala 43:20]
    end else begin
      reg_memWrite <= io_in_memWrite;
    end
    if (reset) begin // @[GeneralStageRegs.scala 43:20]
      reg_writeEnable <= 1'h0; // @[GeneralStageRegs.scala 43:20]
    end else begin
      reg_writeEnable <= io_in_writeEnable;
    end
    if (reset) begin // @[GeneralStageRegs.scala 43:20]
      reg_aluOperation <= 6'h0; // @[GeneralStageRegs.scala 43:20]
    end else begin
      reg_aluOperation <= io_in_aluOperation;
    end
    if (reset) begin // @[GeneralStageRegs.scala 43:20]
      reg_readDataRs2 <= 64'h0; // @[GeneralStageRegs.scala 43:20]
    end else begin
      reg_readDataRs2 <= io_in_readDataRs2;
    end
    if (reset) begin // @[GeneralStageRegs.scala 43:20]
      reg_rd <= 5'h0; // @[GeneralStageRegs.scala 43:20]
    end else begin
      reg_rd <= io_in_rd;
    end
    if (reset) begin // @[GeneralStageRegs.scala 43:20]
      reg_aluX <= 64'h0; // @[GeneralStageRegs.scala 43:20]
    end else begin
      reg_aluX <= io_in_aluX;
    end
    if (reset) begin // @[GeneralStageRegs.scala 43:20]
      reg_aluY <= 64'h0; // @[GeneralStageRegs.scala 43:20]
    end else begin
      reg_aluY <= io_in_aluY;
    end
    if (reset) begin // @[GeneralStageRegs.scala 43:20]
      reg_imm <= 64'h0; // @[GeneralStageRegs.scala 43:20]
    end else begin
      reg_imm <= io_in_imm;
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
  reg_pc = _RAND_0[63:0];
  _RAND_1 = {1{`RANDOM}};
  reg_inst = _RAND_1[31:0];
  _RAND_2 = {1{`RANDOM}};
  reg_isJALR = _RAND_2[0:0];
  _RAND_3 = {1{`RANDOM}};
  reg_isBType = _RAND_3[0:0];
  _RAND_4 = {1{`RANDOM}};
  reg_isJump = _RAND_4[0:0];
  _RAND_5 = {1{`RANDOM}};
  reg_immALUToReg = _RAND_5[0:0];
  _RAND_6 = {1{`RANDOM}};
  reg_memRead = _RAND_6[0:0];
  _RAND_7 = {1{`RANDOM}};
  reg_memWrite = _RAND_7[0:0];
  _RAND_8 = {1{`RANDOM}};
  reg_writeEnable = _RAND_8[0:0];
  _RAND_9 = {1{`RANDOM}};
  reg_aluOperation = _RAND_9[5:0];
  _RAND_10 = {2{`RANDOM}};
  reg_readDataRs2 = _RAND_10[63:0];
  _RAND_11 = {1{`RANDOM}};
  reg_rd = _RAND_11[4:0];
  _RAND_12 = {2{`RANDOM}};
  reg_aluX = _RAND_12[63:0];
  _RAND_13 = {2{`RANDOM}};
  reg_aluY = _RAND_13[63:0];
  _RAND_14 = {2{`RANDOM}};
  reg_imm = _RAND_14[63:0];
`endif // RANDOMIZE_REG_INIT
  `endif // RANDOMIZE
end // initial
`ifdef FIRRTL_AFTER_INITIAL
`FIRRTL_AFTER_INITIAL
`endif
`endif // SYNTHESIS
endmodule
module EXEMEMStageRegs(
  input         clock,
  input         reset,
  input  [63:0] io_in_pc,
  input  [31:0] io_in_inst,
  input         io_in_isJump,
  input         io_in_immALUToReg,
  input         io_in_memRead,
  input         io_in_memWrite,
  input         io_in_writeEnable,
  input  [63:0] io_in_readDataRs2,
  input  [4:0]  io_in_rd,
  input  [63:0] io_in_aluResult,
  input  [63:0] io_in_imm,
  output [63:0] io_out_pc,
  output [31:0] io_out_inst,
  output        io_out_isJump,
  output        io_out_immALUToReg,
  output        io_out_memRead,
  output        io_out_memWrite,
  output        io_out_writeEnable,
  output [63:0] io_out_readDataRs2,
  output [4:0]  io_out_rd,
  output [63:0] io_out_aluResult,
  output [63:0] io_out_imm
);
`ifdef RANDOMIZE_REG_INIT
  reg [63:0] _RAND_0;
  reg [31:0] _RAND_1;
  reg [31:0] _RAND_2;
  reg [31:0] _RAND_3;
  reg [31:0] _RAND_4;
  reg [31:0] _RAND_5;
  reg [31:0] _RAND_6;
  reg [63:0] _RAND_7;
  reg [31:0] _RAND_8;
  reg [63:0] _RAND_9;
  reg [63:0] _RAND_10;
`endif // RANDOMIZE_REG_INIT
  reg [63:0] reg_pc; // @[GeneralStageRegs.scala 43:20]
  reg [31:0] reg_inst; // @[GeneralStageRegs.scala 43:20]
  reg  reg_isJump; // @[GeneralStageRegs.scala 43:20]
  reg  reg_immALUToReg; // @[GeneralStageRegs.scala 43:20]
  reg  reg_memRead; // @[GeneralStageRegs.scala 43:20]
  reg  reg_memWrite; // @[GeneralStageRegs.scala 43:20]
  reg  reg_writeEnable; // @[GeneralStageRegs.scala 43:20]
  reg [63:0] reg_readDataRs2; // @[GeneralStageRegs.scala 43:20]
  reg [4:0] reg_rd; // @[GeneralStageRegs.scala 43:20]
  reg [63:0] reg_aluResult; // @[GeneralStageRegs.scala 43:20]
  reg [63:0] reg_imm; // @[GeneralStageRegs.scala 43:20]
  assign io_out_pc = reg_pc; // @[GeneralStageRegs.scala 53:18 54:12 56:12]
  assign io_out_inst = reg_inst; // @[GeneralStageRegs.scala 53:18 54:12 56:12]
  assign io_out_isJump = reg_isJump; // @[GeneralStageRegs.scala 53:18 54:12 56:12]
  assign io_out_immALUToReg = reg_immALUToReg; // @[GeneralStageRegs.scala 53:18 54:12 56:12]
  assign io_out_memRead = reg_memRead; // @[GeneralStageRegs.scala 53:18 54:12 56:12]
  assign io_out_memWrite = reg_memWrite; // @[GeneralStageRegs.scala 53:18 54:12 56:12]
  assign io_out_writeEnable = reg_writeEnable; // @[GeneralStageRegs.scala 53:18 54:12 56:12]
  assign io_out_readDataRs2 = reg_readDataRs2; // @[GeneralStageRegs.scala 53:18 54:12 56:12]
  assign io_out_rd = reg_rd; // @[GeneralStageRegs.scala 53:18 54:12 56:12]
  assign io_out_aluResult = reg_aluResult; // @[GeneralStageRegs.scala 53:18 54:12 56:12]
  assign io_out_imm = reg_imm; // @[GeneralStageRegs.scala 53:18 54:12 56:12]
  always @(posedge clock) begin
    if (reset) begin // @[GeneralStageRegs.scala 43:20]
      reg_pc <= 64'h0; // @[GeneralStageRegs.scala 43:20]
    end else begin
      reg_pc <= io_in_pc;
    end
    if (reset) begin // @[GeneralStageRegs.scala 43:20]
      reg_inst <= 32'h0; // @[GeneralStageRegs.scala 43:20]
    end else begin
      reg_inst <= io_in_inst;
    end
    if (reset) begin // @[GeneralStageRegs.scala 43:20]
      reg_isJump <= 1'h0; // @[GeneralStageRegs.scala 43:20]
    end else begin
      reg_isJump <= io_in_isJump;
    end
    if (reset) begin // @[GeneralStageRegs.scala 43:20]
      reg_immALUToReg <= 1'h0; // @[GeneralStageRegs.scala 43:20]
    end else begin
      reg_immALUToReg <= io_in_immALUToReg;
    end
    if (reset) begin // @[GeneralStageRegs.scala 43:20]
      reg_memRead <= 1'h0; // @[GeneralStageRegs.scala 43:20]
    end else begin
      reg_memRead <= io_in_memRead;
    end
    if (reset) begin // @[GeneralStageRegs.scala 43:20]
      reg_memWrite <= 1'h0; // @[GeneralStageRegs.scala 43:20]
    end else begin
      reg_memWrite <= io_in_memWrite;
    end
    if (reset) begin // @[GeneralStageRegs.scala 43:20]
      reg_writeEnable <= 1'h0; // @[GeneralStageRegs.scala 43:20]
    end else begin
      reg_writeEnable <= io_in_writeEnable;
    end
    if (reset) begin // @[GeneralStageRegs.scala 43:20]
      reg_readDataRs2 <= 64'h0; // @[GeneralStageRegs.scala 43:20]
    end else begin
      reg_readDataRs2 <= io_in_readDataRs2;
    end
    if (reset) begin // @[GeneralStageRegs.scala 43:20]
      reg_rd <= 5'h0; // @[GeneralStageRegs.scala 43:20]
    end else begin
      reg_rd <= io_in_rd;
    end
    if (reset) begin // @[GeneralStageRegs.scala 43:20]
      reg_aluResult <= 64'h0; // @[GeneralStageRegs.scala 43:20]
    end else begin
      reg_aluResult <= io_in_aluResult;
    end
    if (reset) begin // @[GeneralStageRegs.scala 43:20]
      reg_imm <= 64'h0; // @[GeneralStageRegs.scala 43:20]
    end else begin
      reg_imm <= io_in_imm;
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
  reg_pc = _RAND_0[63:0];
  _RAND_1 = {1{`RANDOM}};
  reg_inst = _RAND_1[31:0];
  _RAND_2 = {1{`RANDOM}};
  reg_isJump = _RAND_2[0:0];
  _RAND_3 = {1{`RANDOM}};
  reg_immALUToReg = _RAND_3[0:0];
  _RAND_4 = {1{`RANDOM}};
  reg_memRead = _RAND_4[0:0];
  _RAND_5 = {1{`RANDOM}};
  reg_memWrite = _RAND_5[0:0];
  _RAND_6 = {1{`RANDOM}};
  reg_writeEnable = _RAND_6[0:0];
  _RAND_7 = {2{`RANDOM}};
  reg_readDataRs2 = _RAND_7[63:0];
  _RAND_8 = {1{`RANDOM}};
  reg_rd = _RAND_8[4:0];
  _RAND_9 = {2{`RANDOM}};
  reg_aluResult = _RAND_9[63:0];
  _RAND_10 = {2{`RANDOM}};
  reg_imm = _RAND_10[63:0];
`endif // RANDOMIZE_REG_INIT
  `endif // RANDOMIZE
end // initial
`ifdef FIRRTL_AFTER_INITIAL
`FIRRTL_AFTER_INITIAL
`endif
`endif // SYNTHESIS
endmodule
module MEMWBStageRegs(
  input         clock,
  input         reset,
  input  [63:0] io_in_pc,
  input  [31:0] io_in_inst,
  input         io_in_isJump,
  input         io_in_immALUToReg,
  input         io_in_memRead,
  input         io_in_writeEnable,
  input  [63:0] io_in_readData,
  input  [63:0] io_in_aluResult,
  input  [63:0] io_in_imm,
  output [63:0] io_out_pc,
  output [31:0] io_out_inst,
  output        io_out_isJump,
  output        io_out_immALUToReg,
  output        io_out_memRead,
  output        io_out_writeEnable,
  output [63:0] io_out_readData,
  output [63:0] io_out_aluResult,
  output [63:0] io_out_imm
);
`ifdef RANDOMIZE_REG_INIT
  reg [63:0] _RAND_0;
  reg [31:0] _RAND_1;
  reg [31:0] _RAND_2;
  reg [31:0] _RAND_3;
  reg [31:0] _RAND_4;
  reg [31:0] _RAND_5;
  reg [63:0] _RAND_6;
  reg [63:0] _RAND_7;
  reg [63:0] _RAND_8;
`endif // RANDOMIZE_REG_INIT
  reg [63:0] reg_pc; // @[GeneralStageRegs.scala 43:20]
  reg [31:0] reg_inst; // @[GeneralStageRegs.scala 43:20]
  reg  reg_isJump; // @[GeneralStageRegs.scala 43:20]
  reg  reg_immALUToReg; // @[GeneralStageRegs.scala 43:20]
  reg  reg_memRead; // @[GeneralStageRegs.scala 43:20]
  reg  reg_writeEnable; // @[GeneralStageRegs.scala 43:20]
  reg [63:0] reg_readData; // @[GeneralStageRegs.scala 43:20]
  reg [63:0] reg_aluResult; // @[GeneralStageRegs.scala 43:20]
  reg [63:0] reg_imm; // @[GeneralStageRegs.scala 43:20]
  assign io_out_pc = reg_pc; // @[GeneralStageRegs.scala 53:18 54:12 56:12]
  assign io_out_inst = reg_inst; // @[GeneralStageRegs.scala 53:18 54:12 56:12]
  assign io_out_isJump = reg_isJump; // @[GeneralStageRegs.scala 53:18 54:12 56:12]
  assign io_out_immALUToReg = reg_immALUToReg; // @[GeneralStageRegs.scala 53:18 54:12 56:12]
  assign io_out_memRead = reg_memRead; // @[GeneralStageRegs.scala 53:18 54:12 56:12]
  assign io_out_writeEnable = reg_writeEnable; // @[GeneralStageRegs.scala 53:18 54:12 56:12]
  assign io_out_readData = reg_readData; // @[GeneralStageRegs.scala 53:18 54:12 56:12]
  assign io_out_aluResult = reg_aluResult; // @[GeneralStageRegs.scala 53:18 54:12 56:12]
  assign io_out_imm = reg_imm; // @[GeneralStageRegs.scala 53:18 54:12 56:12]
  always @(posedge clock) begin
    if (reset) begin // @[GeneralStageRegs.scala 43:20]
      reg_pc <= 64'h0; // @[GeneralStageRegs.scala 43:20]
    end else begin
      reg_pc <= io_in_pc;
    end
    if (reset) begin // @[GeneralStageRegs.scala 43:20]
      reg_inst <= 32'h0; // @[GeneralStageRegs.scala 43:20]
    end else begin
      reg_inst <= io_in_inst;
    end
    if (reset) begin // @[GeneralStageRegs.scala 43:20]
      reg_isJump <= 1'h0; // @[GeneralStageRegs.scala 43:20]
    end else begin
      reg_isJump <= io_in_isJump;
    end
    if (reset) begin // @[GeneralStageRegs.scala 43:20]
      reg_immALUToReg <= 1'h0; // @[GeneralStageRegs.scala 43:20]
    end else begin
      reg_immALUToReg <= io_in_immALUToReg;
    end
    if (reset) begin // @[GeneralStageRegs.scala 43:20]
      reg_memRead <= 1'h0; // @[GeneralStageRegs.scala 43:20]
    end else begin
      reg_memRead <= io_in_memRead;
    end
    if (reset) begin // @[GeneralStageRegs.scala 43:20]
      reg_writeEnable <= 1'h0; // @[GeneralStageRegs.scala 43:20]
    end else begin
      reg_writeEnable <= io_in_writeEnable;
    end
    if (reset) begin // @[GeneralStageRegs.scala 43:20]
      reg_readData <= 64'h0; // @[GeneralStageRegs.scala 43:20]
    end else begin
      reg_readData <= io_in_readData;
    end
    if (reset) begin // @[GeneralStageRegs.scala 43:20]
      reg_aluResult <= 64'h0; // @[GeneralStageRegs.scala 43:20]
    end else begin
      reg_aluResult <= io_in_aluResult;
    end
    if (reset) begin // @[GeneralStageRegs.scala 43:20]
      reg_imm <= 64'h0; // @[GeneralStageRegs.scala 43:20]
    end else begin
      reg_imm <= io_in_imm;
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
  reg_pc = _RAND_0[63:0];
  _RAND_1 = {1{`RANDOM}};
  reg_inst = _RAND_1[31:0];
  _RAND_2 = {1{`RANDOM}};
  reg_isJump = _RAND_2[0:0];
  _RAND_3 = {1{`RANDOM}};
  reg_immALUToReg = _RAND_3[0:0];
  _RAND_4 = {1{`RANDOM}};
  reg_memRead = _RAND_4[0:0];
  _RAND_5 = {1{`RANDOM}};
  reg_writeEnable = _RAND_5[0:0];
  _RAND_6 = {2{`RANDOM}};
  reg_readData = _RAND_6[63:0];
  _RAND_7 = {2{`RANDOM}};
  reg_aluResult = _RAND_7[63:0];
  _RAND_8 = {2{`RANDOM}};
  reg_imm = _RAND_8[63:0];
`endif // RANDOMIZE_REG_INIT
  `endif // RANDOMIZE
end // initial
`ifdef FIRRTL_AFTER_INITIAL
`FIRRTL_AFTER_INITIAL
`endif
`endif // SYNTHESIS
endmodule
module BranchControlUnit(
  input         clock,
  input         reset,
  input         io_keep,
  input         io_isJump,
  input         io_isBType,
  input  [63:0] io_ifPC,
  input  [63:0] io_idPC,
  input  [63:0] io_exePC,
  input  [63:0] io_selectPC,
  output [63:0] io_nextPC,
  output        io_flush
);
`ifdef RANDOMIZE_REG_INIT
  reg [31:0] _RAND_0;
  reg [63:0] _RAND_1;
  reg [31:0] _RAND_2;
`endif // RANDOMIZE_REG_INIT
  reg [1:0] needAdd_0; // @[BranchControlUnit.scala 42:25]
  reg [63:0] needAdd_1; // @[BranchControlUnit.scala 43:28]
  reg  flushReg; // @[BranchControlUnit.scala 44:25]
  wire [63:0] _nextPC_T_1 = io_ifPC + 64'h4; // @[BranchControlUnit.scala 46:36]
  wire  _T_1 = io_isJump | io_isBType; // @[BranchControlUnit.scala 58:24]
  wire [63:0] _GEN_0 = io_isJump | io_isBType ? 64'h0 : _nextPC_T_1; // @[BranchControlUnit.scala 55:16 58:39 59:18]
  wire [63:0] _GEN_4 = io_exePC == needAdd_1 ? io_selectPC : 64'h0; // @[BranchControlUnit.scala 67:16 70:40 71:18]
  wire [63:0] _GEN_5 = io_exePC == needAdd_1 ? io_selectPC : needAdd_1; // @[BranchControlUnit.scala 70:40 72:23 43:28]
  wire [1:0] _GEN_7 = io_exePC == needAdd_1 ? 2'h2 : needAdd_0; // @[BranchControlUnit.scala 70:40 74:20 42:25]
  wire [63:0] _GEN_8 = io_ifPC == needAdd_1 ? _nextPC_T_1 : needAdd_1; // @[BranchControlUnit.scala 79:16 82:39 83:18]
  wire [63:0] _GEN_9 = io_ifPC == needAdd_1 ? 64'h0 : needAdd_1; // @[BranchControlUnit.scala 82:39 84:23 43:28]
  wire  _GEN_10 = io_ifPC == needAdd_1 ? 1'h0 : 1'h1; // @[BranchControlUnit.scala 80:18 82:39 85:20]
  wire [1:0] _GEN_11 = io_ifPC == needAdd_1 ? 2'h0 : needAdd_0; // @[BranchControlUnit.scala 82:39 86:20 42:25]
  wire [63:0] _GEN_12 = 2'h2 == needAdd_0 ? _GEN_8 : _nextPC_T_1; // @[BranchControlUnit.scala 53:22]
  wire  _GEN_13 = 2'h2 == needAdd_0 ? _GEN_10 : flushReg; // @[BranchControlUnit.scala 53:22 44:25]
  wire [63:0] _GEN_14 = 2'h2 == needAdd_0 ? _GEN_9 : needAdd_1; // @[BranchControlUnit.scala 53:22 43:28]
  wire [1:0] _GEN_15 = 2'h2 == needAdd_0 ? _GEN_11 : needAdd_0; // @[BranchControlUnit.scala 53:22 42:25]
  wire [63:0] _GEN_16 = 2'h1 == needAdd_0 ? _GEN_4 : _GEN_12; // @[BranchControlUnit.scala 53:22]
  wire [63:0] _GEN_20 = 2'h0 == needAdd_0 ? _GEN_0 : _GEN_16; // @[BranchControlUnit.scala 53:22]
  assign io_nextPC = io_keep ? io_ifPC : _GEN_20; // @[BranchControlUnit.scala 48:17 49:12]
  assign io_flush = flushReg; // @[BranchControlUnit.scala 92:12]
  always @(posedge clock) begin
    if (reset) begin // @[BranchControlUnit.scala 42:25]
      needAdd_0 <= 2'h0; // @[BranchControlUnit.scala 42:25]
    end else if (!(io_keep)) begin // @[BranchControlUnit.scala 48:17]
      if (2'h0 == needAdd_0) begin // @[BranchControlUnit.scala 53:22]
        if (io_isJump | io_isBType) begin // @[BranchControlUnit.scala 58:39]
          needAdd_0 <= 2'h1; // @[BranchControlUnit.scala 62:20]
        end
      end else if (2'h1 == needAdd_0) begin // @[BranchControlUnit.scala 53:22]
        needAdd_0 <= _GEN_7;
      end else begin
        needAdd_0 <= _GEN_15;
      end
    end
    if (reset) begin // @[BranchControlUnit.scala 43:28]
      needAdd_1 <= 64'h0; // @[BranchControlUnit.scala 43:28]
    end else if (!(io_keep)) begin // @[BranchControlUnit.scala 48:17]
      if (2'h0 == needAdd_0) begin // @[BranchControlUnit.scala 53:22]
        if (io_isJump | io_isBType) begin // @[BranchControlUnit.scala 58:39]
          needAdd_1 <= io_idPC; // @[BranchControlUnit.scala 60:23]
        end
      end else if (2'h1 == needAdd_0) begin // @[BranchControlUnit.scala 53:22]
        needAdd_1 <= _GEN_5;
      end else begin
        needAdd_1 <= _GEN_14;
      end
    end
    if (reset) begin // @[BranchControlUnit.scala 44:25]
      flushReg <= 1'h0; // @[BranchControlUnit.scala 44:25]
    end else if (io_keep) begin // @[BranchControlUnit.scala 48:17]
      flushReg <= 1'h0; // @[BranchControlUnit.scala 50:14]
    end else if (2'h0 == needAdd_0) begin // @[BranchControlUnit.scala 53:22]
      flushReg <= _T_1;
    end else begin
      flushReg <= 2'h1 == needAdd_0 | _GEN_13;
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
  _RAND_0 = {1{`RANDOM}};
  needAdd_0 = _RAND_0[1:0];
  _RAND_1 = {2{`RANDOM}};
  needAdd_1 = _RAND_1[63:0];
  _RAND_2 = {1{`RANDOM}};
  flushReg = _RAND_2[0:0];
`endif // RANDOMIZE_REG_INIT
  `endif // RANDOMIZE
end // initial
`ifdef FIRRTL_AFTER_INITIAL
`FIRRTL_AFTER_INITIAL
`endif
`endif // SYNTHESIS
endmodule
module DataForwardingUnit(
  input         clock,
  input         reset,
  input         io_inWriteEnable,
  input  [4:0]  io_inRd,
  input  [63:0] io_inData,
  input         io_pcRs1ToAlu,
  input  [4:0]  io_rs1,
  input         io_memWrite,
  input         io_immRs2ToAlu,
  input  [4:0]  io_rs2,
  input         io_exeWriteEnable,
  input  [4:0]  io_exeRd,
  input         io_memWriteEnable,
  input  [4:0]  io_memRd,
  input         io_exeIsJump,
  input         io_exeImmALUToReg,
  input         io_exeMemRead,
  input  [63:0] io_exeALUResult,
  input  [63:0] io_exeImm,
  input         io_memIsJump,
  input         io_memImmALUToReg,
  input         io_memMemRead,
  input  [63:0] io_memReadData,
  input  [63:0] io_memALUResult,
  input  [63:0] io_memImm,
  input  [63:0] io_exePC,
  input  [63:0] io_memPC,
  output        io_writeEnable,
  output [4:0]  io_rd,
  output [63:0] io_data,
  output        io_keep,
  output        io_stall,
  output        io_flush,
  output        io_forwardRs1,
  output        io_forwardRs2,
  output [63:0] io_forwardData1,
  output [63:0] io_forwardData2
);
`ifdef RANDOMIZE_REG_INIT
  reg [31:0] _RAND_0;
  reg [63:0] _RAND_1;
  reg [31:0] _RAND_2;
  reg [31:0] _RAND_3;
`endif // RANDOMIZE_REG_INIT
  reg  needAdd_0; // @[DataForwardingUnit.scala 75:25]
  reg [63:0] needAdd_1; // @[DataForwardingUnit.scala 76:28]
  reg  ifNeedRs1; // @[DataForwardingUnit.scala 77:26]
  reg  ifNeedRs2; // @[DataForwardingUnit.scala 78:26]
  wire [4:0] useRs1 = ~io_pcRs1ToAlu ? io_rs1 : 5'h0; // @[DataForwardingUnit.scala 96:{35,44}]
  wire [4:0] useRs2 = ~io_immRs2ToAlu | io_memWrite ? io_rs2 : 5'h0; // @[DataForwardingUnit.scala 97:62 98:12]
  wire [4:0] exeWriteRd = io_exeWriteEnable ? io_exeRd : 5'h0; // @[DataForwardingUnit.scala 100:{38,51}]
  wire [4:0] memWriteRd = io_memWriteEnable ? io_memRd : 5'h0; // @[DataForwardingUnit.scala 101:{38,51}]
  wire  _ifRS1EXE_T = exeWriteRd != 5'h0; // @[DataForwardingUnit.scala 104:17]
  wire  ifRS1EXE = exeWriteRd != 5'h0 & useRs1 == exeWriteRd; // @[DataForwardingUnit.scala 104:26]
  wire  ifRS2EXE = _ifRS1EXE_T & useRs2 == exeWriteRd; // @[DataForwardingUnit.scala 106:26]
  wire  _ifRS1MEM_T = memWriteRd != 5'h0; // @[DataForwardingUnit.scala 109:17]
  wire  ifRS1MEM = memWriteRd != 5'h0 & useRs1 == memWriteRd; // @[DataForwardingUnit.scala 109:26]
  wire  ifRS2MEM = _ifRS1MEM_T & useRs2 == memWriteRd; // @[DataForwardingUnit.scala 111:26]
  wire [63:0] _exeResWire_T_1 = io_exePC + 64'h4; // @[DataForwardingUnit.scala 115:28]
  wire [63:0] _GEN_4 = io_exeImmALUToReg ? io_exeImm : io_exeALUResult; // @[DataForwardingUnit.scala 116:44 117:16]
  wire [63:0] exeResWire = io_exeIsJump ? _exeResWire_T_1 : _GEN_4; // @[DataForwardingUnit.scala 114:33 115:16]
  wire [63:0] _memResWire_T_1 = io_memPC + 64'h4; // @[DataForwardingUnit.scala 124:28]
  wire [63:0] _GEN_6 = io_memImmALUToReg ? io_memImm : io_memALUResult; // @[DataForwardingUnit.scala 125:44 126:16]
  wire [63:0] _GEN_7 = io_memIsJump ? _memResWire_T_1 : _GEN_6; // @[DataForwardingUnit.scala 123:39 124:16]
  wire [63:0] memResWire = io_memMemRead ? io_memReadData : _GEN_7; // @[DataForwardingUnit.scala 121:34 122:16]
  wire [63:0] _GEN_10 = io_exeMemRead ? io_exePC : needAdd_1; // @[DataForwardingUnit.scala 139:40 141:23 76:28]
  wire  _GEN_11 = io_exeMemRead | needAdd_0; // @[DataForwardingUnit.scala 139:40 144:20 75:25]
  wire [63:0] _GEN_12 = io_exeMemRead ? 64'h0 : exeResWire; // @[DataForwardingUnit.scala 139:40 147:24]
  wire  _GEN_13 = io_exeMemRead ? 1'h0 : 1'h1; // @[DataForwardingUnit.scala 139:40 148:22]
  wire [63:0] _GEN_14 = ifRS1MEM ? memResWire : 64'h0; // @[DataForwardingUnit.scala 151:35 152:24]
  wire  _GEN_16 = ifRS1EXE & io_exeMemRead; // @[DataForwardingUnit.scala 135:17 138:33]
  wire [63:0] _GEN_17 = ifRS1EXE ? _GEN_10 : needAdd_1; // @[DataForwardingUnit.scala 138:33 76:28]
  wire  _GEN_18 = ifRS1EXE ? _GEN_11 : needAdd_0; // @[DataForwardingUnit.scala 138:33 75:25]
  wire [63:0] _GEN_19 = ifRS1EXE ? _GEN_12 : _GEN_14; // @[DataForwardingUnit.scala 138:33]
  wire  _GEN_20 = ifRS1EXE ? _GEN_13 : ifRS1MEM; // @[DataForwardingUnit.scala 138:33]
  wire  _GEN_23 = io_exeMemRead | _GEN_16; // @[DataForwardingUnit.scala 158:40 161:16]
  wire  _GEN_24 = io_exeMemRead | _GEN_18; // @[DataForwardingUnit.scala 158:40 163:20]
  wire [63:0] _GEN_27 = ifRS2MEM ? memResWire : 64'h0; // @[DataForwardingUnit.scala 170:35 171:24]
  wire  _GEN_29 = ifRS2EXE & io_exeMemRead; // @[DataForwardingUnit.scala 136:17 157:33]
  wire  _GEN_31 = ifRS2EXE ? _GEN_23 : _GEN_16; // @[DataForwardingUnit.scala 157:33]
  wire [63:0] _GEN_33 = ifRS2EXE ? _GEN_12 : _GEN_27; // @[DataForwardingUnit.scala 157:33]
  wire  _GEN_34 = ifRS2EXE ? _GEN_13 : ifRS2MEM; // @[DataForwardingUnit.scala 157:33]
  wire [63:0] _GEN_35 = ifNeedRs1 ? memResWire : 64'h0; // @[DataForwardingUnit.scala 183:36 184:24]
  wire [63:0] _GEN_37 = ifNeedRs2 ? memResWire : 64'h0; // @[DataForwardingUnit.scala 187:36 188:24]
  wire [63:0] _GEN_39 = io_memPC == needAdd_1 ? _GEN_35 : 64'h0; // @[DataForwardingUnit.scala 182:38]
  wire  _GEN_40 = io_memPC == needAdd_1 & ifNeedRs1; // @[DataForwardingUnit.scala 182:38]
  wire [63:0] _GEN_41 = io_memPC == needAdd_1 ? _GEN_37 : 64'h0; // @[DataForwardingUnit.scala 182:38]
  wire  _GEN_42 = io_memPC == needAdd_1 & ifNeedRs2; // @[DataForwardingUnit.scala 182:38]
  wire  _GEN_44 = io_memPC == needAdd_1 ? 1'h0 : 1'h1; // @[DataForwardingUnit.scala 178:12 182:38 193:14]
  wire [63:0] _GEN_48 = needAdd_0 ? _GEN_39 : 64'h0; // @[DataForwardingUnit.scala 130:20]
  wire [63:0] _GEN_50 = needAdd_0 ? _GEN_41 : 64'h0; // @[DataForwardingUnit.scala 130:20]
  assign io_writeEnable = io_inWriteEnable; // @[DataForwardingUnit.scala 210:18]
  assign io_rd = io_inRd; // @[DataForwardingUnit.scala 211:9]
  assign io_data = io_inData; // @[DataForwardingUnit.scala 212:11]
  assign io_keep = ~needAdd_0 ? _GEN_31 : needAdd_0 & _GEN_44; // @[DataForwardingUnit.scala 130:20]
  assign io_stall = ~needAdd_0 ? _GEN_31 : needAdd_0 & _GEN_44; // @[DataForwardingUnit.scala 130:20]
  assign io_flush = ~needAdd_0 ? 1'h0 : needAdd_0; // @[DataForwardingUnit.scala 130:20 134:13]
  assign io_forwardRs1 = ~needAdd_0 ? _GEN_20 : needAdd_0 & _GEN_40; // @[DataForwardingUnit.scala 130:20]
  assign io_forwardRs2 = ~needAdd_0 ? _GEN_34 : needAdd_0 & _GEN_42; // @[DataForwardingUnit.scala 130:20]
  assign io_forwardData1 = ~needAdd_0 ? _GEN_19 : _GEN_48; // @[DataForwardingUnit.scala 130:20]
  assign io_forwardData2 = ~needAdd_0 ? _GEN_33 : _GEN_50; // @[DataForwardingUnit.scala 130:20]
  always @(posedge clock) begin
    if (reset) begin // @[DataForwardingUnit.scala 75:25]
      needAdd_0 <= 1'h0; // @[DataForwardingUnit.scala 75:25]
    end else if (~needAdd_0) begin // @[DataForwardingUnit.scala 130:20]
      if (ifRS2EXE) begin // @[DataForwardingUnit.scala 157:33]
        needAdd_0 <= _GEN_24;
      end else if (ifRS1EXE) begin // @[DataForwardingUnit.scala 138:33]
        needAdd_0 <= _GEN_11;
      end
    end else if (needAdd_0) begin // @[DataForwardingUnit.scala 130:20]
      if (io_memPC == needAdd_1) begin // @[DataForwardingUnit.scala 182:38]
        needAdd_0 <= 1'h0; // @[DataForwardingUnit.scala 195:18]
      end
    end
    if (reset) begin // @[DataForwardingUnit.scala 76:28]
      needAdd_1 <= 64'h0; // @[DataForwardingUnit.scala 76:28]
    end else if (~needAdd_0) begin // @[DataForwardingUnit.scala 130:20]
      if (ifRS2EXE) begin // @[DataForwardingUnit.scala 157:33]
        if (io_exeMemRead) begin // @[DataForwardingUnit.scala 158:40]
          needAdd_1 <= io_exePC; // @[DataForwardingUnit.scala 160:23]
        end else begin
          needAdd_1 <= _GEN_17;
        end
      end else begin
        needAdd_1 <= _GEN_17;
      end
    end else if (needAdd_0) begin // @[DataForwardingUnit.scala 130:20]
      if (io_memPC == needAdd_1) begin // @[DataForwardingUnit.scala 182:38]
        needAdd_1 <= 64'h0; // @[DataForwardingUnit.scala 192:21]
      end
    end
    if (reset) begin // @[DataForwardingUnit.scala 77:26]
      ifNeedRs1 <= 1'h0; // @[DataForwardingUnit.scala 77:26]
    end else if (~needAdd_0) begin // @[DataForwardingUnit.scala 130:20]
      ifNeedRs1 <= _GEN_16;
    end
    if (reset) begin // @[DataForwardingUnit.scala 78:26]
      ifNeedRs2 <= 1'h0; // @[DataForwardingUnit.scala 78:26]
    end else if (~needAdd_0) begin // @[DataForwardingUnit.scala 130:20]
      ifNeedRs2 <= _GEN_29;
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
  _RAND_0 = {1{`RANDOM}};
  needAdd_0 = _RAND_0[0:0];
  _RAND_1 = {2{`RANDOM}};
  needAdd_1 = _RAND_1[63:0];
  _RAND_2 = {1{`RANDOM}};
  ifNeedRs1 = _RAND_2[0:0];
  _RAND_3 = {1{`RANDOM}};
  ifNeedRs2 = _RAND_3[0:0];
`endif // RANDOMIZE_REG_INIT
  `endif // RANDOMIZE
end // initial
`ifdef FIRRTL_AFTER_INITIAL
`FIRRTL_AFTER_INITIAL
`endif
`endif // SYNTHESIS
endmodule
module PiplineCPUwithForwarding(
  input         clock,
  input         reset,
  output        io_isValidInst,
  output [63:0] io_ifPC,
  output [31:0] io_ifInst,
  output [63:0] io_idPC,
  output [31:0] io_idInst,
  output [63:0] io_exePC,
  output [31:0] io_exeInst,
  output [63:0] io_memPC,
  output [31:0] io_memInst,
  output [63:0] io_wbPC,
  output [31:0] io_wbInst,
  output [63:0] io_nextPC,
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
  output [63:0] io_address,
  output [63:0] io_writeData,
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
  wire  pcReg_clock; // @[PiplineCPUGeneral.scala 89:21]
  wire  pcReg_reset; // @[PiplineCPUGeneral.scala 89:21]
  wire [63:0] pcReg_io_in; // @[PiplineCPUGeneral.scala 89:21]
  wire [63:0] pcReg_io_out; // @[PiplineCPUGeneral.scala 89:21]
  wire  instMemory_clock; // @[PiplineCPUGeneral.scala 90:26]
  wire [63:0] instMemory_io_address; // @[PiplineCPUGeneral.scala 90:26]
  wire [31:0] instMemory_io_inst; // @[PiplineCPUGeneral.scala 90:26]
  wire [6:0] controlUnit_io_opcode; // @[PiplineCPUGeneral.scala 91:27]
  wire  controlUnit_io_isJALR; // @[PiplineCPUGeneral.scala 91:27]
  wire  controlUnit_io_isBType; // @[PiplineCPUGeneral.scala 91:27]
  wire  controlUnit_io_isJump; // @[PiplineCPUGeneral.scala 91:27]
  wire  controlUnit_io_immALUToReg; // @[PiplineCPUGeneral.scala 91:27]
  wire  controlUnit_io_memRead; // @[PiplineCPUGeneral.scala 91:27]
  wire  controlUnit_io_memWrite; // @[PiplineCPUGeneral.scala 91:27]
  wire  controlUnit_io_immRs2ToALU; // @[PiplineCPUGeneral.scala 91:27]
  wire  controlUnit_io_pcRs1ToALU; // @[PiplineCPUGeneral.scala 91:27]
  wire  controlUnit_io_isIType; // @[PiplineCPUGeneral.scala 91:27]
  wire  controlUnit_io_isRType; // @[PiplineCPUGeneral.scala 91:27]
  wire  controlUnit_io_isWord; // @[PiplineCPUGeneral.scala 91:27]
  wire  controlUnit_io_ifWriteToReg; // @[PiplineCPUGeneral.scala 91:27]
  wire  controlUnit_io_isValidInst; // @[PiplineCPUGeneral.scala 91:27]
  wire [31:0] inst2ImmUnit_io_inst; // @[PiplineCPUGeneral.scala 92:28]
  wire [63:0] inst2ImmUnit_io_imm; // @[PiplineCPUGeneral.scala 92:28]
  wire  regUnit_clock; // @[PiplineCPUGeneral.scala 93:23]
  wire  regUnit_reset; // @[PiplineCPUGeneral.scala 93:23]
  wire [4:0] regUnit_io_rs1; // @[PiplineCPUGeneral.scala 93:23]
  wire [4:0] regUnit_io_rs2; // @[PiplineCPUGeneral.scala 93:23]
  wire [4:0] regUnit_io_rd; // @[PiplineCPUGeneral.scala 93:23]
  wire  regUnit_io_writeEnable; // @[PiplineCPUGeneral.scala 93:23]
  wire [63:0] regUnit_io_writeData; // @[PiplineCPUGeneral.scala 93:23]
  wire [63:0] regUnit_io_readDataRs1; // @[PiplineCPUGeneral.scala 93:23]
  wire [63:0] regUnit_io_readDataRs2; // @[PiplineCPUGeneral.scala 93:23]
  wire [63:0] regUnit_io_regAll_1; // @[PiplineCPUGeneral.scala 93:23]
  wire [63:0] regUnit_io_regAll_2; // @[PiplineCPUGeneral.scala 93:23]
  wire [63:0] regUnit_io_regAll_3; // @[PiplineCPUGeneral.scala 93:23]
  wire [63:0] regUnit_io_regAll_4; // @[PiplineCPUGeneral.scala 93:23]
  wire [63:0] regUnit_io_regAll_5; // @[PiplineCPUGeneral.scala 93:23]
  wire [63:0] regUnit_io_regAll_6; // @[PiplineCPUGeneral.scala 93:23]
  wire [63:0] regUnit_io_regAll_7; // @[PiplineCPUGeneral.scala 93:23]
  wire [63:0] regUnit_io_regAll_8; // @[PiplineCPUGeneral.scala 93:23]
  wire [63:0] regUnit_io_regAll_9; // @[PiplineCPUGeneral.scala 93:23]
  wire [63:0] regUnit_io_regAll_10; // @[PiplineCPUGeneral.scala 93:23]
  wire [63:0] regUnit_io_regAll_11; // @[PiplineCPUGeneral.scala 93:23]
  wire [63:0] regUnit_io_regAll_12; // @[PiplineCPUGeneral.scala 93:23]
  wire [63:0] regUnit_io_regAll_13; // @[PiplineCPUGeneral.scala 93:23]
  wire [63:0] regUnit_io_regAll_14; // @[PiplineCPUGeneral.scala 93:23]
  wire [63:0] regUnit_io_regAll_15; // @[PiplineCPUGeneral.scala 93:23]
  wire [63:0] regUnit_io_regAll_16; // @[PiplineCPUGeneral.scala 93:23]
  wire [63:0] regUnit_io_regAll_17; // @[PiplineCPUGeneral.scala 93:23]
  wire [63:0] regUnit_io_regAll_18; // @[PiplineCPUGeneral.scala 93:23]
  wire [63:0] regUnit_io_regAll_19; // @[PiplineCPUGeneral.scala 93:23]
  wire [63:0] regUnit_io_regAll_20; // @[PiplineCPUGeneral.scala 93:23]
  wire [63:0] regUnit_io_regAll_21; // @[PiplineCPUGeneral.scala 93:23]
  wire [63:0] regUnit_io_regAll_22; // @[PiplineCPUGeneral.scala 93:23]
  wire [63:0] regUnit_io_regAll_23; // @[PiplineCPUGeneral.scala 93:23]
  wire [63:0] regUnit_io_regAll_24; // @[PiplineCPUGeneral.scala 93:23]
  wire [63:0] regUnit_io_regAll_25; // @[PiplineCPUGeneral.scala 93:23]
  wire [63:0] regUnit_io_regAll_26; // @[PiplineCPUGeneral.scala 93:23]
  wire [63:0] regUnit_io_regAll_27; // @[PiplineCPUGeneral.scala 93:23]
  wire [63:0] regUnit_io_regAll_28; // @[PiplineCPUGeneral.scala 93:23]
  wire [63:0] regUnit_io_regAll_29; // @[PiplineCPUGeneral.scala 93:23]
  wire [63:0] regUnit_io_regAll_30; // @[PiplineCPUGeneral.scala 93:23]
  wire [63:0] regUnit_io_regAll_31; // @[PiplineCPUGeneral.scala 93:23]
  wire  aluControlUnit_io_isBType; // @[PiplineCPUGeneral.scala 94:30]
  wire  aluControlUnit_io_isIType; // @[PiplineCPUGeneral.scala 94:30]
  wire  aluControlUnit_io_isRType; // @[PiplineCPUGeneral.scala 94:30]
  wire  aluControlUnit_io_isWord; // @[PiplineCPUGeneral.scala 94:30]
  wire [2:0] aluControlUnit_io_funct3; // @[PiplineCPUGeneral.scala 94:30]
  wire [6:0] aluControlUnit_io_funct7; // @[PiplineCPUGeneral.scala 94:30]
  wire [5:0] aluControlUnit_io_aluOperation; // @[PiplineCPUGeneral.scala 94:30]
  wire [63:0] pcSelectUnit_io_pcPlus4; // @[PiplineCPUGeneral.scala 95:28]
  wire [63:0] pcSelectUnit_io_pcPlusImm; // @[PiplineCPUGeneral.scala 95:28]
  wire  pcSelectUnit_io_isJALR; // @[PiplineCPUGeneral.scala 95:28]
  wire  pcSelectUnit_io_isBType; // @[PiplineCPUGeneral.scala 95:28]
  wire  pcSelectUnit_io_isJump; // @[PiplineCPUGeneral.scala 95:28]
  wire  pcSelectUnit_io_isTrue; // @[PiplineCPUGeneral.scala 95:28]
  wire [63:0] pcSelectUnit_io_aluResult; // @[PiplineCPUGeneral.scala 95:28]
  wire [63:0] pcSelectUnit_io_nextPC; // @[PiplineCPUGeneral.scala 95:28]
  wire [5:0] alu_io_aluOperation; // @[PiplineCPUGeneral.scala 96:19]
  wire [63:0] alu_io_x; // @[PiplineCPUGeneral.scala 96:19]
  wire [63:0] alu_io_y; // @[PiplineCPUGeneral.scala 96:19]
  wire [63:0] alu_io_result; // @[PiplineCPUGeneral.scala 96:19]
  wire  dataMemory_clock; // @[PiplineCPUGeneral.scala 97:26]
  wire  dataMemory_io_memRead; // @[PiplineCPUGeneral.scala 97:26]
  wire  dataMemory_io_memWrite; // @[PiplineCPUGeneral.scala 97:26]
  wire [63:0] dataMemory_io_address; // @[PiplineCPUGeneral.scala 97:26]
  wire [63:0] dataMemory_io_writeData; // @[PiplineCPUGeneral.scala 97:26]
  wire [1:0] dataMemory_io_bitType; // @[PiplineCPUGeneral.scala 97:26]
  wire  dataMemory_io_isUnsigned; // @[PiplineCPUGeneral.scala 97:26]
  wire [63:0] dataMemory_io_readData; // @[PiplineCPUGeneral.scala 97:26]
  wire  resSelectUnit_io_isJump; // @[PiplineCPUGeneral.scala 98:29]
  wire  resSelectUnit_io_immALUToReg; // @[PiplineCPUGeneral.scala 98:29]
  wire  resSelectUnit_io_memRead; // @[PiplineCPUGeneral.scala 98:29]
  wire [63:0] resSelectUnit_io_readData; // @[PiplineCPUGeneral.scala 98:29]
  wire [63:0] resSelectUnit_io_aluResult; // @[PiplineCPUGeneral.scala 98:29]
  wire [63:0] resSelectUnit_io_imm; // @[PiplineCPUGeneral.scala 98:29]
  wire [63:0] resSelectUnit_io_pcPlus4; // @[PiplineCPUGeneral.scala 98:29]
  wire [63:0] resSelectUnit_io_out; // @[PiplineCPUGeneral.scala 98:29]
  wire  ifIDStageRegs_clock; // @[PiplineCPUGeneral.scala 100:29]
  wire  ifIDStageRegs_reset; // @[PiplineCPUGeneral.scala 100:29]
  wire  ifIDStageRegs_io_stall; // @[PiplineCPUGeneral.scala 100:29]
  wire  ifIDStageRegs_io_flush; // @[PiplineCPUGeneral.scala 100:29]
  wire [63:0] ifIDStageRegs_io_in_pc; // @[PiplineCPUGeneral.scala 100:29]
  wire [31:0] ifIDStageRegs_io_in_inst; // @[PiplineCPUGeneral.scala 100:29]
  wire [63:0] ifIDStageRegs_io_out_pc; // @[PiplineCPUGeneral.scala 100:29]
  wire [31:0] ifIDStageRegs_io_out_inst; // @[PiplineCPUGeneral.scala 100:29]
  wire  idEXEStageRegs_clock; // @[PiplineCPUGeneral.scala 101:30]
  wire  idEXEStageRegs_reset; // @[PiplineCPUGeneral.scala 101:30]
  wire  idEXEStageRegs_io_flush; // @[PiplineCPUGeneral.scala 101:30]
  wire [63:0] idEXEStageRegs_io_in_pc; // @[PiplineCPUGeneral.scala 101:30]
  wire [31:0] idEXEStageRegs_io_in_inst; // @[PiplineCPUGeneral.scala 101:30]
  wire  idEXEStageRegs_io_in_isJALR; // @[PiplineCPUGeneral.scala 101:30]
  wire  idEXEStageRegs_io_in_isBType; // @[PiplineCPUGeneral.scala 101:30]
  wire  idEXEStageRegs_io_in_isJump; // @[PiplineCPUGeneral.scala 101:30]
  wire  idEXEStageRegs_io_in_immALUToReg; // @[PiplineCPUGeneral.scala 101:30]
  wire  idEXEStageRegs_io_in_memRead; // @[PiplineCPUGeneral.scala 101:30]
  wire  idEXEStageRegs_io_in_memWrite; // @[PiplineCPUGeneral.scala 101:30]
  wire  idEXEStageRegs_io_in_writeEnable; // @[PiplineCPUGeneral.scala 101:30]
  wire [5:0] idEXEStageRegs_io_in_aluOperation; // @[PiplineCPUGeneral.scala 101:30]
  wire [63:0] idEXEStageRegs_io_in_readDataRs2; // @[PiplineCPUGeneral.scala 101:30]
  wire [4:0] idEXEStageRegs_io_in_rd; // @[PiplineCPUGeneral.scala 101:30]
  wire [63:0] idEXEStageRegs_io_in_aluX; // @[PiplineCPUGeneral.scala 101:30]
  wire [63:0] idEXEStageRegs_io_in_aluY; // @[PiplineCPUGeneral.scala 101:30]
  wire [63:0] idEXEStageRegs_io_in_imm; // @[PiplineCPUGeneral.scala 101:30]
  wire [63:0] idEXEStageRegs_io_out_pc; // @[PiplineCPUGeneral.scala 101:30]
  wire [31:0] idEXEStageRegs_io_out_inst; // @[PiplineCPUGeneral.scala 101:30]
  wire  idEXEStageRegs_io_out_isJALR; // @[PiplineCPUGeneral.scala 101:30]
  wire  idEXEStageRegs_io_out_isBType; // @[PiplineCPUGeneral.scala 101:30]
  wire  idEXEStageRegs_io_out_isJump; // @[PiplineCPUGeneral.scala 101:30]
  wire  idEXEStageRegs_io_out_immALUToReg; // @[PiplineCPUGeneral.scala 101:30]
  wire  idEXEStageRegs_io_out_memRead; // @[PiplineCPUGeneral.scala 101:30]
  wire  idEXEStageRegs_io_out_memWrite; // @[PiplineCPUGeneral.scala 101:30]
  wire  idEXEStageRegs_io_out_writeEnable; // @[PiplineCPUGeneral.scala 101:30]
  wire [5:0] idEXEStageRegs_io_out_aluOperation; // @[PiplineCPUGeneral.scala 101:30]
  wire [63:0] idEXEStageRegs_io_out_readDataRs2; // @[PiplineCPUGeneral.scala 101:30]
  wire [4:0] idEXEStageRegs_io_out_rd; // @[PiplineCPUGeneral.scala 101:30]
  wire [63:0] idEXEStageRegs_io_out_aluX; // @[PiplineCPUGeneral.scala 101:30]
  wire [63:0] idEXEStageRegs_io_out_aluY; // @[PiplineCPUGeneral.scala 101:30]
  wire [63:0] idEXEStageRegs_io_out_imm; // @[PiplineCPUGeneral.scala 101:30]
  wire  exeMEMStageRegs_clock; // @[PiplineCPUGeneral.scala 102:31]
  wire  exeMEMStageRegs_reset; // @[PiplineCPUGeneral.scala 102:31]
  wire [63:0] exeMEMStageRegs_io_in_pc; // @[PiplineCPUGeneral.scala 102:31]
  wire [31:0] exeMEMStageRegs_io_in_inst; // @[PiplineCPUGeneral.scala 102:31]
  wire  exeMEMStageRegs_io_in_isJump; // @[PiplineCPUGeneral.scala 102:31]
  wire  exeMEMStageRegs_io_in_immALUToReg; // @[PiplineCPUGeneral.scala 102:31]
  wire  exeMEMStageRegs_io_in_memRead; // @[PiplineCPUGeneral.scala 102:31]
  wire  exeMEMStageRegs_io_in_memWrite; // @[PiplineCPUGeneral.scala 102:31]
  wire  exeMEMStageRegs_io_in_writeEnable; // @[PiplineCPUGeneral.scala 102:31]
  wire [63:0] exeMEMStageRegs_io_in_readDataRs2; // @[PiplineCPUGeneral.scala 102:31]
  wire [4:0] exeMEMStageRegs_io_in_rd; // @[PiplineCPUGeneral.scala 102:31]
  wire [63:0] exeMEMStageRegs_io_in_aluResult; // @[PiplineCPUGeneral.scala 102:31]
  wire [63:0] exeMEMStageRegs_io_in_imm; // @[PiplineCPUGeneral.scala 102:31]
  wire [63:0] exeMEMStageRegs_io_out_pc; // @[PiplineCPUGeneral.scala 102:31]
  wire [31:0] exeMEMStageRegs_io_out_inst; // @[PiplineCPUGeneral.scala 102:31]
  wire  exeMEMStageRegs_io_out_isJump; // @[PiplineCPUGeneral.scala 102:31]
  wire  exeMEMStageRegs_io_out_immALUToReg; // @[PiplineCPUGeneral.scala 102:31]
  wire  exeMEMStageRegs_io_out_memRead; // @[PiplineCPUGeneral.scala 102:31]
  wire  exeMEMStageRegs_io_out_memWrite; // @[PiplineCPUGeneral.scala 102:31]
  wire  exeMEMStageRegs_io_out_writeEnable; // @[PiplineCPUGeneral.scala 102:31]
  wire [63:0] exeMEMStageRegs_io_out_readDataRs2; // @[PiplineCPUGeneral.scala 102:31]
  wire [4:0] exeMEMStageRegs_io_out_rd; // @[PiplineCPUGeneral.scala 102:31]
  wire [63:0] exeMEMStageRegs_io_out_aluResult; // @[PiplineCPUGeneral.scala 102:31]
  wire [63:0] exeMEMStageRegs_io_out_imm; // @[PiplineCPUGeneral.scala 102:31]
  wire  memWBStageRegs_clock; // @[PiplineCPUGeneral.scala 103:30]
  wire  memWBStageRegs_reset; // @[PiplineCPUGeneral.scala 103:30]
  wire [63:0] memWBStageRegs_io_in_pc; // @[PiplineCPUGeneral.scala 103:30]
  wire [31:0] memWBStageRegs_io_in_inst; // @[PiplineCPUGeneral.scala 103:30]
  wire  memWBStageRegs_io_in_isJump; // @[PiplineCPUGeneral.scala 103:30]
  wire  memWBStageRegs_io_in_immALUToReg; // @[PiplineCPUGeneral.scala 103:30]
  wire  memWBStageRegs_io_in_memRead; // @[PiplineCPUGeneral.scala 103:30]
  wire  memWBStageRegs_io_in_writeEnable; // @[PiplineCPUGeneral.scala 103:30]
  wire [63:0] memWBStageRegs_io_in_readData; // @[PiplineCPUGeneral.scala 103:30]
  wire [63:0] memWBStageRegs_io_in_aluResult; // @[PiplineCPUGeneral.scala 103:30]
  wire [63:0] memWBStageRegs_io_in_imm; // @[PiplineCPUGeneral.scala 103:30]
  wire [63:0] memWBStageRegs_io_out_pc; // @[PiplineCPUGeneral.scala 103:30]
  wire [31:0] memWBStageRegs_io_out_inst; // @[PiplineCPUGeneral.scala 103:30]
  wire  memWBStageRegs_io_out_isJump; // @[PiplineCPUGeneral.scala 103:30]
  wire  memWBStageRegs_io_out_immALUToReg; // @[PiplineCPUGeneral.scala 103:30]
  wire  memWBStageRegs_io_out_memRead; // @[PiplineCPUGeneral.scala 103:30]
  wire  memWBStageRegs_io_out_writeEnable; // @[PiplineCPUGeneral.scala 103:30]
  wire [63:0] memWBStageRegs_io_out_readData; // @[PiplineCPUGeneral.scala 103:30]
  wire [63:0] memWBStageRegs_io_out_aluResult; // @[PiplineCPUGeneral.scala 103:30]
  wire [63:0] memWBStageRegs_io_out_imm; // @[PiplineCPUGeneral.scala 103:30]
  wire  branchControlUnit_clock; // @[PiplineCPUwithForwarding.scala 30:33]
  wire  branchControlUnit_reset; // @[PiplineCPUwithForwarding.scala 30:33]
  wire  branchControlUnit_io_keep; // @[PiplineCPUwithForwarding.scala 30:33]
  wire  branchControlUnit_io_isJump; // @[PiplineCPUwithForwarding.scala 30:33]
  wire  branchControlUnit_io_isBType; // @[PiplineCPUwithForwarding.scala 30:33]
  wire [63:0] branchControlUnit_io_ifPC; // @[PiplineCPUwithForwarding.scala 30:33]
  wire [63:0] branchControlUnit_io_idPC; // @[PiplineCPUwithForwarding.scala 30:33]
  wire [63:0] branchControlUnit_io_exePC; // @[PiplineCPUwithForwarding.scala 30:33]
  wire [63:0] branchControlUnit_io_selectPC; // @[PiplineCPUwithForwarding.scala 30:33]
  wire [63:0] branchControlUnit_io_nextPC; // @[PiplineCPUwithForwarding.scala 30:33]
  wire  branchControlUnit_io_flush; // @[PiplineCPUwithForwarding.scala 30:33]
  wire  dataForwardingUnit_clock; // @[PiplineCPUwithForwarding.scala 31:34]
  wire  dataForwardingUnit_reset; // @[PiplineCPUwithForwarding.scala 31:34]
  wire  dataForwardingUnit_io_inWriteEnable; // @[PiplineCPUwithForwarding.scala 31:34]
  wire [4:0] dataForwardingUnit_io_inRd; // @[PiplineCPUwithForwarding.scala 31:34]
  wire [63:0] dataForwardingUnit_io_inData; // @[PiplineCPUwithForwarding.scala 31:34]
  wire  dataForwardingUnit_io_pcRs1ToAlu; // @[PiplineCPUwithForwarding.scala 31:34]
  wire [4:0] dataForwardingUnit_io_rs1; // @[PiplineCPUwithForwarding.scala 31:34]
  wire  dataForwardingUnit_io_memWrite; // @[PiplineCPUwithForwarding.scala 31:34]
  wire  dataForwardingUnit_io_immRs2ToAlu; // @[PiplineCPUwithForwarding.scala 31:34]
  wire [4:0] dataForwardingUnit_io_rs2; // @[PiplineCPUwithForwarding.scala 31:34]
  wire  dataForwardingUnit_io_exeWriteEnable; // @[PiplineCPUwithForwarding.scala 31:34]
  wire [4:0] dataForwardingUnit_io_exeRd; // @[PiplineCPUwithForwarding.scala 31:34]
  wire  dataForwardingUnit_io_memWriteEnable; // @[PiplineCPUwithForwarding.scala 31:34]
  wire [4:0] dataForwardingUnit_io_memRd; // @[PiplineCPUwithForwarding.scala 31:34]
  wire  dataForwardingUnit_io_exeIsJump; // @[PiplineCPUwithForwarding.scala 31:34]
  wire  dataForwardingUnit_io_exeImmALUToReg; // @[PiplineCPUwithForwarding.scala 31:34]
  wire  dataForwardingUnit_io_exeMemRead; // @[PiplineCPUwithForwarding.scala 31:34]
  wire [63:0] dataForwardingUnit_io_exeALUResult; // @[PiplineCPUwithForwarding.scala 31:34]
  wire [63:0] dataForwardingUnit_io_exeImm; // @[PiplineCPUwithForwarding.scala 31:34]
  wire  dataForwardingUnit_io_memIsJump; // @[PiplineCPUwithForwarding.scala 31:34]
  wire  dataForwardingUnit_io_memImmALUToReg; // @[PiplineCPUwithForwarding.scala 31:34]
  wire  dataForwardingUnit_io_memMemRead; // @[PiplineCPUwithForwarding.scala 31:34]
  wire [63:0] dataForwardingUnit_io_memReadData; // @[PiplineCPUwithForwarding.scala 31:34]
  wire [63:0] dataForwardingUnit_io_memALUResult; // @[PiplineCPUwithForwarding.scala 31:34]
  wire [63:0] dataForwardingUnit_io_memImm; // @[PiplineCPUwithForwarding.scala 31:34]
  wire [63:0] dataForwardingUnit_io_exePC; // @[PiplineCPUwithForwarding.scala 31:34]
  wire [63:0] dataForwardingUnit_io_memPC; // @[PiplineCPUwithForwarding.scala 31:34]
  wire  dataForwardingUnit_io_writeEnable; // @[PiplineCPUwithForwarding.scala 31:34]
  wire [4:0] dataForwardingUnit_io_rd; // @[PiplineCPUwithForwarding.scala 31:34]
  wire [63:0] dataForwardingUnit_io_data; // @[PiplineCPUwithForwarding.scala 31:34]
  wire  dataForwardingUnit_io_keep; // @[PiplineCPUwithForwarding.scala 31:34]
  wire  dataForwardingUnit_io_stall; // @[PiplineCPUwithForwarding.scala 31:34]
  wire  dataForwardingUnit_io_flush; // @[PiplineCPUwithForwarding.scala 31:34]
  wire  dataForwardingUnit_io_forwardRs1; // @[PiplineCPUwithForwarding.scala 31:34]
  wire  dataForwardingUnit_io_forwardRs2; // @[PiplineCPUwithForwarding.scala 31:34]
  wire [63:0] dataForwardingUnit_io_forwardData1; // @[PiplineCPUwithForwarding.scala 31:34]
  wire [63:0] dataForwardingUnit_io_forwardData2; // @[PiplineCPUwithForwarding.scala 31:34]
  wire [63:0] readDataRs1 = dataForwardingUnit_io_forwardRs1 ? dataForwardingUnit_io_forwardData1 :
    regUnit_io_readDataRs1; // @[PiplineCPUwithForwarding.scala 35:24]
  wire [63:0] readDataRs2 = dataForwardingUnit_io_forwardRs2 ? dataForwardingUnit_io_forwardData2 :
    regUnit_io_readDataRs2; // @[PiplineCPUwithForwarding.scala 40:24]
  PCReg pcReg ( // @[PiplineCPUGeneral.scala 89:21]
    .clock(pcReg_clock),
    .reset(pcReg_reset),
    .io_in(pcReg_io_in),
    .io_out(pcReg_io_out)
  );
  InstMemory instMemory ( // @[PiplineCPUGeneral.scala 90:26]
    .clock(instMemory_clock),
    .io_address(instMemory_io_address),
    .io_inst(instMemory_io_inst)
  );
  ControlUnit controlUnit ( // @[PiplineCPUGeneral.scala 91:27]
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
  Inst2ImmUnit inst2ImmUnit ( // @[PiplineCPUGeneral.scala 92:28]
    .io_inst(inst2ImmUnit_io_inst),
    .io_imm(inst2ImmUnit_io_imm)
  );
  RegUnitWithForwarding regUnit ( // @[PiplineCPUGeneral.scala 93:23]
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
  ALUControlUnit aluControlUnit ( // @[PiplineCPUGeneral.scala 94:30]
    .io_isBType(aluControlUnit_io_isBType),
    .io_isIType(aluControlUnit_io_isIType),
    .io_isRType(aluControlUnit_io_isRType),
    .io_isWord(aluControlUnit_io_isWord),
    .io_funct3(aluControlUnit_io_funct3),
    .io_funct7(aluControlUnit_io_funct7),
    .io_aluOperation(aluControlUnit_io_aluOperation)
  );
  PCSelectUnit pcSelectUnit ( // @[PiplineCPUGeneral.scala 95:28]
    .io_pcPlus4(pcSelectUnit_io_pcPlus4),
    .io_pcPlusImm(pcSelectUnit_io_pcPlusImm),
    .io_isJALR(pcSelectUnit_io_isJALR),
    .io_isBType(pcSelectUnit_io_isBType),
    .io_isJump(pcSelectUnit_io_isJump),
    .io_isTrue(pcSelectUnit_io_isTrue),
    .io_aluResult(pcSelectUnit_io_aluResult),
    .io_nextPC(pcSelectUnit_io_nextPC)
  );
  ALU alu ( // @[PiplineCPUGeneral.scala 96:19]
    .io_aluOperation(alu_io_aluOperation),
    .io_x(alu_io_x),
    .io_y(alu_io_y),
    .io_result(alu_io_result)
  );
  DataMemory dataMemory ( // @[PiplineCPUGeneral.scala 97:26]
    .clock(dataMemory_clock),
    .io_memRead(dataMemory_io_memRead),
    .io_memWrite(dataMemory_io_memWrite),
    .io_address(dataMemory_io_address),
    .io_writeData(dataMemory_io_writeData),
    .io_bitType(dataMemory_io_bitType),
    .io_isUnsigned(dataMemory_io_isUnsigned),
    .io_readData(dataMemory_io_readData)
  );
  ResSelectUnit resSelectUnit ( // @[PiplineCPUGeneral.scala 98:29]
    .io_isJump(resSelectUnit_io_isJump),
    .io_immALUToReg(resSelectUnit_io_immALUToReg),
    .io_memRead(resSelectUnit_io_memRead),
    .io_readData(resSelectUnit_io_readData),
    .io_aluResult(resSelectUnit_io_aluResult),
    .io_imm(resSelectUnit_io_imm),
    .io_pcPlus4(resSelectUnit_io_pcPlus4),
    .io_out(resSelectUnit_io_out)
  );
  IFIDStageRegs ifIDStageRegs ( // @[PiplineCPUGeneral.scala 100:29]
    .clock(ifIDStageRegs_clock),
    .reset(ifIDStageRegs_reset),
    .io_stall(ifIDStageRegs_io_stall),
    .io_flush(ifIDStageRegs_io_flush),
    .io_in_pc(ifIDStageRegs_io_in_pc),
    .io_in_inst(ifIDStageRegs_io_in_inst),
    .io_out_pc(ifIDStageRegs_io_out_pc),
    .io_out_inst(ifIDStageRegs_io_out_inst)
  );
  IDEXEStageRegs idEXEStageRegs ( // @[PiplineCPUGeneral.scala 101:30]
    .clock(idEXEStageRegs_clock),
    .reset(idEXEStageRegs_reset),
    .io_flush(idEXEStageRegs_io_flush),
    .io_in_pc(idEXEStageRegs_io_in_pc),
    .io_in_inst(idEXEStageRegs_io_in_inst),
    .io_in_isJALR(idEXEStageRegs_io_in_isJALR),
    .io_in_isBType(idEXEStageRegs_io_in_isBType),
    .io_in_isJump(idEXEStageRegs_io_in_isJump),
    .io_in_immALUToReg(idEXEStageRegs_io_in_immALUToReg),
    .io_in_memRead(idEXEStageRegs_io_in_memRead),
    .io_in_memWrite(idEXEStageRegs_io_in_memWrite),
    .io_in_writeEnable(idEXEStageRegs_io_in_writeEnable),
    .io_in_aluOperation(idEXEStageRegs_io_in_aluOperation),
    .io_in_readDataRs2(idEXEStageRegs_io_in_readDataRs2),
    .io_in_rd(idEXEStageRegs_io_in_rd),
    .io_in_aluX(idEXEStageRegs_io_in_aluX),
    .io_in_aluY(idEXEStageRegs_io_in_aluY),
    .io_in_imm(idEXEStageRegs_io_in_imm),
    .io_out_pc(idEXEStageRegs_io_out_pc),
    .io_out_inst(idEXEStageRegs_io_out_inst),
    .io_out_isJALR(idEXEStageRegs_io_out_isJALR),
    .io_out_isBType(idEXEStageRegs_io_out_isBType),
    .io_out_isJump(idEXEStageRegs_io_out_isJump),
    .io_out_immALUToReg(idEXEStageRegs_io_out_immALUToReg),
    .io_out_memRead(idEXEStageRegs_io_out_memRead),
    .io_out_memWrite(idEXEStageRegs_io_out_memWrite),
    .io_out_writeEnable(idEXEStageRegs_io_out_writeEnable),
    .io_out_aluOperation(idEXEStageRegs_io_out_aluOperation),
    .io_out_readDataRs2(idEXEStageRegs_io_out_readDataRs2),
    .io_out_rd(idEXEStageRegs_io_out_rd),
    .io_out_aluX(idEXEStageRegs_io_out_aluX),
    .io_out_aluY(idEXEStageRegs_io_out_aluY),
    .io_out_imm(idEXEStageRegs_io_out_imm)
  );
  EXEMEMStageRegs exeMEMStageRegs ( // @[PiplineCPUGeneral.scala 102:31]
    .clock(exeMEMStageRegs_clock),
    .reset(exeMEMStageRegs_reset),
    .io_in_pc(exeMEMStageRegs_io_in_pc),
    .io_in_inst(exeMEMStageRegs_io_in_inst),
    .io_in_isJump(exeMEMStageRegs_io_in_isJump),
    .io_in_immALUToReg(exeMEMStageRegs_io_in_immALUToReg),
    .io_in_memRead(exeMEMStageRegs_io_in_memRead),
    .io_in_memWrite(exeMEMStageRegs_io_in_memWrite),
    .io_in_writeEnable(exeMEMStageRegs_io_in_writeEnable),
    .io_in_readDataRs2(exeMEMStageRegs_io_in_readDataRs2),
    .io_in_rd(exeMEMStageRegs_io_in_rd),
    .io_in_aluResult(exeMEMStageRegs_io_in_aluResult),
    .io_in_imm(exeMEMStageRegs_io_in_imm),
    .io_out_pc(exeMEMStageRegs_io_out_pc),
    .io_out_inst(exeMEMStageRegs_io_out_inst),
    .io_out_isJump(exeMEMStageRegs_io_out_isJump),
    .io_out_immALUToReg(exeMEMStageRegs_io_out_immALUToReg),
    .io_out_memRead(exeMEMStageRegs_io_out_memRead),
    .io_out_memWrite(exeMEMStageRegs_io_out_memWrite),
    .io_out_writeEnable(exeMEMStageRegs_io_out_writeEnable),
    .io_out_readDataRs2(exeMEMStageRegs_io_out_readDataRs2),
    .io_out_rd(exeMEMStageRegs_io_out_rd),
    .io_out_aluResult(exeMEMStageRegs_io_out_aluResult),
    .io_out_imm(exeMEMStageRegs_io_out_imm)
  );
  MEMWBStageRegs memWBStageRegs ( // @[PiplineCPUGeneral.scala 103:30]
    .clock(memWBStageRegs_clock),
    .reset(memWBStageRegs_reset),
    .io_in_pc(memWBStageRegs_io_in_pc),
    .io_in_inst(memWBStageRegs_io_in_inst),
    .io_in_isJump(memWBStageRegs_io_in_isJump),
    .io_in_immALUToReg(memWBStageRegs_io_in_immALUToReg),
    .io_in_memRead(memWBStageRegs_io_in_memRead),
    .io_in_writeEnable(memWBStageRegs_io_in_writeEnable),
    .io_in_readData(memWBStageRegs_io_in_readData),
    .io_in_aluResult(memWBStageRegs_io_in_aluResult),
    .io_in_imm(memWBStageRegs_io_in_imm),
    .io_out_pc(memWBStageRegs_io_out_pc),
    .io_out_inst(memWBStageRegs_io_out_inst),
    .io_out_isJump(memWBStageRegs_io_out_isJump),
    .io_out_immALUToReg(memWBStageRegs_io_out_immALUToReg),
    .io_out_memRead(memWBStageRegs_io_out_memRead),
    .io_out_writeEnable(memWBStageRegs_io_out_writeEnable),
    .io_out_readData(memWBStageRegs_io_out_readData),
    .io_out_aluResult(memWBStageRegs_io_out_aluResult),
    .io_out_imm(memWBStageRegs_io_out_imm)
  );
  BranchControlUnit branchControlUnit ( // @[PiplineCPUwithForwarding.scala 30:33]
    .clock(branchControlUnit_clock),
    .reset(branchControlUnit_reset),
    .io_keep(branchControlUnit_io_keep),
    .io_isJump(branchControlUnit_io_isJump),
    .io_isBType(branchControlUnit_io_isBType),
    .io_ifPC(branchControlUnit_io_ifPC),
    .io_idPC(branchControlUnit_io_idPC),
    .io_exePC(branchControlUnit_io_exePC),
    .io_selectPC(branchControlUnit_io_selectPC),
    .io_nextPC(branchControlUnit_io_nextPC),
    .io_flush(branchControlUnit_io_flush)
  );
  DataForwardingUnit dataForwardingUnit ( // @[PiplineCPUwithForwarding.scala 31:34]
    .clock(dataForwardingUnit_clock),
    .reset(dataForwardingUnit_reset),
    .io_inWriteEnable(dataForwardingUnit_io_inWriteEnable),
    .io_inRd(dataForwardingUnit_io_inRd),
    .io_inData(dataForwardingUnit_io_inData),
    .io_pcRs1ToAlu(dataForwardingUnit_io_pcRs1ToAlu),
    .io_rs1(dataForwardingUnit_io_rs1),
    .io_memWrite(dataForwardingUnit_io_memWrite),
    .io_immRs2ToAlu(dataForwardingUnit_io_immRs2ToAlu),
    .io_rs2(dataForwardingUnit_io_rs2),
    .io_exeWriteEnable(dataForwardingUnit_io_exeWriteEnable),
    .io_exeRd(dataForwardingUnit_io_exeRd),
    .io_memWriteEnable(dataForwardingUnit_io_memWriteEnable),
    .io_memRd(dataForwardingUnit_io_memRd),
    .io_exeIsJump(dataForwardingUnit_io_exeIsJump),
    .io_exeImmALUToReg(dataForwardingUnit_io_exeImmALUToReg),
    .io_exeMemRead(dataForwardingUnit_io_exeMemRead),
    .io_exeALUResult(dataForwardingUnit_io_exeALUResult),
    .io_exeImm(dataForwardingUnit_io_exeImm),
    .io_memIsJump(dataForwardingUnit_io_memIsJump),
    .io_memImmALUToReg(dataForwardingUnit_io_memImmALUToReg),
    .io_memMemRead(dataForwardingUnit_io_memMemRead),
    .io_memReadData(dataForwardingUnit_io_memReadData),
    .io_memALUResult(dataForwardingUnit_io_memALUResult),
    .io_memImm(dataForwardingUnit_io_memImm),
    .io_exePC(dataForwardingUnit_io_exePC),
    .io_memPC(dataForwardingUnit_io_memPC),
    .io_writeEnable(dataForwardingUnit_io_writeEnable),
    .io_rd(dataForwardingUnit_io_rd),
    .io_data(dataForwardingUnit_io_data),
    .io_keep(dataForwardingUnit_io_keep),
    .io_stall(dataForwardingUnit_io_stall),
    .io_flush(dataForwardingUnit_io_flush),
    .io_forwardRs1(dataForwardingUnit_io_forwardRs1),
    .io_forwardRs2(dataForwardingUnit_io_forwardRs2),
    .io_forwardData1(dataForwardingUnit_io_forwardData1),
    .io_forwardData2(dataForwardingUnit_io_forwardData2)
  );
  assign io_isValidInst = controlUnit_io_isValidInst; // @[PiplineCPUwithForwarding.scala 46:18]
  assign io_ifPC = ifIDStageRegs_io_in_pc; // @[PiplineCPUwithForwarding.scala 48:11]
  assign io_ifInst = ifIDStageRegs_io_in_inst; // @[PiplineCPUwithForwarding.scala 49:13]
  assign io_idPC = idEXEStageRegs_io_in_pc; // @[PiplineCPUwithForwarding.scala 50:11]
  assign io_idInst = idEXEStageRegs_io_in_inst; // @[PiplineCPUwithForwarding.scala 51:13]
  assign io_exePC = exeMEMStageRegs_io_in_pc; // @[PiplineCPUwithForwarding.scala 52:12]
  assign io_exeInst = exeMEMStageRegs_io_in_inst; // @[PiplineCPUwithForwarding.scala 53:14]
  assign io_memPC = memWBStageRegs_io_in_pc; // @[PiplineCPUwithForwarding.scala 54:12]
  assign io_memInst = memWBStageRegs_io_in_inst; // @[PiplineCPUwithForwarding.scala 55:14]
  assign io_wbPC = memWBStageRegs_io_out_pc; // @[PiplineCPUwithForwarding.scala 56:11]
  assign io_wbInst = memWBStageRegs_io_out_inst; // @[PiplineCPUwithForwarding.scala 57:13]
  assign io_nextPC = branchControlUnit_io_nextPC; // @[PiplineCPUwithForwarding.scala 90:13]
  assign io_aluOperation = alu_io_aluOperation; // @[PiplineCPUwithForwarding.scala 83:19]
  assign io_imm = inst2ImmUnit_io_imm; // @[PiplineCPUwithForwarding.scala 84:10]
  assign io_aluResult = alu_io_result; // @[PiplineCPUwithForwarding.scala 61:16]
  assign io_opcode = controlUnit_io_opcode; // @[PiplineCPUwithForwarding.scala 64:13]
  assign io_isTrue = pcSelectUnit_io_isTrue; // @[PiplineCPUwithForwarding.scala 63:13]
  assign io_isJALR = pcSelectUnit_io_isJALR; // @[PiplineCPUwithForwarding.scala 65:13]
  assign io_isBType = pcSelectUnit_io_isBType; // @[PiplineCPUwithForwarding.scala 66:14]
  assign io_isJump = pcSelectUnit_io_isJump; // @[PiplineCPUwithForwarding.scala 67:13]
  assign io_immALUToReg = controlUnit_io_immALUToReg; // @[PiplineCPUwithForwarding.scala 68:18]
  assign io_memRead = dataMemory_io_memRead; // @[PiplineCPUwithForwarding.scala 69:14]
  assign io_memWrite = dataMemory_io_memWrite; // @[PiplineCPUwithForwarding.scala 70:15]
  assign io_immRs2ToALU = controlUnit_io_immRs2ToALU; // @[PiplineCPUwithForwarding.scala 71:18]
  assign io_aluY = alu_io_y; // @[PiplineCPUwithForwarding.scala 72:11]
  assign io_pcRs1ToALU = controlUnit_io_pcRs1ToALU; // @[PiplineCPUwithForwarding.scala 73:17]
  assign io_aluX = alu_io_x; // @[PiplineCPUwithForwarding.scala 74:11]
  assign io_isIType = controlUnit_io_isIType; // @[PiplineCPUwithForwarding.scala 75:14]
  assign io_isRType = controlUnit_io_isRType; // @[PiplineCPUwithForwarding.scala 76:14]
  assign io_isWord = controlUnit_io_isWord; // @[PiplineCPUwithForwarding.scala 77:13]
  assign io_ifWriteToReg = regUnit_io_writeEnable; // @[PiplineCPUwithForwarding.scala 78:19]
  assign io_address = dataMemory_io_address; // @[PiplineCPUwithForwarding.scala 80:14]
  assign io_writeData = dataMemory_io_writeData; // @[PiplineCPUwithForwarding.scala 81:16]
  assign io_rs1 = regUnit_io_rs1; // @[PiplineCPUwithForwarding.scala 85:10]
  assign io_readDataRs1 = dataForwardingUnit_io_forwardRs1 ? dataForwardingUnit_io_forwardData1 : regUnit_io_readDataRs1
    ; // @[PiplineCPUwithForwarding.scala 35:24]
  assign io_rs2 = regUnit_io_rs2; // @[PiplineCPUwithForwarding.scala 87:10]
  assign io_readDataRs2 = dataForwardingUnit_io_forwardRs2 ? dataForwardingUnit_io_forwardData2 : regUnit_io_readDataRs2
    ; // @[PiplineCPUwithForwarding.scala 40:24]
  assign io_rd = regUnit_io_rd; // @[PiplineCPUwithForwarding.scala 89:9]
  assign io_resultToReg = regUnit_io_writeData; // @[PiplineCPUwithForwarding.scala 59:18]
  assign io_bitType = dataMemory_io_bitType; // @[PiplineCPUwithForwarding.scala 92:14]
  assign io_isUnsigned = dataMemory_io_isUnsigned; // @[PiplineCPUwithForwarding.scala 93:17]
  assign io_readData = dataMemory_io_readData; // @[PiplineCPUwithForwarding.scala 60:15]
  assign io_regAll_0 = 64'h0; // @[PiplineCPUwithForwarding.scala 96:18]
  assign io_regAll_1 = regUnit_io_regAll_1; // @[PiplineCPUwithForwarding.scala 96:18]
  assign io_regAll_2 = regUnit_io_regAll_2; // @[PiplineCPUwithForwarding.scala 96:18]
  assign io_regAll_3 = regUnit_io_regAll_3; // @[PiplineCPUwithForwarding.scala 96:18]
  assign io_regAll_4 = regUnit_io_regAll_4; // @[PiplineCPUwithForwarding.scala 96:18]
  assign io_regAll_5 = regUnit_io_regAll_5; // @[PiplineCPUwithForwarding.scala 96:18]
  assign io_regAll_6 = regUnit_io_regAll_6; // @[PiplineCPUwithForwarding.scala 96:18]
  assign io_regAll_7 = regUnit_io_regAll_7; // @[PiplineCPUwithForwarding.scala 96:18]
  assign io_regAll_8 = regUnit_io_regAll_8; // @[PiplineCPUwithForwarding.scala 96:18]
  assign io_regAll_9 = regUnit_io_regAll_9; // @[PiplineCPUwithForwarding.scala 96:18]
  assign io_regAll_10 = regUnit_io_regAll_10; // @[PiplineCPUwithForwarding.scala 96:18]
  assign io_regAll_11 = regUnit_io_regAll_11; // @[PiplineCPUwithForwarding.scala 96:18]
  assign io_regAll_12 = regUnit_io_regAll_12; // @[PiplineCPUwithForwarding.scala 96:18]
  assign io_regAll_13 = regUnit_io_regAll_13; // @[PiplineCPUwithForwarding.scala 96:18]
  assign io_regAll_14 = regUnit_io_regAll_14; // @[PiplineCPUwithForwarding.scala 96:18]
  assign io_regAll_15 = regUnit_io_regAll_15; // @[PiplineCPUwithForwarding.scala 96:18]
  assign io_regAll_16 = regUnit_io_regAll_16; // @[PiplineCPUwithForwarding.scala 96:18]
  assign io_regAll_17 = regUnit_io_regAll_17; // @[PiplineCPUwithForwarding.scala 96:18]
  assign io_regAll_18 = regUnit_io_regAll_18; // @[PiplineCPUwithForwarding.scala 96:18]
  assign io_regAll_19 = regUnit_io_regAll_19; // @[PiplineCPUwithForwarding.scala 96:18]
  assign io_regAll_20 = regUnit_io_regAll_20; // @[PiplineCPUwithForwarding.scala 96:18]
  assign io_regAll_21 = regUnit_io_regAll_21; // @[PiplineCPUwithForwarding.scala 96:18]
  assign io_regAll_22 = regUnit_io_regAll_22; // @[PiplineCPUwithForwarding.scala 96:18]
  assign io_regAll_23 = regUnit_io_regAll_23; // @[PiplineCPUwithForwarding.scala 96:18]
  assign io_regAll_24 = regUnit_io_regAll_24; // @[PiplineCPUwithForwarding.scala 96:18]
  assign io_regAll_25 = regUnit_io_regAll_25; // @[PiplineCPUwithForwarding.scala 96:18]
  assign io_regAll_26 = regUnit_io_regAll_26; // @[PiplineCPUwithForwarding.scala 96:18]
  assign io_regAll_27 = regUnit_io_regAll_27; // @[PiplineCPUwithForwarding.scala 96:18]
  assign io_regAll_28 = regUnit_io_regAll_28; // @[PiplineCPUwithForwarding.scala 96:18]
  assign io_regAll_29 = regUnit_io_regAll_29; // @[PiplineCPUwithForwarding.scala 96:18]
  assign io_regAll_30 = regUnit_io_regAll_30; // @[PiplineCPUwithForwarding.scala 96:18]
  assign io_regAll_31 = regUnit_io_regAll_31; // @[PiplineCPUwithForwarding.scala 96:18]
  assign pcReg_clock = clock;
  assign pcReg_reset = reset;
  assign pcReg_io_in = branchControlUnit_io_nextPC; // @[PiplineCPUwithForwarding.scala 219:15]
  assign instMemory_clock = clock;
  assign instMemory_io_address = pcReg_io_out; // @[PiplineCPUwithForwarding.scala 221:25]
  assign controlUnit_io_opcode = ifIDStageRegs_io_out_inst[6:0]; // @[PiplineCPUwithForwarding.scala 111:22]
  assign inst2ImmUnit_io_inst = ifIDStageRegs_io_out_inst; // @[PiplineCPUwithForwarding.scala 238:24]
  assign regUnit_clock = clock;
  assign regUnit_reset = reset;
  assign regUnit_io_rs1 = ifIDStageRegs_io_out_inst[19:15]; // @[PiplineCPUwithForwarding.scala 113:19]
  assign regUnit_io_rs2 = ifIDStageRegs_io_out_inst[24:20]; // @[PiplineCPUwithForwarding.scala 114:19]
  assign regUnit_io_rd = dataForwardingUnit_io_rd; // @[PiplineCPUwithForwarding.scala 235:17]
  assign regUnit_io_writeEnable = dataForwardingUnit_io_writeEnable; // @[PiplineCPUwithForwarding.scala 232:26]
  assign regUnit_io_writeData = dataForwardingUnit_io_data; // @[PiplineCPUwithForwarding.scala 236:24]
  assign aluControlUnit_io_isBType = controlUnit_io_isBType; // @[PiplineCPUwithForwarding.scala 225:29]
  assign aluControlUnit_io_isIType = controlUnit_io_isIType; // @[PiplineCPUwithForwarding.scala 226:29]
  assign aluControlUnit_io_isRType = controlUnit_io_isRType; // @[PiplineCPUwithForwarding.scala 227:29]
  assign aluControlUnit_io_isWord = controlUnit_io_isWord; // @[PiplineCPUwithForwarding.scala 228:28]
  assign aluControlUnit_io_funct3 = ifIDStageRegs_io_out_inst[14:12]; // @[PiplineCPUwithForwarding.scala 116:22]
  assign aluControlUnit_io_funct7 = ifIDStageRegs_io_out_inst[31:25]; // @[PiplineCPUwithForwarding.scala 117:22]
  assign pcSelectUnit_io_pcPlus4 = idEXEStageRegs_io_out_pc + 64'h4; // @[PiplineCPUwithForwarding.scala 240:36]
  assign pcSelectUnit_io_pcPlusImm = idEXEStageRegs_io_out_pc + idEXEStageRegs_io_out_imm; // @[PiplineCPUwithForwarding.scala 241:38]
  assign pcSelectUnit_io_isJALR = idEXEStageRegs_io_out_isJALR; // @[PiplineCPUwithForwarding.scala 242:26]
  assign pcSelectUnit_io_isBType = idEXEStageRegs_io_out_isBType; // @[PiplineCPUwithForwarding.scala 243:27]
  assign pcSelectUnit_io_isJump = idEXEStageRegs_io_out_isJump; // @[PiplineCPUwithForwarding.scala 244:26]
  assign pcSelectUnit_io_isTrue = alu_io_result[0]; // @[PiplineCPUwithForwarding.scala 245:42]
  assign pcSelectUnit_io_aluResult = alu_io_result; // @[PiplineCPUwithForwarding.scala 246:29]
  assign alu_io_aluOperation = idEXEStageRegs_io_out_aluOperation; // @[PiplineCPUwithForwarding.scala 248:23]
  assign alu_io_x = idEXEStageRegs_io_out_aluX; // @[PiplineCPUwithForwarding.scala 249:12]
  assign alu_io_y = idEXEStageRegs_io_out_aluY; // @[PiplineCPUwithForwarding.scala 250:12]
  assign dataMemory_clock = clock;
  assign dataMemory_io_memRead = exeMEMStageRegs_io_out_memRead; // @[PiplineCPUwithForwarding.scala 252:25]
  assign dataMemory_io_memWrite = exeMEMStageRegs_io_out_memWrite; // @[PiplineCPUwithForwarding.scala 253:26]
  assign dataMemory_io_address = exeMEMStageRegs_io_out_aluResult; // @[PiplineCPUwithForwarding.scala 254:25]
  assign dataMemory_io_writeData = exeMEMStageRegs_io_out_readDataRs2; // @[PiplineCPUwithForwarding.scala 255:27]
  assign dataMemory_io_bitType = exeMEMStageRegs_io_out_inst[13:12]; // @[PiplineCPUwithForwarding.scala 119:24]
  assign dataMemory_io_isUnsigned = exeMEMStageRegs_io_out_inst[14]; // @[PiplineCPUwithForwarding.scala 120:27]
  assign resSelectUnit_io_isJump = memWBStageRegs_io_out_isJump; // @[PiplineCPUwithForwarding.scala 259:27]
  assign resSelectUnit_io_immALUToReg = memWBStageRegs_io_out_immALUToReg; // @[PiplineCPUwithForwarding.scala 260:32]
  assign resSelectUnit_io_memRead = memWBStageRegs_io_out_memRead; // @[PiplineCPUwithForwarding.scala 261:28]
  assign resSelectUnit_io_readData = memWBStageRegs_io_out_readData; // @[PiplineCPUwithForwarding.scala 262:29]
  assign resSelectUnit_io_aluResult = memWBStageRegs_io_out_aluResult; // @[PiplineCPUwithForwarding.scala 263:30]
  assign resSelectUnit_io_imm = memWBStageRegs_io_out_imm; // @[PiplineCPUwithForwarding.scala 264:24]
  assign resSelectUnit_io_pcPlus4 = memWBStageRegs_io_out_pc + 64'h4; // @[PiplineCPUwithForwarding.scala 265:36]
  assign ifIDStageRegs_clock = clock;
  assign ifIDStageRegs_reset = reset;
  assign ifIDStageRegs_io_stall = dataForwardingUnit_io_stall; // @[PiplineCPUwithForwarding.scala 124:26]
  assign ifIDStageRegs_io_flush = branchControlUnit_io_flush; // @[PiplineCPUwithForwarding.scala 125:26]
  assign ifIDStageRegs_io_in_pc = pcReg_io_out; // @[PiplineCPUwithForwarding.scala 126:26]
  assign ifIDStageRegs_io_in_inst = instMemory_io_inst; // @[PiplineCPUwithForwarding.scala 127:28]
  assign idEXEStageRegs_clock = clock;
  assign idEXEStageRegs_reset = reset;
  assign idEXEStageRegs_io_flush = dataForwardingUnit_io_flush; // @[PiplineCPUwithForwarding.scala 130:27]
  assign idEXEStageRegs_io_in_pc = ifIDStageRegs_io_out_pc; // @[PiplineCPUwithForwarding.scala 131:27]
  assign idEXEStageRegs_io_in_inst = ifIDStageRegs_io_out_inst; // @[PiplineCPUwithForwarding.scala 132:29]
  assign idEXEStageRegs_io_in_isJALR = controlUnit_io_isJALR; // @[PiplineCPUwithForwarding.scala 133:31]
  assign idEXEStageRegs_io_in_isBType = controlUnit_io_isBType; // @[PiplineCPUwithForwarding.scala 134:32]
  assign idEXEStageRegs_io_in_isJump = controlUnit_io_isJump; // @[PiplineCPUwithForwarding.scala 135:31]
  assign idEXEStageRegs_io_in_immALUToReg = controlUnit_io_immALUToReg; // @[PiplineCPUwithForwarding.scala 136:36]
  assign idEXEStageRegs_io_in_memRead = controlUnit_io_memRead; // @[PiplineCPUwithForwarding.scala 137:32]
  assign idEXEStageRegs_io_in_memWrite = controlUnit_io_memWrite; // @[PiplineCPUwithForwarding.scala 138:33]
  assign idEXEStageRegs_io_in_writeEnable = controlUnit_io_ifWriteToReg; // @[PiplineCPUwithForwarding.scala 139:36]
  assign idEXEStageRegs_io_in_aluOperation = aluControlUnit_io_aluOperation; // @[PiplineCPUwithForwarding.scala 140:37]
  assign idEXEStageRegs_io_in_readDataRs2 = dataForwardingUnit_io_forwardRs2 ? dataForwardingUnit_io_forwardData2 :
    regUnit_io_readDataRs2; // @[PiplineCPUwithForwarding.scala 40:24]
  assign idEXEStageRegs_io_in_rd = ifIDStageRegs_io_out_inst[11:7]; // @[PiplineCPUwithForwarding.scala 115:18]
  assign idEXEStageRegs_io_in_aluX = controlUnit_io_pcRs1ToALU ? ifIDStageRegs_io_out_pc : readDataRs1; // @[PiplineCPUwithForwarding.scala 143:35]
  assign idEXEStageRegs_io_in_aluY = controlUnit_io_immRs2ToALU ? inst2ImmUnit_io_imm : readDataRs2; // @[PiplineCPUwithForwarding.scala 148:35]
  assign idEXEStageRegs_io_in_imm = inst2ImmUnit_io_imm; // @[PiplineCPUwithForwarding.scala 153:28]
  assign exeMEMStageRegs_clock = clock;
  assign exeMEMStageRegs_reset = reset;
  assign exeMEMStageRegs_io_in_pc = idEXEStageRegs_io_out_pc; // @[PiplineCPUwithForwarding.scala 157:28]
  assign exeMEMStageRegs_io_in_inst = idEXEStageRegs_io_out_inst; // @[PiplineCPUwithForwarding.scala 158:30]
  assign exeMEMStageRegs_io_in_isJump = idEXEStageRegs_io_out_isJump; // @[PiplineCPUwithForwarding.scala 159:32]
  assign exeMEMStageRegs_io_in_immALUToReg = idEXEStageRegs_io_out_immALUToReg; // @[PiplineCPUwithForwarding.scala 160:37]
  assign exeMEMStageRegs_io_in_memRead = idEXEStageRegs_io_out_memRead; // @[PiplineCPUwithForwarding.scala 161:33]
  assign exeMEMStageRegs_io_in_memWrite = idEXEStageRegs_io_out_memWrite; // @[PiplineCPUwithForwarding.scala 162:34]
  assign exeMEMStageRegs_io_in_writeEnable = idEXEStageRegs_io_out_writeEnable; // @[PiplineCPUwithForwarding.scala 163:37]
  assign exeMEMStageRegs_io_in_readDataRs2 = idEXEStageRegs_io_out_readDataRs2; // @[PiplineCPUwithForwarding.scala 164:37]
  assign exeMEMStageRegs_io_in_rd = idEXEStageRegs_io_out_rd; // @[PiplineCPUwithForwarding.scala 165:28]
  assign exeMEMStageRegs_io_in_aluResult = alu_io_result; // @[PiplineCPUwithForwarding.scala 166:35]
  assign exeMEMStageRegs_io_in_imm = idEXEStageRegs_io_out_imm; // @[PiplineCPUwithForwarding.scala 167:29]
  assign memWBStageRegs_clock = clock;
  assign memWBStageRegs_reset = reset;
  assign memWBStageRegs_io_in_pc = exeMEMStageRegs_io_out_pc; // @[PiplineCPUwithForwarding.scala 171:27]
  assign memWBStageRegs_io_in_inst = exeMEMStageRegs_io_out_inst; // @[PiplineCPUwithForwarding.scala 172:29]
  assign memWBStageRegs_io_in_isJump = exeMEMStageRegs_io_out_isJump; // @[PiplineCPUwithForwarding.scala 173:31]
  assign memWBStageRegs_io_in_immALUToReg = exeMEMStageRegs_io_out_immALUToReg; // @[PiplineCPUwithForwarding.scala 174:36]
  assign memWBStageRegs_io_in_memRead = exeMEMStageRegs_io_out_memRead; // @[PiplineCPUwithForwarding.scala 175:32]
  assign memWBStageRegs_io_in_writeEnable = exeMEMStageRegs_io_out_writeEnable; // @[PiplineCPUwithForwarding.scala 176:36]
  assign memWBStageRegs_io_in_readData = dataMemory_io_readData; // @[PiplineCPUwithForwarding.scala 177:33]
  assign memWBStageRegs_io_in_aluResult = exeMEMStageRegs_io_out_aluResult; // @[PiplineCPUwithForwarding.scala 179:34]
  assign memWBStageRegs_io_in_imm = exeMEMStageRegs_io_out_imm; // @[PiplineCPUwithForwarding.scala 180:28]
  assign branchControlUnit_clock = clock;
  assign branchControlUnit_reset = reset;
  assign branchControlUnit_io_keep = dataForwardingUnit_io_keep; // @[PiplineCPUwithForwarding.scala 182:29]
  assign branchControlUnit_io_isJump = controlUnit_io_isJump; // @[PiplineCPUwithForwarding.scala 183:31]
  assign branchControlUnit_io_isBType = controlUnit_io_isBType; // @[PiplineCPUwithForwarding.scala 184:32]
  assign branchControlUnit_io_ifPC = pcReg_io_out; // @[PiplineCPUwithForwarding.scala 185:29]
  assign branchControlUnit_io_idPC = ifIDStageRegs_io_out_pc; // @[PiplineCPUwithForwarding.scala 186:29]
  assign branchControlUnit_io_exePC = idEXEStageRegs_io_out_pc; // @[PiplineCPUwithForwarding.scala 187:30]
  assign branchControlUnit_io_selectPC = pcSelectUnit_io_nextPC; // @[PiplineCPUwithForwarding.scala 188:33]
  assign dataForwardingUnit_clock = clock;
  assign dataForwardingUnit_reset = reset;
  assign dataForwardingUnit_io_inWriteEnable = memWBStageRegs_io_out_writeEnable; // @[PiplineCPUwithForwarding.scala 190:39]
  assign dataForwardingUnit_io_inRd = memWBStageRegs_io_out_inst[11:7]; // @[PiplineCPUwithForwarding.scala 122:20]
  assign dataForwardingUnit_io_inData = resSelectUnit_io_out; // @[PiplineCPUwithForwarding.scala 192:32]
  assign dataForwardingUnit_io_pcRs1ToAlu = controlUnit_io_pcRs1ToALU; // @[PiplineCPUwithForwarding.scala 193:36]
  assign dataForwardingUnit_io_rs1 = ifIDStageRegs_io_out_inst[19:15]; // @[PiplineCPUwithForwarding.scala 113:19]
  assign dataForwardingUnit_io_memWrite = controlUnit_io_memWrite; // @[PiplineCPUwithForwarding.scala 195:34]
  assign dataForwardingUnit_io_immRs2ToAlu = controlUnit_io_immRs2ToALU; // @[PiplineCPUwithForwarding.scala 196:37]
  assign dataForwardingUnit_io_rs2 = ifIDStageRegs_io_out_inst[24:20]; // @[PiplineCPUwithForwarding.scala 114:19]
  assign dataForwardingUnit_io_exeWriteEnable = idEXEStageRegs_io_out_writeEnable; // @[PiplineCPUwithForwarding.scala 198:40]
  assign dataForwardingUnit_io_exeRd = idEXEStageRegs_io_out_rd; // @[PiplineCPUwithForwarding.scala 199:31]
  assign dataForwardingUnit_io_memWriteEnable = exeMEMStageRegs_io_out_writeEnable; // @[PiplineCPUwithForwarding.scala 200:40]
  assign dataForwardingUnit_io_memRd = exeMEMStageRegs_io_out_rd; // @[PiplineCPUwithForwarding.scala 201:31]
  assign dataForwardingUnit_io_exeIsJump = idEXEStageRegs_io_out_isJump; // @[PiplineCPUwithForwarding.scala 203:35]
  assign dataForwardingUnit_io_exeImmALUToReg = idEXEStageRegs_io_out_immALUToReg; // @[PiplineCPUwithForwarding.scala 204:40]
  assign dataForwardingUnit_io_exeMemRead = idEXEStageRegs_io_out_memRead; // @[PiplineCPUwithForwarding.scala 205:36]
  assign dataForwardingUnit_io_exeALUResult = alu_io_result; // @[PiplineCPUwithForwarding.scala 206:38]
  assign dataForwardingUnit_io_exeImm = idEXEStageRegs_io_out_imm; // @[PiplineCPUwithForwarding.scala 207:32]
  assign dataForwardingUnit_io_memIsJump = exeMEMStageRegs_io_out_isJump; // @[PiplineCPUwithForwarding.scala 209:35]
  assign dataForwardingUnit_io_memImmALUToReg = exeMEMStageRegs_io_out_immALUToReg; // @[PiplineCPUwithForwarding.scala 210:40]
  assign dataForwardingUnit_io_memMemRead = exeMEMStageRegs_io_out_memRead; // @[PiplineCPUwithForwarding.scala 211:36]
  assign dataForwardingUnit_io_memReadData = dataMemory_io_readData; // @[PiplineCPUwithForwarding.scala 212:37]
  assign dataForwardingUnit_io_memALUResult = exeMEMStageRegs_io_out_aluResult; // @[PiplineCPUwithForwarding.scala 213:38]
  assign dataForwardingUnit_io_memImm = exeMEMStageRegs_io_out_imm; // @[PiplineCPUwithForwarding.scala 214:32]
  assign dataForwardingUnit_io_exePC = idEXEStageRegs_io_out_pc; // @[PiplineCPUwithForwarding.scala 216:31]
  assign dataForwardingUnit_io_memPC = exeMEMStageRegs_io_out_pc; // @[PiplineCPUwithForwarding.scala 217:31]
endmodule
