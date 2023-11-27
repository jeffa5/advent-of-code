package utils

import (
	"errors"
	"io/ioutil"
	"strconv"
	"strings"
)

func ReadFileLines(f string) []string {
	b, err := ioutil.ReadFile(f)
	if err != nil {
		panic(err)
	}

	s := string(b)

	lines := strings.Split(strings.TrimSpace(s), "\n")

	return lines
}

func ReadFileLinesInt(f string) []int {
	l := ReadFileLines(f)

	var ints []int

	for _, s := range l {
		i, err := strconv.Atoi(s)
		if err != nil {
			panic(err)
		}

		ints = append(ints, i)
	}

	return ints
}

func ReadFileLineCSVInt(f string) []int {
	ss := ReadFileLines(f)
	if len(ss) != 1 {
		panic(errors.New("Expected single line input file"))
	}

	parts := strings.Split(ss[0], ",")

	var ints []int
	for _, s := range parts {
		i, err := strconv.Atoi(s)
		if err != nil {
			panic(err)
		}

		ints = append(ints, i)
	}

	return ints
}
