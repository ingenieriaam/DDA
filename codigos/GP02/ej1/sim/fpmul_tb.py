# -*- coding: utf-8 -*-
import cocotb
from cocotb.clock import Clock
from cocotb.triggers import Timer
from cocotb.regression import TestFactory
from cocotb.binary import BinaryValue
from cocotb.types import Logic,Array,LogicArray
import float_custom as fc 

def initial_condition(dut):
    PERIOD = 10
    dut.i_data1.value = 0
    dut.i_data2.value = 0
    dut.o_mul.value = 0
    return PERIOD

@cocotb.test()
async def singular_values(dut):
    PERIOD=initial_condition(dut)
    await Timer(20*PERIOD, units='ns')

    singular_float=[float('nan'),float('inf'),-1.0*float('inf'),0.0,-0.0]
    singular_bits =["1111110000000","0111100000000","1111100000000","0000000000000","1000000000000"]
    
    for i in range(len(singular_bits)):
        for j in range(len(singular_bits)):

            dut.i_data1.value = int(singular_bits[i], 2)
            dut.i_data2.value = int(singular_bits[j], 2)
            await Timer(PERIOD, units='ns')
            
            dut._log.info("data1= %s | data2= %s" %(fc.bin2custom_float(singular_bits[i],4,8),fc.bin2custom_float(singular_bits[j],4,8)))
            result=fc.bin2custom_float(dut.o_mul.value.binstr,4,8)
            dut._log.info("result= %s => %s\n" %(result,dut.o_mul.value))

            assert str(result) == str(singular_float[i]*singular_float[j]),"FAIL: o_mul must be {out} and was {res}".format(
                            res=result,out=singular_float[i]*singular_float[j])

""" # Register the test.
factory = TestFactory(run_test)
factory.generate_tests() """
    