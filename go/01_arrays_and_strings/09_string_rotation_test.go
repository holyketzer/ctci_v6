package arrays

import (
	. "github.com/holyketzer/ctci_v6/test_helper"
	"gotest.tools/assert"
	"testing"
)

func TestRotation(t *testing.T) {
	for _, f := range []func(string, string) bool{RotationA} {
		name := GetFunctionName(f)

		assert.Equal(t, f("erbottlewat", "waterbottle"), true, name)
		assert.Equal(t, f("rebottlewat", "waterbottle"), false, name)
	}
}
