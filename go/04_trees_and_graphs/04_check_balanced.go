package trees_and_graphs

import (
	. "github.com/holyketzer/ctci_v6/lib"
	"math"
)

// n - size of array, k - depth
// Time = O(k*2^k) Mem = O(k)
func BalancedBtB(tree *BinaryTree) bool {
	return BalancedFromNode(tree.Root)
}

func BalancedFromNode(node *BTNode) bool {
	if node != nil {
		balanced := math.Abs((float64)(DepthToBottom(node.Left)-DepthToBottom(node.Right))) <= 1
		return balanced && BalancedFromNode(node.Left) && BalancedFromNode(node.Right)
	} else {
		return true
	}
}

func DepthToBottom(node *BTNode) int {
	if node != nil {
		ld := DepthToBottom(node.Left)
		rd := DepthToBottom(node.Right)

		if ld > rd {
			return ld + 1
		} else {
			return rd + 1
		}
	} else {
		return 0
	}
}

// Time = O(n) Mem = O(k)
func BalancedBtA(tree *BinaryTree) bool {
	root := tree.Root
	return BalancedLeftAndRight(root.Left, root.Right)
}

func BalancedLeftAndRight(l *BTNode, r *BTNode) bool {
	if l == nil && r == nil {
		return true
	} else if l == nil {
		return r.Left == nil && r.Right == nil
	} else if r == nil {
		return l.Left == nil && l.Right == nil
	} else {
		return BalancedLeftAndRight(l.Left, l.Right) && BalancedLeftAndRight(r.Left, r.Right)
	}
}
