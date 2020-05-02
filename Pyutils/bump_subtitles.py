import math
#================================================================
def parse_time(line,offset):
  num_secs_offset=int(line[:2])*3600+int(line[3:5])*60+int(line[6:8]) + offset
  millisecs=int(line[9:12])
  # hours
  hours=int(math.floor(num_secs_offset/3600.))
  num_secs_offset-=hours*3600
  if hours < 10:
    hours='0'+str(hours)
  else:
    hours=str(hours)
  # mins
  mins=int(math.floor(num_secs_offset/60.))
  num_secs_offset-=mins*60
  if mins < 10:
    mins='0'+str(mins)
  else:
    mins=str(mins)
  # seconds
  if num_secs_offset < 10:
    secs='0'+str(num_secs_offset)
  else:
    secs=str(num_secs_offset)
  if millisecs < 10:
    millisecs='00'+str(millisecs)
  elif millisecs < 100:
    millisecs='0'+str(millisecs)
  else:
    millisecs=str(millisecs)
  return hours,mins,secs,millisecs
#================================================================



if __name__=="__main__":
  # TODO: use sys.argv instead of hardcoded filenames.
  # TODO: 
  with open('1.-Pirates_of_the_Caribbean_At_World\'s_End.srt') as infile:
    lines=infile.readlines()

  offset=10 # TODO change for each srt file

  with open('POTC_3_subtitles.srt','wb') as outfile:
    for line in lines:
      if '-->' not in line:
        outfile.write(line)
      else:
        hours,mins,secs,millisecs=parse_time(line,offset)
        shifted=hours+':'+mins+':'+secs+','+millisecs+' --> '
        # 2nd number in the line (when this subtitle should stop displaying)
        hours,mins,secs,millisecs=parse_time(line[17:],offset)
        shifted+=hours+':'+mins+':'+secs+','+millisecs+'\n'
        outfile.write(shifted)

