onbreak {quit -force}
onerror {quit -force}

asim +access +r +m+vio -L xil_defaultlib -L unisims_ver -L unimacro_ver -L secureip -O5 xil_defaultlib.vio xil_defaultlib.glbl

do {wave.do}

view wave
view structure

do {vio.udo}

run -all

endsim

quit -force
