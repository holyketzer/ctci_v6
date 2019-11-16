class Solution(object):
  def maxProfit(self, prices):
    if len(prices) < 2:
      return 0

    buy = prices[0]
    sell = prices[0]
    total = 0

    for i in range(len(prices)):
      curr = prices[i]
      next = prices[i + 1] if i < len(prices) - 1 else None

      if curr > sell:
        sell = curr

      if curr < buy:
        buy = curr
        sell = curr

      if next == None or curr > next:
        total += sell - buy
        sell = next
        buy = next

    return total

print Solution().maxProfit([7,1,5,3,6,4])
print Solution().maxProfit([1,2,3,4,5])
print Solution().maxProfit([7,6,4,3,1])
