package test_helper

import (
	"reflect"
  "runtime"
  "strings"
)

func GetFunctionName(i interface{}) string {
  fullName := strings.Split(runtime.FuncForPC(reflect.ValueOf(i).Pointer()).Name(), "/")

  return fullName[len(fullName) - 1]
}
