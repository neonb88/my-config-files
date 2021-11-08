from collections import OrderedDict




#===================================================================================================
def last_word(str_):
  for i in range(len(str_)-1, -1, -1):
    if str_[i] == ' ':
      return str_[i+1:]
  raise Exception("dumbass, don't use the function in the wrong context, lol.   >:-)  ")
#===================================================================================================


#===================================================================================================
def last_non_space_char_idx(str_):
  '''
    returns last char that isn't a space    (' ')
  '''
  for i in range(len(str_)-1, -1, -1):
    if str_[i] != ' ':
      return i+1   # NOTE: +1 is for encapsulating (hiding) implementation details we don't want to think about or remember later
  raise Exception("dumbass, don't use the function in the wrong context, lol.   >:-)  ")
#===================================================================================================




#===================================================================================================
def is_number_in_line(str_):
  return\
    '0' in str_ or\
    '1' in str_ or\
    '2' in str_ or\
    '3' in str_ or\
    '4' in str_ or\
    '5' in str_ or\
    '6' in str_ or\
    '7' in str_ or\
    '8' in str_ or\
    '9' in str_
#===================================================================================================





"""
test_str='1.  Julianna Salak    '
extracted=test_str[:last_non_space_char_idx(test_str)+1]
print('='*99)
print(extracted)
print(extracted[-1] == ' ')
print('='*99)


print('abcdefghijklmnopqrstuvwxyz')
"""



#===================================================================================================
# parse:
lines = open('/home/n/attendance_CISC101.txt').readlines()
lines_=[]
attendance_dict=OrderedDict()
date = None
todays_attendance=[]
for line in lines:                # It's fine if "excused" is in the line
  if '2021' in line:
    if todays_attendance:
      attendance_dict[date]= sorted(todays_attendance, key=last_word)
    date = line         # should last until we see another line w/ "2021" in it
    todays_attendance=[]
  if ('____'        not in line and\
    'super polite'  not in line and\
    'not'           not in line and\
    'attendance'    not in line and\
    '2021'          not in line and\
    0               != len(line)and\
    is_number_in_line(line)):

    # cut off newlines at the end
    line = line[:-1] 

    # cut spaces off end:
    """
    print(line)   # TODO: where's the '\n' newline at the end?  How can we detect?
    print(line[-1] == '\n')
    """
    todays_attendance.append(
      line[:last_non_space_char_idx(line)])
    #lines_.append(line[:last_non_space_char_idx(line)])
#===================================================================================================



#===================================================================================================
attendance_dict[date]= sorted(todays_attendance, key=last_word)     # never got to last date's processing
from pprint import pprint as p
p(attendance_dict)
#===================================================================================================













































