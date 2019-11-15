import sys

# Variables and Types

# Stdlib

# len(): returns the length of a string (number of characters)
# str(): returns the string representation of an object
# int(): given a string or number, returns an integer
# float()

# String

# upper()
# lower()
# print 'AbCd'.upper(), 'AbCd'.lower()

# List

# l = ["bacon", "eggs", 42]
# l.append(12)
# l.insert(1, 'test')
# del l[0]
# print l
# l.pop() # Remove the last item
# doe = l.pop(0) # Remove the first item
# l.remove(42)
# print l[1:2] # slices
# l[::2] # step
# list3 = sorted(["as", "df", "XR", "12"], key=lambda x: x.lower())
# list1[:] = [item for item in list1 if item > 2]

# Tuples (immutable)

# t = "rocks", 0, "the universe"
# print t

# Dictionaries

# d = dict(zip(seq1,seq2))
# d = { 'test': 12, 42: 55 }
# d.keys()
# d.values()
# 'cat' in d
# d['b'] = 5
# del d[42]
# print d
# d.update({"i": 60, "j": 30})
# sixty = dict6.pop("i")
# for key in sorted(d):      # Iterate via keys in sorted order of the keys
#   print key, d[key]        # Print key and the associated value

# for value in d.values():   # Iterate via values
#   print value

# del d[42]
# d.clear()

# Sets
# s = set([42, 'a string', (23, 4)])
# s.add(55)
# s.add(42)
# s.remove(42)
# s.discard(42)
# 55 in s
# print s
# s.pop()
# s.clear()
# for n in s:
#   pass

# Output formatting

# print 1
# print "Value: %s! (%s)" % ("some value", 1)
# print "Args: {0} {1} {0}".format("some value", 1)

# Stdin reading

# first_line = sys.stdin.readline()
# print "First line:", first_line

# for line in sys.stdin: # Waits Ctrl-D
#   print "Echo: ", line

# print "Counted", len(data), "lines."

# Formatting
# v1 = "Int: %i" % 4               # 4
# v2 = "Int zero padded: %03i" % 4 # 004
# v3 = "Int space padded: %3i" % 4 #   4
# v4 = "Hex: %x" % 31              # 1f
# v5 = "Hex 2: %X" % 31            # 1F - capitalized F
# v6 = "Oct: %o" % 8               # 10
# v7 = "Float: %f" % 2.4           # 2.400000
# v8 = "Float: %.2f" % 2.4         # 2.40
# v9 = "Float in exp: %e" % 2.4    # 2.400000e+00
# vA = "Float in exp: %E" % 2.4    # 2.400000E+00
# vB = "List as string: %s" % [1, 2, 3]
# vC = "Left padded str: %10s" % "cat"
# vD = "Right padded str: %-10s" % "cat"
# vE = "Truncated str: %.2s" % "cat"
# vF = "Dict value str: %(age)s" % {"age": 20}
# vG = "Char: %c" % 65             # A
# vH = "Char: %c" % "A"            # A
