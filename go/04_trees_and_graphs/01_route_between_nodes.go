package trees_and_graphs

import (
	"container/list"
	. "github.com/holyketzer/ctci_v6/lib"
)

// n - count ofv nodes
// Time = O(n), Mem = O(1)
func HasRouteA(a *DGNode, b *DGNode) bool {
	res := HasRouteFromTo(a, b)
	ResetVisited(a)

	if res {
		return true
	}

	res = HasRouteFromTo(b, a)
	ResetVisited(b)
	return res
}

func HasRouteFromTo(a *DGNode, b *DGNode) bool {
	queue := list.New()
	queue.PushBack(a)

	for queue.Len() > 0 {
		e := queue.Front()
		n := e.Value.(*DGNode)

		if n == b {
			return true
		} else {
			for _, node := range n.Pointers {
				if !node.Visited {
					queue.PushBack(node)
				}
			}

			n.Visited = true
		}

		queue.Remove(e)
	}

	return false
}

func ResetVisited(node *DGNode) {
	queue := list.New()
	queue.PushBack(node)

	for queue.Len() > 0 {
		e := queue.Front()
		n := e.Value.(*DGNode)

		for _, node := range n.Pointers {
			if node.Visited {
				queue.PushBack(node)
			}
		}

		n.Visited = false
		queue.Remove(e)
	}
}
