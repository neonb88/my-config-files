class C:
    """A simple example class"""
    i = 12345

    def f(self):
        return 'hello world'

class P(object):
    pass

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
    """

    print(type(f()) ==
            type(P()))


#<class '__main__.P'>






























































