import time

i           = 0
step        = 1
granularity = int(input("please input an integer step size for the timer:  "))
while True:
    if i % granularity == 0:
        secs = i  % 60
        mins = i // 60
        if secs < 10:
            print(str(mins)+" mins and "+str(secs)+"  secs passed")
        else:
            print(str(mins)+" mins and "+str(secs)+ " secs passed")
    i += step
    time.sleep (step)

