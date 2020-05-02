
from math import sqrt

def f(x):
    try:
        s=sqrt(x)
        print s
        return s
    except ValueError:
        print 'don\'t give f a neg num, you retard'
if __name__=='__main__':
    f(1)
    f(-1)

