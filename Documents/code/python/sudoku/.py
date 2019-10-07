import numpy as np
import itertools
from time import sleep
#==============================================










#==============================================
def pn(n=69): print('\n'*n)
#==============================================

#==============================================
def row(seed=None):
  '''
    Returns sudoku row in anumpy aray.
  '''
  if seed:
    np.random.seed(seed)
  return np.random.permutation(np.arange(9)+1).reshape((1,9))
#==============================================

#==============================================
c=col=r=row
#==============================================








#==============================================
def make(seed=None):
  '''
    Make a random sudoku puzzle
  '''
  puzz  = np.ones((0,9), dtype='int64')

  # Seed randomly
  if not seed:
    max_seed= ( (2**32) - 3 ) # https://docs.scipy.org/doc/numpy-1.14.0/reference/generated/numpy.random.uniform.html
    seed  = int ( round ( np.random.uniform( high= max_seed) ) )
    # NOTE: the seed has to start from a random place to ensure we get a different sudoku each time we run the algorithm.

  # Make rows:
  for i in range(9):
    make_more = True
    while make_more:
      curr  = row(seed)
      seed += 1
      new   = np.concatenate(  (puzz, curr),  axis=0  )
      make_more = not valid(new)
    puzz  = new
    pn(1)
    print("  shape: ",puzz.shape)
    print(puzz)
  print(puzz)
  raise Exception('implement "sqs_ok"')
#==============================================

#==============================================
def valid(puzz):
  '''
    Checks whether the current 9x9 values in the sudoku puzzle    are (so far) a valid sudoku
  '''
  return rows_ok(puzz) and cols_ok(puzz) and sqs_ok(puzz)
#==============================================

#==============================================
def rows_ok(puzz):
  Y,X = puzz.shape
  for row in range(Y):
    if not (np.unique(puzz[row]).size ==  X):
      return False
  return True
#==============================================

#==============================================
def cols_ok(puzz):
  '''
    There's just GOTTA be a way to make cols_ok and rows_ok the same function.
  '''
  Y,X = puzz.shape
  for col in range(X):
    if not (np.unique(puzz[:,col]).size ==  Y):
      return False
  return True
#==============================================










#==============================================
def sqs_ok(puzz):
  '''
    Input :
      puzz.shape == (n,9)

    3x3 squares must all be valid

    Based on the specific way we wrote the code, I'm adding a row at a time.  So the precondition for the puzzle entering this function is that the puzzle up til the previous row is a valid sudoku.
  '''
  Y,X = puzz.shape
  if Y in (1,4,7):
    # As long as this is a valid row, the 1st new row is fine,   b/c the row itself is valid
    return True

  # "s" is the   number of values in each square due to adding the latest row to the sudoku puzzle
  s=Y%3
  if s ==0:
    s=3
  s*=3
  if Y in (2,3):
    if not np.unique(puzz[ :3, :3]).size==s:
      return False
    if not np.unique(puzz[ :3,3:6]).size==s:
      return False
    if not np.unique(puzz[ :3,6:9]).size==s:
      return False
  elif Y in (5,6):
    if not np.unique(puzz[3:6, :3]).size==s:
      return False
    if not np.unique(puzz[3:6,3:6]).size==s:
      return False
    if not np.unique(puzz[3:6,6:9]).size==s:
      return False
  elif Y in (8,9):
    if not np.unique(puzz[6:9, :3]).size==s:
      return False
    if not np.unique(puzz[6:9,3:6]).size==s:
      return False
    if not np.unique(puzz[6:9,6:9]).size==s:
      return False

  return True
#==============================================












#==============================================
if __name__ ==  "__main__":
  make()
#==============================================









