package arrays

import (
	. "github.com/holyketzer/ctci_v6/test_helper"
	"gotest.tools/assert"
	"testing"
)

func TestZeroMatrix(t *testing.T) {
	for _, f := range []func([][]int) [][]int{ZeroMatrixA} {
		name := GetFunctionName(f)

		matrix32 := [][]int{
			{1, 0, 3},
			{4, 5, 6},
		}

		expectedMatrix32 := [][]int{
			{0, 0, 0},
			{4, 0, 6},
		}

		assert.Equal(t, MatrixToString(f(matrix32)), MatrixToString(expectedMatrix32), name)

		matrix34 := [][]int{
			{1, 2, 3},
			{0, 6, 7},
			{9, 10, 11},
			{0, 14, 15},
		}

		expectedMatrix34 := [][]int{
			{0, 2, 3},
			{0, 0, 0},
			{0, 10, 11},
			{0, 0, 0},
		}

		assert.Equal(t, MatrixToString(f(matrix34)), MatrixToString(expectedMatrix34), name)
	}
}
