import sys

n = int(sys.stdin.readline().strip())

prev = None

for i in range(n):
  curr = sys.stdin.readline().strip()

  if curr != prev:
    print curr

  prev = curr
