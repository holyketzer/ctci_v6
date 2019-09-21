package linked_lists

import (
	. "github.com/holyketzer/ctci_v6/lib"
	. "github.com/holyketzer/ctci_v6/test_helper"
	"gotest.tools/assert"
	"testing"
)

func TestDeleteMiddle(t *testing.T) {
	for _, f := range []func(*LLNode){DeleteMiddleA} {
		name := GetFunctionName(f)

		list := LL([]int{1, 2, 3, 4, 5})
		node := list.Next.Next

		f(node)

		assert.Equal(t, SliceToString(list.LLToArray()), SliceToString([]int{1, 2, 4, 5}), name)
	}
}
