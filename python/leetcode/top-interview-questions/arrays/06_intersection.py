import collections

class Solution(object):
  def intersect(self, nums1, nums2):
    """
    :type nums1: List[int]
    :type nums2: List[int]
    :rtype: List[int]
    """

    d1 = collections.defaultdict(int)
    d2 = collections.defaultdict(int)

    for n in nums1:
      d1[n] += 1

    for n in nums2:
      d2[n] += 1

    res = []

    for n in d1:
      if n in d2:
        for i in range(min(d1[n], d2[n])):
          res.append(n)

    return res

print Solution().intersect([1, 2, 2, 1],  [2, 2])
print Solution().intersect([4, 9, 5],  [9, 4, 9, 8, 4])
