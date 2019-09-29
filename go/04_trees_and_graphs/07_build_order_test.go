package trees_and_graphs

import (
	. "github.com/holyketzer/ctci_v6/lib"
	. "github.com/holyketzer/ctci_v6/test_helper"
	"gotest.tools/assert"
	"testing"
)

func TestBuildOrder(t *testing.T) {
	for _, f := range []func([]int, [][]int) []int{BuildOrderA} {
		name := GetFunctionName(f)

		projects := []int{1, 2, 3, 4, 5, 6}
		// [:a, :d] -> means :d depends on :a
		// solvable deps
		deps := [][]int{[]int{1, 4}, []int{6, 2}, []int{2, 4}, []int{6, 1}, []int{4, 3}}

		path := f(projects, deps)
		assert.Equal(t, SliceToString(path), "[5, 6, 2, 1, 4, 3]", name)

		// unsolvable deps
		deps = [][]int{[]int{1, 4}, []int{6, 2}, []int{2, 4}, []int{6, 1}, []int{4, 3}, []int{3, 6}}
		path = f(projects, deps)
		assert.Equal(t, path == nil, true, name)
	}
}
