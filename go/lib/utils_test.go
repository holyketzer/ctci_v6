package lib

import (
	"gotest.tools/assert"
	"testing"
)

func TestSliceToString(t *testing.T) {
	actual := SliceToString([]int{1, 2, 3, 4, 5})

	assert.Equal(t, actual, "[1, 2, 3, 4, 5]")
}
