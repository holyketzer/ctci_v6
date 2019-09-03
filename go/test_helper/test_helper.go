package test_helper

import (
	"bytes"
	"reflect"
	"runtime"
	"strconv"
	"strings"
)

func GetFunctionName(i interface{}) string {
	fullName := strings.Split(runtime.FuncForPC(reflect.ValueOf(i).Pointer()).Name(), "/")
	return fullName[len(fullName)-1]
}

func MatrixToString(matrix [][]int) string {
	res := bytes.Buffer{}

	for _, row := range matrix {
		res.WriteString("[")

		for i, item := range row {
			res.WriteString(strconv.Itoa(item))

			if i < len(row)-1 {
				res.WriteString(", ")
			}
		}

		res.WriteString("]\n")
	}

	return res.String()
}

func SliceToString(row []int) string {
	res := bytes.Buffer{}
	res.WriteString("[")

	for i, item := range row {
		res.WriteString(strconv.Itoa(item))

		if i < len(row)-1 {
			res.WriteString(", ")
		}
	}

	res.WriteString("]\n")
	return res.String()
}
