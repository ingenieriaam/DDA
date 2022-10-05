# -*- coding: utf-8 -*-
import cocotb
from cocotb.clock import Clock
from cocotb.triggers import Timer
from cocotb.regression import TestFactory

@cocotb.test()
async def run_test(dut):
    PERIOD = 10
    cocotb.fork(Clock(dut.clk, PERIOD, 'ns').start(start_high=False))

    dut.o_y.value = 0
    dut.i_x.value = 0
    dut.i_rst.value = 0

    await Timer(20*PERIOD, units='ns')
    dut.i_rst.value = 1
    for i in range(4):
        dut.i_x.value.integer = 1
        await Timer(PERIOD, units='ns')
        dut._log.info("Y[%d] = %d" %(i,dut.o_y.value.integer))


    