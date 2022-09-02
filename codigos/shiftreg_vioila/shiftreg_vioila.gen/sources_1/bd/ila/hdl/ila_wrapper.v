//Copyright 1986-2020 Xilinx, Inc. All Rights Reserved.
//--------------------------------------------------------------------------------
//Tool Version: Vivado v.2020.2 (win64) Build 3064766 Wed Nov 18 09:12:45 MST 2020
//Date        : Mon Aug 29 21:51:16 2022
//Host        : DESKTOP-FK3P1BN running 64-bit major release  (build 9200)
//Command     : generate_target ila_wrapper.bd
//Design      : ila_wrapper
//Purpose     : IP block netlist
//--------------------------------------------------------------------------------
`timescale 1 ps / 1 ps

module ila_wrapper
   (clk_0,
    probe0_0);
  input clk_0;
  input [3:0]probe0_0;

  wire clk_0;
  wire [3:0]probe0_0;

  ila ila_i
       (.clk_0(clk_0),
        .probe0_0(probe0_0));
endmodule
