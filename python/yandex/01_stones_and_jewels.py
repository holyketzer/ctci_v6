import sys

jewels = {}

for j in sys.stdin.readline().strip():
  jewels[j] = True

res = 0

for s in sys.stdin.readline().strip():
  if s in jewels:
    res += 1

print res
