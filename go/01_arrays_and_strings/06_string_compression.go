package arrays

import (
	"bytes"
	"strconv"
)

// n - str length
// A: time = O(n), mem = O(n)
func CompressA(str string) string {
	res := bytes.Buffer{}

	var prev rune
	var count int = 0

	for _, curr := range str {
		if prev == curr {
			count += 1
		} else {
			if count > 0 {
				res.WriteRune(prev)
				res.WriteString(strconv.Itoa(count))
			}

			prev = curr
			count = 1
		}
	}

	res.WriteRune(prev)
	res.WriteString(strconv.Itoa(count))

	if res.Len() < len(str) {
		return res.String()
	} else {
		return str
	}
}
