package arrays

import (
	"math"
)

// Matrix N-N, n = N*N
// A: time = O(n), mem = O(n)
func RotateA(matrix [][]int) [][]int {
	n := len(matrix)
	res := make([][]int, n)

	for row := 0; row < n; row++ {
		newRow := make([]int, n)

		for col := 0; col < n; col++ {
			newRow[col] = matrix[n-col-1][row]
		}

		res[row] = newRow
	}

	return res
}

// B: time = O(n), mem = O(1)
func RotateB(matrix [][]int) [][]int {
	n := len(matrix)
	halfN := n / 2
	ceilHalfN := int(math.Ceil(float64(n) / 2))

	for col := 0; col < ceilHalfN; col++ {
		for row := 0; row < halfN; row++ {
			t := matrix[row][col]
			matrix[row][col] = matrix[n-col-1][row]
			matrix[n-col-1][row] = matrix[n-row-1][n-col-1]
			matrix[n-row-1][n-col-1] = matrix[col][n-row-1]
			matrix[col][n-row-1] = t
		}
	}

	return matrix
}
