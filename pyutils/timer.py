import os
import sys

if __name__=="__main__":
  if len(sys.argv)==1:
    num_secs=None
  else: # (if len(sys.argv) > 1:
    num_secs=int(sys.argv[1])
  print('\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n')
  os.system('echo "timestamp:"')
  os.system('date')
  num_newlines = 10
  for i in range(num_newlines):
      print()
      os.system('sleep 0.01')

  print("will go off after")
  print(num_secs); print("="*99)
  print('for your convenience:')
  print('conversions: 1  hr    =   3600')
  print('             3  hrs   =  10800')
  print('             30 min   =   1800')
  print('             15 min   =    900')
  print('             5  min   =    300')
  print('\n\n')
  if not num_secs:
    num_secs = int(input('hi, please input a number of seconds to sleep\n'))
  print('\n\n')

  for i in range(num_secs):
      if i % 60 == 0:
          print('{:4d} minutes have passed'.format(i // 60))
      os.system('sleep 1')

  vid="/home/n/Music/Shia_1_hr.mp4"
  os.system('xdg-open '+vid)

