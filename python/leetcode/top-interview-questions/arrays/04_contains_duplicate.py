class Solution(object):
  def containsDuplicate(self, nums):
    """
    :type nums: List[int]
    :rtype: bool
    """
    values = set([])

    for v in nums:
      if v in values:
        return True
      else:
        values.add(v)

    return False

print Solution().containsDuplicate([1, 2, 3, 4, 5])
print Solution().containsDuplicate([1, 2, 3, 4, 5, 1])
