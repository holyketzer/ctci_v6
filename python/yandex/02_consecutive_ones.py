import sys

n = int(sys.stdin.readline().strip())

max_count = 0
count = 0

for i in range(n):
  v = sys.stdin.readline().strip()
  if v == "1":
    count += 1
  else:
    if count > max_count:
      max_count = count

    count = 0

if count > max_count:
  max_count = count

print max_count
