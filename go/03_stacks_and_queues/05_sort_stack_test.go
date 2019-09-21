package stacks_and_queues

import (
	. "github.com/holyketzer/ctci_v6/lib"
	. "github.com/holyketzer/ctci_v6/test_helper"
	"gotest.tools/assert"
	"testing"
)

func TestSortStack(t *testing.T) {
	for _, f := range []func(*stack) *stack{SortStackA, SortStackB} {
		name := GetFunctionName(f)

		stack := SliceToStack([]int{7, 3, 5, 0, 4, 1, 6, 2})
		actual := f(stack).ToSlice()
		expected := []int{7, 6, 5, 4, 3, 2, 1, 0}

		assert.Equal(t, SliceToString(actual), SliceToString(expected), name)
	}
}
