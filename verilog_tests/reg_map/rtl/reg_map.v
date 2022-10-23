/* Generated by Yosys 0.10+12 (open-tool-forge build) (git sha1 356ec7bb, gcc 9.3.0-17ubuntu1~20.04 -Os) */

module reg_map(clk, rst, en, srst, load, data, r0, r1, r2, r3);
  reg [15:0] _00_;
  wire [15:0] _01_;
  wire [15:0] _02_;
  wire [15:0] _03_;
  wire _04_;
  wire [15:0] _05_;
  wire [15:0] _06_;
  wire [15:0] _07_;
  wire _08_;
  wire [15:0] _09_;
  wire [15:0] _10_;
  reg [15:0] _11_;
  wire [15:0] _12_;
  reg [15:0] _13_;
  reg [15:0] _14_;
  wire _15_;
  wire [15:0] _16_;
  wire [15:0] _17_;
  wire [15:0] _18_;
  wire _19_;
  input clk;
  input [15:0] data;
  input en;
  input [3:0] load;
  wire [63:0] q_next;
  wire [63:0] q_reg;
  output [15:0] r0;
  output [15:0] r1;
  output [15:0] r2;
  output [15:0] r3;
  input rst;
  input srst;
  always @(posedge clk, posedge rst)
    if (rst) _00_ <= 16'h0000;
    else _00_ <= q_next[63:48];
  always @(posedge clk, posedge rst)
    if (rst) _11_ <= 16'h0000;
    else _11_ <= q_next[47:32];
  always @(posedge clk, posedge rst)
    if (rst) _13_ <= 16'h0000;
    else _13_ <= q_next[31:16];
  always @(posedge clk, posedge rst)
    if (rst) _14_ <= 16'h0000;
    else _14_ <= q_next[15:0];
  assign _15_ = ~ en;
  assign _16_ = _15_ ? q_reg[63:48] : _17_;
  assign _17_ = srst ? 16'h0000 : _18_;
  assign _18_ = load[3] ? data : q_reg[63:48];
  assign _19_ = ~ en;
  assign _01_ = _19_ ? q_reg[47:32] : _02_;
  assign _02_ = srst ? 16'h0000 : _03_;
  assign _03_ = load[2] ? data : q_reg[47:32];
  assign _04_ = ~ en;
  assign _05_ = _04_ ? q_reg[31:16] : _06_;
  assign _06_ = srst ? 16'h0000 : _07_;
  assign _07_ = load[1] ? data : q_reg[31:16];
  assign _08_ = ~ en;
  assign _09_ = _08_ ? q_reg[15:0] : _10_;
  assign _10_ = srst ? 16'h0000 : _12_;
  assign _12_ = load[0] ? data : q_reg[15:0];
  assign q_reg = { _00_, _11_, _13_, _14_ };
  assign q_next = { _16_, _01_, _05_, _09_ };
  assign r0 = q_reg[15:0];
  assign r1 = q_reg[31:16];
  assign r2 = q_reg[47:32];
  assign r3 = q_reg[63:48];
endmodule