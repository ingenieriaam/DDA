""" 
casos donde da != a NaN
inf = inf * inf
-inf = inf * -inf
-inf = -inf * inf
inf = -inf * -inf
0.000000 = 0.000000 * 0.000000
resto de los casos NaN
"""
#import numpy as np
import random

def values_reference():
    singular=[float('nan'),float('inf'),-1.0*float('inf'),0.0]
    for i in singular:
        for j in singular:
            print("%f = %f * %f\n" %(i*j,i,j))

def bin2custom_float(num,exp_bits,mant_bits):
    """Function to convert using a custom float format

    Args:
        num (str): binary number to convert to float
        exp_bits (int): number of exponent bits
        mant_bits (int): number of mantissa bits

    Returns:
        float: float number
    """
    # string num to "bit" array

    debug=0
    inf_exp  = [1 for i in range(exp_bits)]
    inf_mant = [0 for i in range(mant_bits)]
    nan_mant = [0 for i in range(mant_bits)]
    nan_mant[0] = 1

    binary=[]
    for i in num:
        binary.append(int(i))

    sign     = -1 if binary[0] else 1
    exponent = binary[1:exp_bits+1]
    mantissa = binary[exp_bits+1:exp_bits+mant_bits+1]

    f_mant_array = [mantissa[i]*2**(-i-1) for i in range(len(mantissa))]
    f_mant       = sum(f_mant_array)
    l=len(exponent)
    print("f_mant_array %f" %sum(f_mant_array)) if debug else 0
    print("f_mant %f" %f_mant)                  if debug else 0

    f_exp_array  = [exponent[l-1-i]*2**(i) for i in range(l)]
    f_exp        = sum(f_exp_array)-(((2**exp_bits)/2)-1)

    print("f_exp_array %f" %sum(f_exp_array))   if debug else 0
    print("f_exp %f" %f_exp)                    if debug else 0


    if inf_exp==exponent and inf_mant==mantissa:
        custom_float= float('inf') if sign==1 else -1.0*float('inf')
    elif sign==-1 and inf_exp==exponent and nan_mant==mantissa:
        custom_float= float('nan')
    else:
        custom_float=sign*f_mant*2**(f_exp)
    return float(custom_float)

def custom_float_rand(total_bits):
    bits=['0','1']
    randf = [random.choice(bits) for x in range(total_bits)]

    return ''.join(randf)