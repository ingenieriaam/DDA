# -*- coding: utf-8 -*-
import cocotb
from cocotb.clock import Clock
from cocotb.triggers import Timer
from cocotb.regression import TestFactory

def initial_condition(dut):
    PERIOD = 10
    dut.i_data1 = 0
    dut.i_data2 = 0
    dut.o_mul = 0
    return PERIOD

@cocotb.test()
async def singular_values(dut):
    PERIOD=initial_condition(dut)
    await Timer(20*PERIOD, units='ns')

    singular=[float('nan'),float('inf'),-1.0*float('inf'),0.0]
    dut.i_data1 = 1
    dut.i_data2 = 1
    dut.o_mul = 1

    await Timer(20*PERIOD, units='ns')

""" # Register the test.
factory = TestFactory(run_test)
factory.generate_tests() """
    