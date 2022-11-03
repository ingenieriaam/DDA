# -*- coding: utf-8 -*-
import cocotb
from cocotb.clock import Clock
from cocotb.triggers import Timer
from cocotb.regression import TestFactory

import scipy as sp
import numpy as np

bits = 16
rang = 2**(bits-1)

@cocotb.test()
async def run_test(dut):
    PERIOD = 10
    cocotb.fork(Clock(dut.clk, PERIOD, 'ns').start(start_high=True))

    dut.o_y.value = 0
    dut.i_x.value = 0
    dut.i_rst.value = 1 

    await Timer(5*PERIOD, units='ns')

    dut.i_rst.value = 0
    await Timer(PERIOD, units='ns')
    dut._log.info("NTAPS: %d" %(dut.NTAPS.value))
    ref=float(-1*rang)
    refq=ref/rang
    x=np.array([refq for i in range(8)])
    h=np.array([float(dut.i_h[i].value)/ rang for i in range(dut.NTAPS.value)])
    a=np.array([1.,0.,0.,0.])

    y2=sp.signal.lfilter(h,a,x)
    dut._log.info("differential eq output:")
    dut._log.info(y2)
    o_y=[]
    for i in range(len(x)):
        dut.i_x.value =int(ref)
        await Timer(PERIOD, units='ns')
        # check for another std values like X,U,Z.
        if str(dut.o_y.value).isdigit():
            dut._log.info("Y @cycle %d = %f" %(i, (dut.o_y.value.signed_integer/rang) ))
            o_y.append((dut.o_y.value.signed_integer/rang))
        else:
            dut._log.info("Y @cycle %d = %s" %(i, dut.o_y.value ))

    dut._log.info("DUT output:")
    dut._log.info(o_y)

    