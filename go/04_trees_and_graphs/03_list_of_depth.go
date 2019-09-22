package trees_and_graphs

import (
	"container/list"
	. "github.com/holyketzer/ctci_v6/lib"
)

// n - size of array
// Time = O(n) Mem = O(n)
func ListsOfDepthA(tree *BinaryTree) map[int]([]*BTNode) {
	res := map[int]([]*BTNode){}

	queue := list.New()
	queue.PushBack(tree.Root)
	queue.PushBack(0)

	for queue.Len() > 0 {
		e := queue.Front()
		curr := e.Value.(*BTNode)
		queue.Remove(e)

		e = queue.Front()
		level := e.Value.(int)
		queue.Remove(e)

		if res[level] == nil {
			res[level] = []*BTNode{}
		}
		res[level] = append(res[level], curr)

		if curr.Left != nil {
			queue.PushBack(curr.Left)
			queue.PushBack(level + 1)
		}

		if curr.Right != nil {
			queue.PushBack(curr.Right)
			queue.PushBack(level + 1)
		}
	}

	return res
}
