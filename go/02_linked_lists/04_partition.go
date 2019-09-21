package linked_lists

import (
	. "github.com/holyketzer/ctci_v6/lib"
)

// time = O(n), mem = O(1)
func PartitionB(head *LLNode, x int) *LLNode {
	l := head
	r := head.Next

	for l.Value >= x {
		SwapValues(l, r)
		r = r.Next
	}

	for r != nil {
		if r.Value < x {
			l = l.Next
			SwapValues(l, r)
		}

		r = r.Next
	}

	return head
}

func SwapValues(a *LLNode, b *LLNode) {
	tmp := a.Value
	a.Value = b.Value
	b.Value = tmp
}
