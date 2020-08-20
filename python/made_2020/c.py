import copy
import math
import sys

def solve(arr, curr_sum = 0, level = 0, index = 0):
    res = copy.deepcopy(arr)
    last_index = len(res) - 1

    for i in range(len(arr[last_index])):
        res[last_index][i] = (arr[last_index][i], 1)

    for row, line in reversed(list(enumerate(arr[0:-1]))):
        for col, item in enumerate(line):
            lsum, lcount = res[row + 1][col]
            rsum, rcount = res[row + 1][col + 1]
            res[row][col] = ((lcount + rcount) * arr[row][col] + lsum + rsum, lcount + rcount)

    return res[0][0]

def truncate(n, m):
    k = math.gcd(n ,m)
    return n // k, m // k

n = int(sys.stdin.readline().strip())

for i in range(n):
    h = int(sys.stdin.readline().strip())

    arr = []
    for j in range(h):
        arr.append([int(i) for i in sys.stdin.readline().strip().split(' ')])

    sum, count = solve(arr)
    sum, count = truncate(sum, count)
    print(sum, count)
