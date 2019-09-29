package trees_and_graphs

import (
	. "github.com/holyketzer/ctci_v6/lib"
	"sort"
)

// n - count of projects
// Time = O(n^2) Mem = O(n)
func BuildOrderA(projects []int, deps [][]int) []int {
	isolated := make(map[int]bool)
	nodes := make(map[int]*DGNode)

	for _, x := range projects {
		nodes[x] = &DGNode{Value: x}
		isolated[x] = true
	}

	for _, pair := range deps {
		from := pair[0]
		to := pair[1]

		nodes[from].Pointers = append(nodes[from].Pointers, nodes[to])
		isolated[from] = false
		isolated[to] = false
	}

	for _, node := range nodes {
		res := HasRouteToAllNodes(node, nodes, isolated)

		if res != nil {
			if NoCyces(node) {
				return res
			}
		}
	}

	return nil
}

func HasRouteToAllNodes(node *DGNode, nodes map[int]*DGNode, isolated map[int]bool) []int {
	covered := make(map[int]bool)

	for name, i := range isolated {
		if i {
			covered[name] = true
		}
	}

	path := make([]int, 0, len(covered))

	for k, _ := range covered {
		path = append(path, k)
	}

	sort.Ints(path)

	q := []*DGNode{node}
	var curr *DGNode

	for len(q) > 0 {
		curr, q = q[0], q[1:]
		covered[curr.Value] = true
		path = append(path, curr.Value)

		for _, node := range curr.Pointers {
			if covered[node.Value] == false {
				q = append(q, node)
				covered[node.Value] = true
			}
		}
	}

	if len(covered) == len(nodes) {
		return path
	} else {
		return nil
	}
}

func NoCyces(node *DGNode) bool {
	// Hash.new { |hash, key| hash[key] = {} }
	coveredEdges := make(map[int](map[int]bool)) // to -> from
	q := []*DGNode{node}
	var curr *DGNode

	for len(q) > 0 {
		curr, q = q[0], q[1:]

		for _, node := range curr.Pointers {
			edge := coveredEdges[node.Value]
			edgePresent := false

			if edge != nil {
				edgePresent = edge[curr.Value]
			}

			if edgePresent {
				return false
			} else if coveredEdges[node.Value] == nil {
				q = append(q, node)
			}

			if edge == nil {
				coveredEdges[node.Value] = make(map[int]bool)
				coveredEdges[node.Value][curr.Value] = true
			}
		}
	}

	return true
}
