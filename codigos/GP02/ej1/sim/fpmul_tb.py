# -*- coding: utf-8 -*-
import cocotb
from cocotb.clock import Clock
from cocotb.triggers import Timer
from cocotb.regression import TestFactory
from cocotb.binary import BinaryValue
from cocotb.types import Logic,Array,LogicArray
import float_custom as fc 
import numpy

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
    singular_bits =["1111110000000","0111100000000","1111100000000","0011100000000","1011100000000"]
    
    for i in range(len(singular_bits)):
        for j in range(len(singular_bits)):

            dut.i_data1.value = int(singular_bits[i], 2)
            dut.i_data2.value = int(singular_bits[j], 2)
            await Timer(PERIOD, units='ns')
            
            dut._log.debug("data1= %s | data2= %s" %(fc.bin2custom_float(singular_bits[i],4,8),fc.bin2custom_float(singular_bits[j],4,8)))
            result=fc.bin2custom_float(dut.o_mul.value.binstr,4,8)
            dut._log.debug("result= %s => %s\n" %(result,dut.o_mul.value))

            assert str(result) == str(singular_float[i]*singular_float[j]),"FAIL: o_mul must be {out} and was {res}".format(
                            res=result,out=singular_float[i]*singular_float[j])


@cocotb.test()
async def extreme_values(dut):
    PERIOD=initial_condition(dut)
    await Timer(20*PERIOD, units='ns')

    singular_float=[float('nan'),float('inf'),-1.0*float('inf'),0.0,-0.0]

    inputs =["0000110000000","0001110000000","1111110000010"]

    for i in range(len(inputs)):
        dut.i_data1.value = int(inputs[i], 2)
        dut.i_data2.value = int(inputs[i], 2)
        await Timer(PERIOD, units='ns')
            
        dut._log.info("data1= %s | data2= %s" %(fc.bin2custom_float(inputs[i],4,8),fc.bin2custom_float(inputs[i],4,8)))
        result=fc.bin2custom_float(dut.o_mul.value.binstr,4,8)
        dut._log.info("result= %s => %s\n" %(result,dut.o_mul.value))

        singular_output=False

        for value in singular_float: 
            if (result == value):
                dut._log.info("result= %s => Value %s\n" %(result,value))
                singular_output=True
                break
    
        if (not singular_output):
            assert False,"FAIL: o_mul must be a singular value and was {res}".format(res=result)




@cocotb.test()
async def random_values(dut):
    PERIOD=initial_condition(dut)
    await Timer(20*PERIOD, units='ns')

    inputs =[]

    # Number of iterations
    n_cases=5

    # Number of bits
    n_bits=13
    
    lower_limit=0.9
    upper_limit=1.1

    for i in range(n_cases):

        inputs.append(fc.custom_float_rand(n_bits))

        #zero_negative_limit =-6.103515625e-05 #100000000001
        #zero_positive_limit = 6.103515625e-05 #000000000001
        singular_float=[float('nan'),float('inf'),-1.0*float('inf'),0.0,-0.0]


    for i in range(len(inputs)):
        for j in range(len(inputs)):

            dut.i_data1.value = int(inputs[i], 2)
            dut.i_data2.value = int(inputs[j], 2)
            await Timer(PERIOD, units='ns')
                
            dut._log.info("Data 1= %s | Data 2= %s" %(fc.bin2custom_float(inputs[i],4,8),fc.bin2custom_float(inputs[j],4,8)))
            result=fc.bin2custom_float(dut.o_mul.value.binstr,4,8)
            test_result=fc.bin2custom_float(inputs[i],4,8)*fc.bin2custom_float(inputs[j],4,8)

            dut._log.info("Result= %s => Test Result %s\n" %(result,test_result))

            # Will be used when singular output is detected
            singular_output=False

            for value in singular_float: 
                if (result == value):
                    dut._log.warning("Last result is a singular value, not tested here\n")
                    singular_output=True
                    break
                        
            if (not singular_output):

                #Check if output sign is correct
                assert (numpy.sign(test_result) == numpy.sign(result)),"FAIL: o_mul has wrong sign"

                #10% of obtained value is tolerated because rounding method implmented
                assert (abs(result*lower_limit) < abs(test_result) < abs(result*upper_limit)),"FAIL: o_mul must be a value between {lower_limit} | {upper_limit} and it was {res}".format(
                                    res=result,lower_limit=test_result*lower_limit,upper_limit=test_result*upper_limit)



""" # Register the test.
factory = TestFactory(run_test)
factory.generate_tests() """
    