package linked_lists

import (
	. "github.com/holyketzer/ctci_v6/lib"
)

// time = O(n), mem = O(n)
func SumListsReversed(a *LLNode, b *LLNode) *LLNode {
	var res_head *LLNode
	var res *LLNode
	shift := 0

	for a != nil || b != nil {
		v := shift

		if a != nil {
			v += a.Value
		}

		if b != nil {
			v += b.Value
		}

		shift = v / 10
		node := LLNode{Value: v % 10}

		if res != nil {
			res.Next = &node
		} else {
			res_head = &node
		}

		res = &node

		if a != nil {
			a = a.Next
		}

		if b != nil {
			b = b.Next
		}
	}

	return res_head
}

// time = O(n), mem = O(n)
func SumListsDirect(a *LLNode, b *LLNode) *LLNode {
	sum := LLToI(a, 10) + LLToI(b, 10)

	var res *LLNode

	for sum > 0 {
		res = &LLNode{Value: sum % 10, Next: res}
		sum = sum / 10
	}

	return res
}

func LLToI(head *LLNode, base int) int {
	res := 0

	for head != nil {
		res = res*base + head.Value
		head = head.Next
	}

	return res
}
