# python2:
#!/bin/env/python2
import sys

def encode(string):
  encoded=''
  for char in string:
    if char in 'ABCDEFGHIJKLMNOPQRSTUVWXYZ':
      encoded+=chr(ord(char)+2)
    elif char in 'abcdefghijklmnopqrstuvwxyz':
      encoded+=chr(ord(char)-3)
    else: # I meant for this just to be numbers, but a few other characters hit this block too.
      encoded+=chr(ord(char)+1)
  return encoded
if __name__=="__main__":
  passwd=sys.argv[1]
  print(encode(passwd))
