class Solution(object):
  def singleNumber(self, nums):
    """
    :type nums: List[int]
    :rtype: int
    """

    x = 0

    for v in nums:
      x ^= v

    return x

print Solution().singleNumber([4, 1, 2, 1, 2])
print Solution().singleNumber([4, 1, 2, 1, 2, 4, 7])
