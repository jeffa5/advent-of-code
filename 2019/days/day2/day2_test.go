package day2

import (
	"testing"

	"github.com/stretchr/testify/assert"
)

func TestA(t *testing.T) {
	a := assert.New(t)

	a.Equal("4714701", Day2(1, "../../input/day"))
}

func TestB(t *testing.T) {
	a := assert.New(t)

	a.Equal("5121", Day2(2, "../../input/day"))
}
