package linked_lists

// time = O(n), mem = O(n)
func PalindromeA(head *llnode) bool {
  half := head
  fast := head
  slow := head
  count := 1

  for fast.next != nil {
    fast = fast.next
    count += 1

    if fast.next != nil {
      fast = fast.next
      count += 1

      slow = slow.next
      half = &llnode{value: slow.value, next: half}
    }
  }

  rest := slow

  if count % 2 == 0 {
    rest = slow.next
  }

  for rest != nil {
    if rest.value != half.value {
      return false
    }

    rest = rest.next
    half = half.next
  }

  return true
}
