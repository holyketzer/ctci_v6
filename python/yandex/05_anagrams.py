import sys

def count_chars(s):
  d = {}

  for c in s:
    if c in d:
      d[c] += 1
    else:
      d[c] = 0

  return d

def check_anagram(s1, s2):
  if len(s1) == len(s2):
    d1 = count_chars(s1)
    d2 = count_chars(s2)

    if len(d1) == len(d2):
      for c in d1:
        if not c in d2 or d1[c] != d2[c]:
          return 0

      return 1
    else:
      return 0
  else:
    return 0

s1 = sys.stdin.readline().strip()
s2 = sys.stdin.readline().strip()

print check_anagram(s1, s2)
