// Copyright 1986-2020 Xilinx, Inc. All Rights Reserved.
// --------------------------------------------------------------------------------
// Tool Version: Vivado v.2020.2 (win64) Build 3064766 Wed Nov 18 09:12:45 MST 2020
// Date        : Mon Aug 29 21:44:28 2022
// Host        : DESKTOP-FK3P1BN running 64-bit major release  (build 9200)
// Command     : write_verilog -force -mode synth_stub
//               c:/Users/LENOVO/Desktop/DDA/codigos/shiftreg_vioila/shiftreg_vioila.gen/sources_1/bd/vio/ip/vio_vio_0_0/vio_vio_0_0_stub.v
// Design      : vio_vio_0_0
// Purpose     : Stub declaration of top-level module interface
// Device      : xc7a35ticsg324-1L
// --------------------------------------------------------------------------------

// This empty module with port declaration file causes synthesis tools to infer a black box for IP.
// The synthesis directives are for Synopsys Synplify support to prevent IO buffer insertion.
// Please paste the declaration into a Verilog source file or add the file as an additional source.
(* X_CORE_INFO = "vio,Vivado 2020.2" *)
module vio_vio_0_0(clk, probe_in0, probe_in1, probe_in2, probe_out0, 
  probe_out1, probe_out2)
/* synthesis syn_black_box black_box_pad_pin="clk,probe_in0[3:0],probe_in1[3:0],probe_in2[3:0],probe_out0[0:0],probe_out1[0:0],probe_out2[3:0]" */;
  input clk;
  input [3:0]probe_in0;
  input [3:0]probe_in1;
  input [3:0]probe_in2;
  output [0:0]probe_out0;
  output [0:0]probe_out1;
  output [3:0]probe_out2;
endmodule
