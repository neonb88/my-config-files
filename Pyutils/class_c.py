class C:
    """A simple example class"""
    i = 12345

    def f(self):
        return 'hello world'

class P(object):
    pass

class O(object):
    i = 12345

class T(object):
    def __init__(self):
        print '__init__'
    def other(self):
        print 'other'

"""
class A(object):
# __init__(self,x) doesn't work
    def __init__(self, x):
        print '__init__'
        print x
    def other(self):
        print 'other'
"""

def f():
    return P()

if __name__=='__main__':
    """
    obj = C()
    print(type(obj))
    obj = P()
    print(type(obj))
    print(type(f()))
    print(type(type(f())))    # type is type

    print(type(f()) == "<class '__main__.P'>")  # False

    print(type(f()) ==
            type(P()))
    print(C().i)
    print(O().i)  # both work
    t=T()
    t.other()
    """
    a=A()
    a.other()


#<class '__main__.P'>






























































