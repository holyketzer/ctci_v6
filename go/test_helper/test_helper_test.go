package test_helper

import (
	"gotest.tools/assert"
	"testing"
)

func TestStringToIntSlice(t *testing.T) {
	actual := StringToIntSlice("hello")

	assert.Equal(t, len(actual), 5)
	assert.Equal(t, actual[0], 104)
	assert.Equal(t, actual[1], 101)
	assert.Equal(t, actual[2], 108)
	assert.Equal(t, actual[3], 108)
	assert.Equal(t, actual[4], 111)
}
