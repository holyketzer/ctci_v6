package trees_and_graphs

import (
	. "github.com/holyketzer/ctci_v6/lib"
)

// n - size of array
// Time = O(n) Mem = O(n)
func ArrayToBstA(arr []int) *BinaryTree {
	return &BinaryTree{Root: CreateBst(arr, 0, len(arr)-1, nil)}
}

func CreateBst(arr []int, l int, r int, parent *BTNode) *BTNode {
	if l == r {
		return &BTNode{Value: arr[l], Parent: parent}
	} else {
		m := (l + r) / 2

		if (l+r)%2 != 0 {
			m += 1
		}

		node := &BTNode{Value: arr[m], Parent: parent}

		if l != m {
			node.Left = CreateBst(arr, l, m-1, node)
		}

		if r != m {
			node.Right = CreateBst(arr, m+1, r, node)
		}

		return node
	}
}
