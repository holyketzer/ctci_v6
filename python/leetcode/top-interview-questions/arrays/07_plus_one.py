class Solution(object):
  def plusOne(self, digits):
    """
    :type digits: List[int]
    :rtype: List[int]
    """

    i = len(digits) - 1

    while i >= 0:
      if digits[i] < 9:
        digits[i] += 1
        break
      else:
        digits[i] = 0
        i -= 1

    if i < 0:
      digits.insert(0, 1)

    return digits

print Solution().plusOne([1, 2, 3])
print Solution().plusOne([4, 3, 2, 1])
print Solution().plusOne([9, 9, 9])
