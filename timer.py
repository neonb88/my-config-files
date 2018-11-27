import os

print('\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n')
os.system('echo "timestamp:"')
os.system('date')
num_newlines = 10
for i in range(num_newlines):
    print()
    os.system('sleep 0.01')

print('for your convenience:')
print('conversions: 1  hr    =   3600')
print('             3  hrs   =  10800')
print('             30 min   =   1800')
print('             15 min   =    900')
print('             5  min   =    300')
print('\n\n')
num_secs = int(input('hi, please input a number of seconds to sleep\n'))
print('\n\n')

for i in range(num_secs):
    if i % 60 == 0:
        print(str(i // 60) + ' minutes have passed')
    os.system('sleep 1')

os.system('xdg-open CAPTIAN_JACK.mp3')

