package lib

import (
	"gotest.tools/assert"
	"testing"
)

func TestLL(t *testing.T) {
	list := LL([]int{1, 2, 3, 4, 5})
	actual := list.LLToArray()

	assert.Equal(t, SliceToString(actual), SliceToString([]int{1, 2, 3, 4, 5}))
}

func TestLLAddValue(t *testing.T) {
	list := LL([]int{1, 2, 3})
	actual := list.LLAddValue(4).LLToArray()

	assert.Equal(t, SliceToString(actual), SliceToString([]int{1, 2, 3, 4}))
}

func TestLLSize(t *testing.T) {
	list := LL([]int{1, 2, 3})
	actual := list.LLSize()

	assert.Equal(t, actual, 3)
}
