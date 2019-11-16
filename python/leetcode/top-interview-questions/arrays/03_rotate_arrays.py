class Solution(object):
  def rotate(self, nums, k):
    """
    :type nums: List[int]
    :type k: int
    :rtype: None Do not return anything, modify nums in-place instead.
    """
    if len(nums) > 0:
      k = k % len(nums)

      if k > 0:
        total_jumped = 0
        count = 0
        curr_index = 0
        next_value = nums[0]

        while count < len(nums):
          if total_jumped > 0 and total_jumped % len(nums) == 0:
            curr_index = (curr_index + 1) % len(nums)
            next_value = nums[curr_index]

          next_index = (curr_index + k) % len(nums)
          tmp = nums[next_index]
          nums[next_index] = next_value
          next_value = tmp
          curr_index = next_index
          count += 1
          total_jumped += k
          # print count, total_jumped, next_index, nums

    return nums

print Solution().rotate([1,2,3,4,5,6,7], 3)
print Solution().rotate([], 3)
print Solution().rotate([-100, -1, 3, 99], 0)
print Solution().rotate([-100, -1, 3, 99], 1)
print Solution().rotate([-100, -1, 3, 99], 2)
print Solution().rotate([-100, -1, 3, 99], 3)
print Solution().rotate([-100, -1, 3, 99], 4)
print Solution().rotate([-100, -1, 3, 99], 5)
print Solution().rotate([1, 2, 3, 4, 5, 6], 4)
