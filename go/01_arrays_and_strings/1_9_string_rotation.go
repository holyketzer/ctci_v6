package arrays

import (
	"strings"
)

// s1, s2 - probably rotated string
// time = O(M*N), mem = O(M + N)
func RotationA(s1 string, s2 string) bool {
	return isSubstring(s1+s1, s2)
}

func isSubstring(s1 string, s2 string) bool {
	return strings.Contains(s1, s2)
}
