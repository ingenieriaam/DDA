//Copyright 1986-2020 Xilinx, Inc. All Rights Reserved.
//--------------------------------------------------------------------------------
//Tool Version: Vivado v.2020.2 (win64) Build 3064766 Wed Nov 18 09:12:45 MST 2020
//Date        : Mon Aug 29 21:51:15 2022
//Host        : DESKTOP-FK3P1BN running 64-bit major release  (build 9200)
//Command     : generate_target ila.bd
//Design      : ila
//Purpose     : IP block netlist
//--------------------------------------------------------------------------------
`timescale 1 ps / 1 ps

(* CORE_GENERATION_INFO = "ila,IP_Integrator,{x_ipVendor=xilinx.com,x_ipLibrary=BlockDiagram,x_ipName=ila,x_ipVersion=1.00.a,x_ipLanguage=VERILOG,numBlks=1,numReposBlks=1,numNonXlnxBlks=0,numHierBlks=0,maxHierDepth=0,numSysgenBlks=0,numHlsBlks=0,numHdlrefBlks=0,numPkgbdBlks=0,bdsource=USER,synth_mode=OOC_per_IP}" *) (* HW_HANDOFF = "ila.hwdef" *) 
module ila
   (clk_0,
    probe0_0);
  (* X_INTERFACE_INFO = "xilinx.com:signal:clock:1.0 CLK.CLK_0 CLK" *) (* X_INTERFACE_PARAMETER = "XIL_INTERFACENAME CLK.CLK_0, CLK_DOMAIN ila_clk_0, FREQ_HZ 100000000, FREQ_TOLERANCE_HZ 0, INSERT_VIP 0, PHASE 0.000" *) input clk_0;
  input [3:0]probe0_0;

  wire clk_0_1;
  wire [3:0]probe0_0_1;

  assign clk_0_1 = clk_0;
  assign probe0_0_1 = probe0_0[3:0];
  ila_ila_0_0 ila_0
       (.clk(clk_0_1),
        .probe0(probe0_0_1));
endmodule
