import sys

def generate_seqs(n, left_count, right_count, curr, index):
  if left_count == n and right_count == n:
    print ''.join(curr)
  elif right_count > left_count:
    return
  else:
    if left_count < n:
      curr[index] = '('
      generate_seqs(n, left_count + 1, right_count, curr, index + 1)
      curr[index] = ''

    if right_count < n:
      curr[index] = ')'
      generate_seqs(n, left_count, right_count + 1, curr, index + 1)
      curr[index] = ''


n = int(sys.stdin.readline().strip())
generate_seqs(n, 0, 0, 2 * n * [''], 0)
