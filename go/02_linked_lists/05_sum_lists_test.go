package linked_lists

import (
	. "github.com/holyketzer/ctci_v6/lib"
	"gotest.tools/assert"
	"testing"
)

func TestSumLists(t *testing.T) {
	// equal size
	actual := SumListsReversed(LL([]int{7, 1, 6}), LL([]int{5, 9, 2}))
	expected := []int{2, 1, 9}
	assert.Equal(t, actual.ToString(), SliceToString(expected))

	// diffrenet size
	actual = SumListsReversed(LL([]int{7, 1, 6, 8}), LL([]int{9, 2}))
	expected = []int{6, 4, 6, 8}
	assert.Equal(t, actual.ToString(), SliceToString(expected))

	// equal size
	actual = SumListsDirect(LL([]int{6, 1, 7}), LL([]int{2, 9, 5}))
	expected = []int{9, 1, 2}
	assert.Equal(t, actual.ToString(), SliceToString(expected))

	// diffrenet size
	actual = SumListsDirect(LL([]int{8, 6, 1, 7}), LL([]int{2, 9}))
	expected = []int{8, 6, 4, 6}
	assert.Equal(t, actual.ToString(), SliceToString(expected))
}
