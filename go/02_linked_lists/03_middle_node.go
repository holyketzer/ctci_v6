package linked_lists

import (
	. "github.com/holyketzer/ctci_v6/lib"
)

// time = O(1), mem = O(1)
func DeleteMiddleA(node *LLNode) {
	node.Value = node.Next.Value
	node.Next = node.Next.Next
}
