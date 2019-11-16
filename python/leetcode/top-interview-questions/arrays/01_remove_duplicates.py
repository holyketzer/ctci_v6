class Solution(object):
  def removeDuplicates(self, nums):
    """
    :type nums: List[int]
    :rtype: int
    """
    if len(nums) > 1:
      l = 0
      r = 1

      while r < len(nums):
        if nums[l] == nums[r]:
          while r < len(nums) and nums[l] == nums[r]:
            r += 1

          if r < len(nums):
            l += 1
            nums[l] = nums[r]
        else:
          l += 1
          r += 1

      return l + 1
    else:
      return 1

print Solution().removeDuplicates([1,1,2,3,4])
print Solution().removeDuplicates([0,0,1,1,1,2,2,3,3,4])
