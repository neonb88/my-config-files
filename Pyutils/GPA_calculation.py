from pprint import pprint as p

with open('/home/n/GPA_calculation__python_input.txt', 'r') as fp:
  lines=fp.readlines()
lines=lines[1:]   # header info ("pts   GPA")
lines=lines[:-2]  # comments ("These are my Computer Science classes only.  (for major GPA calculation)")
p(lines)
tot=0
tot_pts=0

for line in lines:
  pts,GPA=line.split('  ')
  pts=float(pts)
  GPA=float(GPA)
  tot_pts+=pts
  tot+=pts*GPA

tot /=tot_pts
print("tot: ", tot) # finally,     tot: 3.2236111111111114

































































































