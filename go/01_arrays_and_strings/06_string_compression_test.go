package arrays

import (
	. "github.com/holyketzer/ctci_v6/test_helper"
	"gotest.tools/assert"
	"testing"
)

func TestCompress(t *testing.T) {
	for _, f := range []func(string) string{CompressA} {
		name := GetFunctionName(f)

		assert.Equal(t, f("aabcccccaaa"), "a2b1c5a3", name)
		assert.Equal(t, f("abcdeffffffff"), "a1b1c1d1e1f8", name)
		assert.Equal(t, f("abacccccaa"), "abacccccaa", name)
	}
}
