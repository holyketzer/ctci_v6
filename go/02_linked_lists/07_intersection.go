package linked_lists

import (
	. "github.com/holyketzer/ctci_v6/lib"
)

// time = O(n), mem = O(1)
func IntersectionA(a *LLNode, b *LLNode) bool {
	aTail := a
	bTail := b

	for aTail.Next != nil {
		aTail = aTail.Next
	}

	for bTail.Next != nil {
		bTail = bTail.Next
	}

	return aTail == bTail
}
