package linked_lists

import (
	. "github.com/holyketzer/ctci_v6/lib"
	. "github.com/holyketzer/ctci_v6/test_helper"
	"gotest.tools/assert"
	"testing"
)

func TestIntersection(t *testing.T) {
	for _, f := range []func(*LLNode, *LLNode) bool{IntersectionA} {
		name := GetFunctionName(f)

		// no intersection
		a := LL([]int{1, 2, 3, 4, 5})
		b := LL([]int{1, 2, 3, 4, 5})
		assert.Equal(t, f(a, b), false, name)

		// with intersection
		a = LL([]int{1, 2, 3, 4, 5})
		bHead := LL([]int{7, 8, 9})
		b = bHead.LLAddNode(a.Next.Next.Next)
		assert.Equal(t, f(a, b), true, name)
	}
}
