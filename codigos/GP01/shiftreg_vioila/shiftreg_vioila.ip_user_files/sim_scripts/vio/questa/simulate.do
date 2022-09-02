onbreak {quit -f}
onerror {quit -f}

vsim -lib xil_defaultlib vio_opt

do {wave.do}

view wave
view structure
view signals

do {vio.udo}

run -all

quit -force
