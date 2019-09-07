package linked_lists

import (
	. "github.com/holyketzer/ctci_v6/test_helper"
	"gotest.tools/assert"
	"testing"
)

func TestRemoveDups(t *testing.T) {
	for _, f := range []func(*llnode) *llnode{RemoveDupsB, RemoveDupsC} {
		name := GetFunctionName(f)

		dupList := LL([]int{1, 2, 3, 1, 3, 4})
		actual := f(dupList).LLToArray()

		assert.Equal(t, SliceToString(actual), SliceToString([]int{1, 2, 3, 4}), name)

		manyDupsList := LL([]int{1, 1, 3, 1, 3, 4, 3})
		actual = f(manyDupsList).LLToArray()
		assert.Equal(t, SliceToString(actual), SliceToString([]int{1, 3, 4}), name)
	}
}
