# -*- coding: utf-8 -*-
import cocotb
from cocotb.clock import Clock
from cocotb.triggers import Timer
from cocotb.regression import TestFactory

import scipy as sp
import numpy as np

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
    x=np.array([-1., -1., -1., -1., -1., -1., -1., -1.])
    h=np.array([float(dut.i_h[0].value),float(dut.i_h[1].value),float(dut.i_h[2].value),float(dut.i_h[3].value)])
    a=np.array([1.,0.,0.,0.])

    y2=sp.signal.lfilter(h,a,x)
    y2=y2.astype(int)
    dut._log.info("differential eq output:")
    dut._log.info(y2)
    o_y=[]
    for i in range(dut.NTAPS.value*2):
        dut.i_x.value =-1
        await Timer(PERIOD, units='ns')
        # check for another std values like X,U,Z.
        if str(dut.o_y.value).isdigit():
            dut._log.info("Y @cycle %d = %f" %(i, (dut.o_y.value.signed_integer/2**15) ))
            o_y.append(dut.o_y.value.signed_integer)
        else:
            dut._log.info("Y @cycle %d = %s" %(i, dut.o_y.value ))

    dut._log.info("DUT output:")
    dut._log.info(o_y)

    