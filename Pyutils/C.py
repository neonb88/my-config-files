
class C():
    #d=None
    #rad=None
    def __init__(self):
        self.d={}
        self.rad = 2
    def p(self):
        ''' prints '''
        print self.d
        print self.rad
    def q(self):
        print 'q'
        self.p()
    def r(self):
        p(self)

if __name__=='__main__':
    o=C()
    o.r()
