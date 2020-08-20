import math
import sys
from collections import defaultdict
import operator as op
from functools import reduce

def combination(n, r):
    r = min(r, n-r)
    numer = reduce(op.mul, range(n, n - r, -1), 1)
    denom = reduce(op.mul, range(1, r + 1), 1)
    return numer // denom

n = int(sys.stdin.readline().strip())

for i in range(n):
    k = int(sys.stdin.readline().strip())
    res = 0

    points_by_x = defaultdict(set)
    for j in range(k):
        x, y = [int(i) for i in sys.stdin.readline().strip().split(' ')]
        points_by_x[x].add(y)

    xx = list(points_by_x.keys())
    xx.sort()

    for i, x in enumerate(xx):
        for j in range(i + 1, len(xx)):
            inter = points_by_x[x].intersection(points_by_x[xx[j]])

            if len(inter) > 1:
                res += combination(len(inter), 2)

    print(res)
