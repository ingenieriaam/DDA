set_property -dict {PACKAGE_PIN E3 IOSTANDARD LVCMOS18} [get_ports clock]
create_clock -period 10.000 -name sys_clk_pin -waveform {0.000 5.000} -add [get_ports clock]

set_property PACKAGE_PIN V14 [get_ports {i_sampleA[5]}]
set_property PACKAGE_PIN T13 [get_ports {i_sampleA[4]}]
set_property PACKAGE_PIN U13 [get_ports {i_sampleA[3]}]
set_property PACKAGE_PIN T9 [get_ports {i_sampleA[2]}]
set_property PACKAGE_PIN T10 [get_ports {i_sampleA[1]}]
set_property PACKAGE_PIN R10 [get_ports {i_sampleA[0]}]
set_property PACKAGE_PIN U11 [get_ports {i_sampleB[5]}]
set_property PACKAGE_PIN U12 [get_ports {i_sampleB[4]}]
set_property PACKAGE_PIN V12 [get_ports {i_sampleB[3]}]
set_property PACKAGE_PIN V10 [get_ports {i_sampleB[2]}]
set_property PACKAGE_PIN V11 [get_ports {i_sampleB[1]}]
set_property PACKAGE_PIN U14 [get_ports {i_sampleB[0]}]
set_property PACKAGE_PIN T14 [get_ports {o_mult[10]}]
set_property PACKAGE_PIN T15 [get_ports {o_mult[9]}]
set_property PACKAGE_PIN R16 [get_ports {o_mult[8]}]
set_property PACKAGE_PIN T16 [get_ports {o_mult[7]}]
set_property PACKAGE_PIN V15 [get_ports {o_mult[6]}]
set_property PACKAGE_PIN V16 [get_ports {o_mult[5]}]
set_property PACKAGE_PIN U17 [get_ports {o_mult[4]}]
set_property PACKAGE_PIN U18 [get_ports {o_mult[3]}]
set_property PACKAGE_PIN U16 [get_ports {o_mult[2]}]
set_property PACKAGE_PIN V17 [get_ports {o_mult[1]}]
set_property PACKAGE_PIN T11 [get_ports {o_mult[0]}]
set_property IOSTANDARD LVCMOS18 [get_ports {i_sampleA[5]}]
set_property IOSTANDARD LVCMOS18 [get_ports {i_sampleA[4]}]
set_property IOSTANDARD LVCMOS18 [get_ports {i_sampleA[3]}]
set_property IOSTANDARD LVCMOS18 [get_ports {i_sampleA[2]}]
set_property IOSTANDARD LVCMOS18 [get_ports {i_sampleA[1]}]
set_property IOSTANDARD LVCMOS18 [get_ports {i_sampleA[0]}]
set_property IOSTANDARD LVCMOS18 [get_ports {i_sampleB[5]}]
set_property IOSTANDARD LVCMOS18 [get_ports {i_sampleB[4]}]
set_property IOSTANDARD LVCMOS18 [get_ports {i_sampleB[3]}]
set_property IOSTANDARD LVCMOS18 [get_ports {i_sampleB[2]}]
set_property IOSTANDARD LVCMOS18 [get_ports {i_sampleB[1]}]
set_property IOSTANDARD LVCMOS18 [get_ports {i_sampleB[0]}]
set_property IOSTANDARD LVCMOS18 [get_ports {o_mult[10]}]
set_property IOSTANDARD LVCMOS18 [get_ports {o_mult[9]}]
set_property IOSTANDARD LVCMOS18 [get_ports {o_mult[8]}]
set_property IOSTANDARD LVCMOS18 [get_ports {o_mult[7]}]
set_property IOSTANDARD LVCMOS18 [get_ports {o_mult[6]}]
set_property IOSTANDARD LVCMOS18 [get_ports {o_mult[5]}]
set_property IOSTANDARD LVCMOS18 [get_ports {o_mult[4]}]
set_property IOSTANDARD LVCMOS18 [get_ports {o_mult[3]}]
set_property IOSTANDARD LVCMOS18 [get_ports {o_mult[2]}]
set_property IOSTANDARD LVCMOS18 [get_ports {o_mult[1]}]
set_property IOSTANDARD LVCMOS18 [get_ports {o_mult[0]}]
