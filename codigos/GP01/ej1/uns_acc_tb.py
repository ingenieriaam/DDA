# -*- coding: utf-8 -*-
import cocotb
import random
from cocotb.clock import Clock
from cocotb.triggers import Timer
from cocotb.regression import TestFactory

import math

""" output reg [5:0] o_data , //! Acc output
    output           o_carry, //! Carry output

    input      [2:0] i_data2, //! Data imput
    input      [2:0] i_data1, //! Data imput
    input      [1:0] i_sel  , //! Input selection signal """

def initial_condition(dut):
    PERIOD = 20
    cocotb.fork(Clock(dut.clk, PERIOD, 'ns').start(start_high=True))

    dut.o_data.value = 0
    dut.o_carry.value = 0
    dut.i_data2.value = 0
    dut.i_data1.value = 0
    dut.i_sel.value = 0
    dut.i_rst_n.value = 0
    return PERIOD

@cocotb.test()
async def one_increment_sel0(dut):
    PERIOD=initial_condition(dut)
    await Timer(20*PERIOD, units='ns')

    dut.i_rst_n.value = 1
    dut.i_sel.value = 0 # acc + idata2

    assert dut.o_data.value.integer == 0, "FAIL: o_data must be 0 and was {o_data}".format(o_data=dut.o_data.value.integer)
    await Timer(20*PERIOD, units='ns')
    max_count=int(math.pow(2,7))
    for i in range(max_count):
        dut.i_data2.value = 1
        dut.i_data1.value = random.randint(0, 7)
        await Timer(PERIOD, units='ns')
        check= i if i<64 else i-64
        if i==63:
            assert dut.o_carry.value.integer == 1, "FAIL: o_carry must be 1 and was {o_carry} for count {i}".format(
                    o_carry=dut.o_carry.value.integer,i=i)
        assert dut.o_data.value.integer == check, "FAIL: o_data must be {i} and was {o_data}".format(
            i=check, o_data=dut.o_data.value.integer)
        assert dut.o_data.value.integer < max_count, "FAIL: o_data must be minor than 127 and was {o_data}".format(
            i=check, o_data=dut.o_data.value.integer)

    await Timer(PERIOD, units='ns')
    assert dut.o_data.value.integer == 0, "FAIL: o_data must be 0 and was {o_data}".format(o_data=dut.o_data.value.integer)

@cocotb.test()
async def random_increment_sel1(dut):
    PERIOD=initial_condition(dut)
    await Timer(20*PERIOD, units='ns')

    dut.i_rst_n.value = 1
    dut.i_sel.value = 1 # acc + idata1 + i_data2

    assert dut.o_data.value.integer == 0, "FAIL: o_data must be 0 and was {o_data}".format(o_data=dut.o_data.value.integer)
    await Timer(20*PERIOD, units='ns')
    max_count=int(math.pow(2,7))
    internal_count=0

    for i in range(max_count):
        inc1 = random.randint(0, 7)
        inc2 = random.randint(0, 7)
        print("inc %d" % inc)
        dut.i_data1.value = inc1
        dut.i_data2.value = inc2
        await Timer((1+1e-4)*PERIOD, units='ns')
        internal_count += inc1+inc2
        internal_count = internal_count if internal_count<64 else internal_count-64
        print("internal_count %d i = %d" % (internal_count,i))
        if internal_count==63:
            assert dut.o_carry.value.integer == 1, "FAIL: o_carry must be 1 and was {o_carry} for count {i}".format(
                    o_carry=dut.o_carry.value.integer,i=internal_count)
        assert dut.o_data.value.integer == internal_count, "FAIL: o_data must be {i} and was {o_data}".format(
            i=internal_count, o_data=dut.o_data.value.integer)
        assert dut.o_data.value.integer < max_count, "FAIL: o_data must be minor than 127 and was {o_data}".format(
            i=internal_count, o_data=dut.o_data.value.integer)

@cocotb.test()
async def random_increment_sel2(dut):
    PERIOD=initial_condition(dut)
    await Timer(20*PERIOD, units='ns')

    dut.i_rst_n.value = 1
    dut.i_sel.value = 2 # acc + idata1

    assert dut.o_data.value.integer == 0, "FAIL: o_data must be 0 and was {o_data}".format(o_data=dut.o_data.value.integer)
    await Timer(20*PERIOD, units='ns')
    max_count=int(math.pow(2,7))
    internal_count=0

    for i in range(max_count):
        inc = random.randint(0, 7)
        print("inc %d" % inc)
        dut.i_data1.value = inc
        dut.i_data2.value = 1
        await Timer((1+1e-4)*PERIOD, units='ns')
        internal_count += inc
        internal_count = internal_count if internal_count<64 else internal_count-64
        print("internal_count %d i = %d" % (internal_count,i))
        if internal_count==63:
            assert dut.o_carry.value.integer == 1, "FAIL: o_carry must be 1 and was {o_carry} for count {i}".format(
                    o_carry=dut.o_carry.value.integer,i=internal_count)
        assert dut.o_data.value.integer == internal_count, "FAIL: o_data must be {i} and was {o_data}".format(
            i=internal_count, o_data=dut.o_data.value.integer)
        assert dut.o_data.value.integer < max_count, "FAIL: o_data must be minor than 127 and was {o_data}".format(
            i=internal_count, o_data=dut.o_data.value.integer)

@cocotb.test()
async def null_increment_sel3(dut):
    PERIOD=initial_condition(dut)
    await Timer(20*PERIOD, units='ns')

    dut.i_rst_n.value = 1
    dut.i_sel.value = 3 # acc + 0

    assert dut.o_data.value.integer == 0, "FAIL: o_data must be 0 and was {o_data}".format(o_data=dut.o_data.value.integer)
    await Timer(20*PERIOD, units='ns')
    max_count=int(math.pow(2,7))
    internal_count=0

    for i in range(max_count):
        inc = random.randint(0, 7)
        print("inc %d" % inc)
        dut.i_data1.value = inc
        dut.i_data2.value = inc
        await Timer((1+1e-4)*PERIOD, units='ns')
        internal_count += inc
        internal_count = internal_count if internal_count<64 else internal_count-64
        assert dut.o_data.value.integer == 0, "FAIL: o_data must be 0 and was {o_data}".format(
            o_data=dut.o_data.value.integer)
        assert dut.o_carry.value.integer == 0, "FAIL: o_carry must be 0 and was {o_carry}".format(
                    o_carry=dut.o_carry.value.integer)

""" # Register the test.
factory = TestFactory(run_test)
factory.generate_tests() """
    