package linked_lists

import (
	. "github.com/holyketzer/ctci_v6/test_helper"
	"gotest.tools/assert"
	"testing"
)

func TestKth(t *testing.T) {
	for _, f := range []func(*llnode, int) (int, error){KthA, KthB, KthC} {
		list := LL([]int{1, 2, 3, 4, 5, 6, 7})

		AssertKth(t, f, list, 1, 7, nil)
		AssertKth(t, f, list, 4, 4, nil)
		AssertKth(t, f, list, 7, 1, nil)

		msg := "list is blank"
		AssertKth(t, f, list, 8, -1, &msg)
	}
}

func AssertKth(t *testing.T, f func(*llnode, int) (int, error), list *llnode, k int, expectedRes int, expectedErr *string) {
	name := GetFunctionName(f)
	res, err := f(list, k)

	if expectedErr == nil {
		assert.Equal(t, res, expectedRes, name)
		assert.Equal(t, err, nil, name)
	} else {
		assert.Equal(t, res, expectedRes, name)
		assert.Equal(t, err.Error(), *expectedErr, name)
	}
}
