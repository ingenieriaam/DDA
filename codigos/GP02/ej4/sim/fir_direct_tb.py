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
    dut.i_rst.value = 1 

    await Timer(5*PERIOD, units='ns')
    dut.i_rst.value = 0
    for i in range(dut.NTAPS.value):
        dut.i_x.value = 1
        await Timer(PERIOD, units='ns')
        dut._log.info("Y @cycle %d = %f" %(i, (dut.o_y.value.signed_integer/2**15) ))


    