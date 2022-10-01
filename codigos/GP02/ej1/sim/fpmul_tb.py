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
    for i in singular:
        for j in singular:
            dut._log.debug("%f = %f * %f\n" %(i*j,i,j))
            dut.i_data1.value = i
            dut.i_data2.value = j
            await Timer(PERIOD, units='ns')
            assert dut.o_mul.value == i*j, "FAIL: o_mul must be {out} and was {res}".format(
                            out=dut.o_mul,res=i*j)

""" # Register the test.
factory = TestFactory(run_test)
factory.generate_tests() """
    