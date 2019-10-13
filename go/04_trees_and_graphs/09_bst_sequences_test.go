package trees_and_graphs

import (
	. "github.com/holyketzer/ctci_v6/lib"
	. "github.com/holyketzer/ctci_v6/test_helper"
	"gotest.tools/assert"
	"testing"
)

func TestBstSequences(t *testing.T) {
	seqBuildBstStr := func(s []int) string { return SeqBuildBst(s).ToString() }

	// small balanced tree
	assert.Equal(t, seqBuildBstStr([]int{2, 1, 3}), "((1) 2 (3))")

	// unbalanced tree
	assert.Equal(t, seqBuildBstStr([]int{5, 4, 3, 2, 1}), "(((((1) 2) 3) 4) 5)")

	// some tree
	assert.Equal(t, seqBuildBstStr([]int{5, 4, 3, 6, 7}), "(((3) 4) 5 (6 (7)))")

	for _, f := range []func(*BinaryTree) [][]int{BstSequencesA} {
		name := GetFunctionName(f)

		// 3-n tree
		actual := f(SeqBuildBst([]int{2, 1, 3}))
		assert.Equal(t, len(actual), 2, name)
		assert.Equal(t, SliceToString(actual[0]), "[2, 1, 3]", name)
		assert.Equal(t, SliceToString(actual[1]), "[2, 3, 1]", name)

		// 4-n tree
		actual = f(SeqBuildBst([]int{2, 1, 3, 4}))
		assert.Equal(t, len(actual), 3, name)
		assert.Equal(t, SliceToString(actual[0]), "[2, 1, 3, 4]", name)
		assert.Equal(t, SliceToString(actual[1]), "[2, 3, 1, 4]", name)
		assert.Equal(t, SliceToString(actual[2]), "[2, 3, 4, 1]", name)

		// 5-n tree
		actual = f(SeqBuildBst([]int{2, 1, 4, 3, 5}))
		assert.Equal(t, len(actual), 8, name)
		assert.Equal(t, SliceToString(actual[0]), "[2, 1, 4, 3, 5]", name)
		assert.Equal(t, SliceToString(actual[1]), "[2, 1, 4, 5, 3]", name)
		assert.Equal(t, SliceToString(actual[2]), "[2, 4, 1, 3, 5]", name)
		assert.Equal(t, SliceToString(actual[3]), "[2, 4, 1, 5, 3]", name)
		assert.Equal(t, SliceToString(actual[4]), "[2, 4, 3, 1, 5]", name)
		assert.Equal(t, SliceToString(actual[5]), "[2, 4, 3, 5, 1]", name)
		assert.Equal(t, SliceToString(actual[6]), "[2, 4, 5, 1, 3]", name)
		assert.Equal(t, SliceToString(actual[7]), "[2, 4, 5, 3, 1]", name)
	}
}
