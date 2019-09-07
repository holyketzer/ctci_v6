package arrays

import (
	. "github.com/holyketzer/ctci_v6/test_helper"
	"gotest.tools/assert"
	"testing"
)

func TestAllUniq(t *testing.T) {
	for _, f := range []func(string) bool{AllUniqA, AllUniqC, AllUniqE} {
		name := GetFunctionName(f)

		assert.Equal(t, f("abcdefg"), true, name)
		assert.Equal(t, f("abcdefga"), false, name)
	}
}
