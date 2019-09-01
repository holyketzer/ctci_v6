package arrays

import (
	. "github.com/holyketzer/ctci_v6/test_helper"
	"gotest.tools/assert"
	"testing"
)

func TestOneWay(t *testing.T) {
	for _, f := range []func(string, string) bool{OneWayA} {
		name := GetFunctionName(f)

		assert.Equal(t, f("pale", "ple"), true, name)
		assert.Equal(t, f("pale", "ale"), true, name)
		assert.Equal(t, f("pale", "pal"), true, name)
		assert.Equal(t, f("pale", "spale"), true, name)
		assert.Equal(t, f("pale", "paale"), true, name)
		assert.Equal(t, f("pale", "pales"), true, name)
		assert.Equal(t, f("pale", "bale"), true, name)
		assert.Equal(t, f("pale", "bake"), false, name)
	}
}
