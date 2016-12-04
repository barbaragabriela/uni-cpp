import datetime
import os


total = 0
for i in range(10):
    start = datetime.datetime.now()
    # os.system('minizinc -a scheduling.mzn scheduling.dzn -o output.txt')
    os.system('minizinc scheduling.mzn scheduling.dzn')
    end = datetime.datetime.now()
    delta = end - start
    total += int(delta.total_seconds() * 1000)

print total/10