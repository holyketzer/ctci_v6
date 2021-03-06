package linked_lists

import (
	. "github.com/holyketzer/ctci_v6/lib"
	. "github.com/holyketzer/ctci_v6/test_helper"
	"gotest.tools/assert"
	"testing"
)

func TestLoop(t *testing.T) {
	for _, f := range []func(*LLNode) bool{LoopB} {
		name := GetFunctionName(f)

		// no loop
		list := LL([]int{1, 2, 3, 4, 5})
		assert.Equal(t, f(list), false, name)

		// with loop
		head := LL([]int{1, 2, 3, 4, 5})
		list = head.LLAddNode(head.Next.Next.Next)
		assert.Equal(t, f(list), true, name)
	}
}
