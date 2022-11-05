vlib questa_lib/work
vlib questa_lib/msim

vlib questa_lib/msim/xil_defaultlib

vmap xil_defaultlib questa_lib/msim/xil_defaultlib

vlog -work xil_defaultlib  "+incdir+../../../../shiftreg_vioila.gen/sources_1/bd/vio/ipshared/1b7e/hdl/verilog" "+incdir+../../../../shiftreg_vioila.gen/sources_1/bd/vio/ipshared/122e/hdl/verilog" "+incdir+../../../../shiftreg_vioila.gen/sources_1/bd/vio/ipshared/46fd/hdl" \
"../../../bd/vio/ip/vio_vio_0_0/sim/vio_vio_0_0.v" \
"../../../bd/vio/sim/vio.v" \


vlog -work xil_defaultlib \
"glbl.v"

