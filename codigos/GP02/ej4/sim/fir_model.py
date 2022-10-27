import scipy as sp
import numpy as np

def diffeq_4taps_model(x,h):
    """Calculus of outputs of a differential equation of 4 coefficients

    Args:
        x (int): filter input
        h (int): coefficients
    Returns:
        int: filtering signal
    """
    if len(h)!=4:
        print("h lenght must be 4")

    l=len(x)
    c=np.zeros(4)
    xc=np.concatenate((x,c ), axis=None)
    y=np.zeros(l+3)
    for i in range(l):
        y[i+3]=y[i+2]
        y[i+2]=y[i+1]
        y[i+1]=y[i+0]
        y[i] = xc[i]*h[0] + xc[i+1]*h[1] + xc[i+2]*h[2] + xc[i+3]*h[3]

    return y[0:l]

def test():
    x=np.array([1., 1., 1., 1., 1., 1., 1., 1.])
    h=np.array([float(0x001e),float(0x46b6),float(0x46b6),float(0x001e)])
    #h=np.array([1.,2.,3.,4.])
    hr=h[::-1]
    b=hr
    a=np.array([1.,0.,0.,0.])

    y2=sp.signal.lfilter(h,a,x)
    print("differential eq output:")
    print(y2)
    y=diffeq_4taps_model(x,h)
    print("scipy filter output:")
    print(y)


test()