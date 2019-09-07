package arrays

import (
	. "github.com/holyketzer/ctci_v6/test_helper"
	"gotest.tools/assert"
	"testing"
)

func TestPermutation(t *testing.T) {
	for _, f := range []func(string, string) bool{PermutationB, PermutationC} {
		name := GetFunctionName(f)

		assert.Equal(t, f("abcdefg", "fbcgdea"), true, name)
		assert.Equal(t, f("fbcdefg", "fbcgdea"), false, name)
		assert.Equal(t, f("fbcgde", "fbcgdea"), false, name)
	}
}
