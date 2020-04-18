import numpy as np
import itertools
from time import sleep
#==============================================

'''
  NXB:
    How do **I** a solve a sudoku?
       1. Check for "easy" numbers to pick up/off
          a. How do I teach the machine a heuristic for this???
       2. Pick a number 1-9, and see whether I can find another instance of that number that should go in a blank space.
          a.  See whether there are 4 other numbers that exist in the same rows/cols that your box takes up
            1) if there are 4, you automatically know a new number to fill in a blank space.
          b.
          c.
          d.
       3. Write all possible numbers that could go in a particular blank space
       4. Use logic from 3 (ie. where **MUST** there be a particular number?  (16 16)   )
       5. Check updates from the most recent number I wrote in before I re-do old work.
       6. Search for positions that would force numbers to reveal interesting clues.
          a.  ie. 1 2 3 
                  
                  7   9
          b.
          c.
          d.
          e.

          --2 76- 5--
          195 -2- --7
          467 -5- -8-

          --- -82 753
          -53 -17 84-
          7-8 53- ---

          -7- -4- --5
          5-6 -7- 419
          --4 -95 -78





          checked
            1s
              -11 in box 4.
              ---
              ---

              --- in box 6.
              ---
              1-1

              --1 in box 7.
              ---
              -1-




            2s



              --- in box 4.
              2--
              -2-



              2-- in box 8.
              2--
              2--






            3s
              2-- in box 8.
              2--
              2--




            4s

              --- in box 2.
              4-4
              ---


              -4- in box 4.
              ---
              -4-



              4-- in box 5.
              ---
              --4







            5s
              Done




            6s
              ---
              66-
              ---




            7s
              Done



            8s
              There were a few 2-choices



            9s
              --9 in box 2.
              ---
              --9

              -9- in box 3.
              ---
              9--

              9-- in box 5.
              9--
              ---

              --- in box 6.
              ---
              99-

              9-9 in box 7.
              ---
              ---


              There were a few where I narrowed it down to 2 potential places a num could be.


       7. Check for rows/cols/boxes which are almost done (6-7 already filled out) .
       8.
       9.
      10.
      11.
      12.
      13.
      14.
      15.
      16.
      17.
      18.
'''









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
def get(seed=None):
  '''
    Make a random sudoku puzzle

    TODO: speed this up.  This is a very very brute-force approach.
  '''
  puzz  = np.zeros((0,9), dtype='int64')

  # Seed randomly
  if not seed:
    max_seed= ( (2**32) - 3 ) # https://docs.scipy.org/doc/numpy-1.14.0/reference/generated/numpy.random.uniform.html
    seed  = int ( round ( np.random.uniform( high= max_seed) ) )
    # NOTE: the seed has to start from a random place to ensure we get a different sudoku each time we run the algorithm.

  init_seed=seed
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
  return (puzz, init_seed)
#==============================================

#==============================================
def valid(puzz):
  '''
    Checks whether the current 9x9 values in the sudoku puzzle    are (so far) a valid sudoku
  '''
  return rows_ok(puzz) and cols_ok(puzz) and boxes_ok(puzz)
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
def boxes_ok(puzz):
  '''
    Checks whether all 3x3 squares are valid

    Input :
      puzz.shape == (n,9)

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
  get()
#==============================================









