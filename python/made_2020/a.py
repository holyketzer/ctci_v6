import math
import sys

n = int(sys.stdin.readline().strip())

def level(n):
    return math.floor((math.sqrt(8*n + 1) - 1) / 2) + 1

for i in range(n):
    ii = int(sys.stdin.readline().strip()) - 1
    l = int(level(ii))
    o = int(ii - (l * (l - 1) / 2))
    x = '1' + '0' * (l - o - 1) + '1' + '0' * o
    print(int(x, 2) % 35184372089371)
