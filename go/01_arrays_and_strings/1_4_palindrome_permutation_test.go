package arrays

import (
	. "github.com/holyketzer/ctci_v6/test_helper"
	"gotest.tools/assert"
	"testing"
)

func TestPalindromePermutation(t *testing.T) {
	for _, f := range []func(string) bool{PalindromePermutationB, PalindromePermutationC} {
		name := GetFunctionName(f)

		assert.Equal(t, f("taco cat"), true, name)
		assert.Equal(t, f("taco cata"), false, name)
	}
}
