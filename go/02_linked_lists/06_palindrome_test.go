package linked_lists

import (
	. "github.com/holyketzer/ctci_v6/lib"
	. "github.com/holyketzer/ctci_v6/test_helper"
	"gotest.tools/assert"
	"testing"
)

func TestPalindrome(t *testing.T) {
	for _, f := range []func(*LLNode) bool{PalindromeA} {
		name := GetFunctionName(f)

		// palindrome even
		assert.Equal(t, f(LL(StringToIntSlice("robottobor"))), true, name)

		// palindrome odd
		assert.Equal(t, f(LL(StringToIntSlice("robotobor"))), true, name)

		// not palindrome even
		assert.Equal(t, f(LL(StringToIntSlice("123456"))), false, name)

		// not palindrome odd
		assert.Equal(t, f(LL(StringToIntSlice("1234567"))), false, name)
	}
}
