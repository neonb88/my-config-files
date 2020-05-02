


from cStringIO import StringIO
import sys

def f():
  print 'hi from func f()'

old_stdout = sys.stdout
sys.stdout = mystdout = StringIO()

# blah blah lots of code ...
print 'hello world'
f()

sys.stdout = old_stdout
print(mystdout.getvalue())

# examine mystdout.getvalue()


