package linked_lists

import (
	. "github.com/holyketzer/ctci_v6/lib"
)

// time = O(n), mem = O(n)
func PalindromeA(head *LLNode) bool {
	half := head
	fast := head
	slow := head
	count := 1

	for fast.Next != nil {
		fast = fast.Next
		count += 1

		if fast.Next != nil {
			fast = fast.Next
			count += 1

			slow = slow.Next
			half = &LLNode{Value: slow.Value, Next: half}
		}
	}

	rest := slow

	if count%2 == 0 {
		rest = slow.Next
	}

	for rest != nil {
		if rest.Value != half.Value {
			return false
		}

		rest = rest.Next
		half = half.Next
	}

	return true
}
