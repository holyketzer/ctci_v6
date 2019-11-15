import sys
import time

started = time.time()
k = int(sys.stdin.readline().strip())

d = {}

for i in range(101):
  d[str(i)] = 0

for l in range(k):
  line = sys.stdin.readline().strip()

  arr = line.split(' ')
  arr.pop(0)

  for v in arr:
    d[v] += 1

# print "parsing done in:", time.time() - started
# print d

for i in range(101):
  v = str(i)
  if v in d:
    for j in range(d[v]):
      print i,
      # pass

sys.stdout.write("\n")
