package linked_lists

import (
	. "github.com/holyketzer/ctci_v6/lib"
)

// time = O(n), mem = O(1)
func LoopB(head *LLNode) bool {
	slow := head
	fast := head

	for fast != nil {
		fast = fast.Next

		if slow == fast {
			return true
		}

		if fast != nil {
			fast = fast.Next

			if slow == fast {
				return true
			}

			slow = slow.Next

			if slow == fast {
				return true
			}
		}
	}

	return false
}
