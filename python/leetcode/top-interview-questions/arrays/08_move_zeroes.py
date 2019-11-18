class Solution(object):
  def swap(self, nums, i, j):
    tmp = nums[i]
    nums[i] = nums[j]
    nums[j] = tmp

  def moveZeroes(self, nums):
    """
    :type nums: List[int]
    :rtype: None Do not return anything, modify nums in-place instead.
    """
    l = 0
    r = 0

    while r < len(nums):
      if nums[r] != 0:
        self.swap(nums, l, r)
        l += 1

      r += 1

    while l < len(nums):
      nums[l] = 0
      l += 1

    return nums

print Solution().moveZeroes([0, 1, 0, 3, 12])
