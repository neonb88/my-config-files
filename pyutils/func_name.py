import sys

def f():
    import sys
    print sys._getframe().f_code.co_name
class C():
    def f_ob(self):
        print sys._getframe().f_code.co_name

if __name__=='__main__':
    f()
    o=C(); o.f_ob()
