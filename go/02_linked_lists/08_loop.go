package linked_lists

// time = O(n), mem = O(1)
func LoopB(head *llnode) bool {
  slow := head
  fast := head

  for fast != nil {
    fast = fast.next

    if slow == fast {
      return true
    }

    if fast != nil {
      fast = fast.next

      if slow == fast {
        return true
      }

      slow = slow.next

      if slow == fast {
        return true
      }
    }
  }

  return false
}
