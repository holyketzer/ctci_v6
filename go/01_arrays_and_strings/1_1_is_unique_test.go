package main

import (
	"testing"
	"gotest.tools/assert"
	. "github.com/holyketzer/ctci_v6/test_helper"
)

func TestAllUniq(t *testing.T) {
	for _, f := range []func(string) bool{AllUniqA, AllUniqC, AllUniqE} {
		name := GetFunctionName(f)

		assert.Equal(t, f("abcdefg"), true, name)
		assert.Equal(t, f("abcdefga"), false, name)
	}
}
