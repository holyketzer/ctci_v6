class Solution(object):
  def twoSum(self, nums, target):
    """
    :type nums: List[int]
    :type target: int
    :rtype: List[int]
    """
    d = {}
    d2 = {}

    i = 0
    for x in nums:
      if x in d:
        d2[x] = i
      else:
        d[x] = i

      i += 1

    for x in nums:
      y = target - x

      if x != y and y in d:
        return [d[x], d[y]]
      elif x == y and x in d and y in d2:
        return [d[x], d2[y]]

print Solution().twoSum([2, 7, 11, 15], 9)
print Solution().twoSum([3, 3], 6)
