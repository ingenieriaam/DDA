# -*- coding: utf-8 -*-
import cocotb
import random
import math

from cocotb.clock import Clock
from cocotb.triggers import Timer
from cocotb.regression import TestFactory
import diffeq_model as mod

def initial_condition(dut):
    PERIOD = 10
    cocotb.fork(Clock(dut.clk, PERIOD, 'ns').start(start_high=False))

    dut.o_y.value = 0
    dut.i_x.value = 0
    dut.i_rst.value = 1
    return PERIOD

@cocotb.test()
async def trivial_test(dut):
    PERIOD=initial_condition(dut)
    await Timer(20*PERIOD, units='ns')
    dut.i_rst = 0

    #Run 16 repetitions of the test
    for repetitions in range(16):
        # Generate random input vector
        x=[]
        min= -1*int(math.pow(2,15)//2)
        max=int((math.pow(2,15)//2)-1)
        dut._log.debug("Min = %d | Max = %d" %(min,max))
        x = [random.randint(min, max) for x in range(4)]
        # Take the output vector with the filter model
        y_result=[0,0,0,0]
        y_expected=mod.diffeq_model(x,y_result)
        # Load of UUT outputs
        for i in range(4):
            dut.i_x.value=x[i]
            await Timer(PERIOD, units='ns')
            y_result[i]=dut.o_y.value.integer
        # Automatic results check
        dut._log.debug(" y_expected: {ye}\n y_result: {yr}".format(ye=y_expected ,yr=y_result))
        for i in range(4):
            assert y_result[i] == y_expected[i], "FAIL: o_y[{i}] must be {esp} and was {o_y}".format(
                            i=i,esp=y_expected[i],o_y=dut.o_y.value.integer)
        dut._log.info("test instance n°: %d | PASS" %repetitions)

""" # Register the test.
factory = TestFactory(run_test)
factory.generate_tests() """
    