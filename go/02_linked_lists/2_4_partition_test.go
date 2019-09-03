package linked_lists

import (
	"fmt"
	. "github.com/holyketzer/ctci_v6/test_helper"
	"gotest.tools/assert"
	"sort"
	"testing"
)

func TestPartition(t *testing.T) {
	for _, f := range []func(*llnode, int) *llnode{PartitionB} {
		x := 5
		expected := []int{1, 2, 3, 5, 5, 8, 10}

		// first < 5
		list := LL([]int{3, 5, 8, 5, 10, 2, 1})
		expectOrderedPartition(t, f, list, expected, x)

		// first = 5
		list = LL([]int{5, 3, 8, 5, 10, 2, 1})
		expectOrderedPartition(t, f, list, expected, x)

		// first > 5
		list = LL([]int{8, 3, 5, 5, 10, 2, 1})
		expectOrderedPartition(t, f, list, expected, x)
	}
}

func filter(coll []int, pred func(int) bool) []int {
	res := []int{}

	for _, item := range coll {
		if pred(item) {
			res = append(res, item)
		}
	}

	return res
}

func expectOrderedPartition(t *testing.T, f func(*llnode, int) *llnode, list *llnode, expected []int, x int) {
	name := GetFunctionName(f)
	actual := f(list, x).LLToArray()

	lower := filter(expected, func(i int) bool { return i < x })
	sort.Ints(lower)

	equalAndGreater := filter(expected, func(i int) bool { return i >= x })
	sort.Ints(equalAndGreater)

	actualLower := actual[0:len(lower)]
	sort.Ints(actual[0:len(lower)])

	actualEqualAndGreater := actual[len(lower) : len(lower)+len(equalAndGreater)]
	sort.Ints(actualEqualAndGreater)

	fmt.Println(expected, " ~ ", actual)
	fmt.Println(actualLower, " = ", lower)
	fmt.Println(actualEqualAndGreater, " = ", equalAndGreater)

	assert.Equal(t, SliceToString(actualLower), SliceToString(lower), name)
	assert.Equal(t, SliceToString(actualEqualAndGreater), SliceToString(equalAndGreater), name)
}
