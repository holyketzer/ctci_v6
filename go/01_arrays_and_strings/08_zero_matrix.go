package arrays

// Matrix MxN
// time = O(M*N), mem = O(M + N)
func ZeroMatrixA(matrix [][]int) [][]int {
	n := len(matrix)    // rows
	m := len(matrix[0]) // cols

	zeroRows := make([]bool, n)
	zeroCols := make([]bool, m)

	for col := 0; col < m; col++ {
		for row := 0; row < n; row++ {
			if matrix[row][col] == 0 {
				zeroRows[row] = true
				zeroCols[col] = true
			}
		}
	}

	for col := 0; col < m; col++ {
		for row := 0; row < n; row++ {
			if zeroRows[row] || zeroCols[col] {
				matrix[row][col] = 0
			}
		}
	}

	return matrix
}
