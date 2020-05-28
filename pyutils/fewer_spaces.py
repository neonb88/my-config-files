import sys

print(sys.version_info)
print(sys.version_info[0])
print(sys.version_info[1])
for i in range( int(sys.argv[1])   ):
  if sys.version_info[0] ==2:
    print
  if 3==sys.version_info[0] :
    print()
