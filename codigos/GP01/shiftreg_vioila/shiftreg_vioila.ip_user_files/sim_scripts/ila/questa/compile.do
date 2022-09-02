vlib questa_lib/work
vlib questa_lib/msim

vlib questa_lib/msim/xpm
vlib questa_lib/msim/xil_defaultlib

vmap xpm questa_lib/msim/xpm
vmap xil_defaultlib questa_lib/msim/xil_defaultlib

vlog -work xpm  -sv "+incdir+../../../../shiftreg_vioila.gen/sources_1/bd/ila/ipshared/1b7e/hdl/verilog" "+incdir+../../../../shiftreg_vioila.gen/sources_1/bd/ila/ipshared/122e/hdl/verilog" "+incdir+../../../../shiftreg_vioila.gen/sources_1/bd/ila/ipshared/b205/hdl/verilog" "+incdir+../../../../shiftreg_vioila.gen/sources_1/bd/ila/ipshared/c968/hdl/verilog" \
"C:/Xilinx/Vivado/2020.2/data/ip/xpm/xpm_cdc/hdl/xpm_cdc.sv" \
"C:/Xilinx/Vivado/2020.2/data/ip/xpm/xpm_memory/hdl/xpm_memory.sv" \

vcom -work xpm  -93 \
"C:/Xilinx/Vivado/2020.2/data/ip/xpm/xpm_VCOMP.vhd" \

vlog -work xil_defaultlib  "+incdir+../../../../shiftreg_vioila.gen/sources_1/bd/ila/ipshared/1b7e/hdl/verilog" "+incdir+../../../../shiftreg_vioila.gen/sources_1/bd/ila/ipshared/122e/hdl/verilog" "+incdir+../../../../shiftreg_vioila.gen/sources_1/bd/ila/ipshared/b205/hdl/verilog" "+incdir+../../../../shiftreg_vioila.gen/sources_1/bd/ila/ipshared/c968/hdl/verilog" \
"../../../bd/ila/ip/ila_ila_0_0/sim/ila_ila_0_0.v" \
"../../../bd/ila/sim/ila.v" \

vlog -work xil_defaultlib \
"glbl.v"

