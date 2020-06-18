import sys
import time

i           = 0
step        = 1 # NOTE:  why is step = 1?   Should it be   "`STEP`"  for a constant?


if len(sys.argv) == 1:
  granularity = int(input("please input an integer step size for the timer:  "))
elif len(sys.argv) == 2:
  granularity = int(sys.argv[1])
elif len(sys.argv) == 3:
  granularity = int(sys.argv[1])
  i           = int(sys.argv[2])  # I didn't document what this 'i' does;       -nxb, June 17, 2020    at 7:05 P.M. EDT.



while True:
  if i % granularity == 0:
    secs = i  % 60
    mins = i // 60
    print(str(mins)+" mins and  "+str(secs)+" secs passed")
  i += step
  time.sleep (step)

