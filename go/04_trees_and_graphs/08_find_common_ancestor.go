package trees_and_graphs

import (
	. "github.com/holyketzer/ctci_v6/lib"
)

// n - count of nodes, k - depth
// Time = O(k) Mem = O(1)
func FindCommonAncestorB(a *BTNode, b *BTNode) *BTNode {
	aDepth := DepthToUp(a)
	bDepth := DepthToUp(b)

	for aDepth > bDepth {
		a = a.Parent
		aDepth -= 1
	}

	for bDepth > aDepth {
		b = b.Parent
		bDepth -= 1
	}

	for a != nil && b != nil {
		if a == b {
			return a
		} else {
			a = a.Parent
			b = b.Parent
		}
	}

	return nil
}

func DepthToUp(node *BTNode) int {
	res := 0

	for node != nil {
		node = node.Parent
		res += 1
	}

	return res
}
