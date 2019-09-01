package arrays

import (
	. "github.com/holyketzer/ctci_v6/test_helper"
	"gotest.tools/assert"
	"testing"
)

func TestUrlify(t *testing.T) {
	for _, f := range []func([]rune, int) []rune{UrlifyB} {
		name := GetFunctionName(f)

		actual := StringToRuneSlice("Mr John Smith    ")
		expected := StringToRuneSlice("Mr%20John%20Smith")

		assert.Equal(t, string(f(actual, 13)), string(expected), name)
	}
}
