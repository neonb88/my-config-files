import glob
import os
import sys
import numpy as np
import time

if __name__=="__main__":
  t=8*60+35 # American Pie is 8:35 long.  This is the longest regular music (ie. excluding Guardians of the Galaxy Awesome Mix and Shostakovich, Taking You Higher mixes, etc.)
  #t=2
  sound_fnames = glob.glob('./*.mp*')
  np.random.shuffle(sound_fnames) # shuffle() mutates the input.
  for fname in sound_fnames:
    tmp=fname
    #hit=False
    #print('\n'+fname)
    if ' ' in tmp:
      tmp=tmp.replace(' ', '\ ')
    if '(' in tmp:
      tmp=tmp.replace('(', '\(')
    if ')' in tmp:
      tmp=tmp.replace(')', '\)')
    if '&' in tmp:
      tmp=tmp.replace('&', '\&')
    """
    # There was some issue with this code; I manually removed all the apostrophes rather than debugging it.  Pretty brute-force, but absolutely fine for this case (ie. stupid implementation of a music player).
    if "'" in tmp:
      tmp=tmp.replace("'", "\'")
      hit=True
      print("single quote")
    if '"' in tmp:
      tmp=tmp.replace('"', '\"')
      hit=True
      print("double quote")
    if hit:
      print("hit")
      print(tmp)
    """
    #os.system('xdg-open '+tmp)
    os.system('vlc '+tmp)
    time.sleep(t)
