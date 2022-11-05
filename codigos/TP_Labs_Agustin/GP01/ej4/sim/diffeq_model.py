def diffeq_model(x,y):
    """  
    x[n]=x[0]
    x[n-1]=x[1]
    """
    for i in range(len(x)):
        y[3]=y[2]
        y[2]=y[1]
        y[1]=y[0]
        y[0] = x[0] - x[1] + x[2] + x[3] + 0.5*y[1] + 0.25*y[2]
    return y

