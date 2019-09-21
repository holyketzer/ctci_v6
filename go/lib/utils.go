package lib

import (
	"bytes"
	"strconv"
)

func SliceToString(row []int) string {
	res := bytes.Buffer{}
	res.WriteString("[")

	for i, item := range row {
		res.WriteString(strconv.Itoa(item))

		if i < len(row)-1 {
			res.WriteString(", ")
		}
	}

	res.WriteString("]")
	return res.String()
}
