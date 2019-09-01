package arrays

import (
	. "github.com/holyketzer/ctci_v6/test_helper"
	"gotest.tools/assert"
	"testing"
)

func TestRotate(t *testing.T) {
	for _, f := range []func([][]int) [][]int{RotateA, RotateB} {
		name := GetFunctionName(f)

		matrix3 := [][]int{
			{1, 2, 3},
			{4, 5, 6},
			{7, 8, 9},
		}

		expectedMatrix3 := [][]int{
			{7, 4, 1},
			{8, 5, 2},
			{9, 6, 3},
		}

		assert.Equal(t, MatrixToString(f(matrix3)), MatrixToString(expectedMatrix3), name)

		matrix4 := [][]int{
			{1, 2, 3, 4},
			{5, 6, 7, 8},
			{9, 10, 11, 12},
			{13, 14, 15, 16},
		}

		expectedMatrix4 := [][]int{
			{13, 9, 5, 1},
			{14, 10, 6, 2},
			{15, 11, 7, 3},
			{16, 12, 8, 4},
		}

		assert.Equal(t, MatrixToString(f(matrix4)), MatrixToString(expectedMatrix4), name)
	}
}
