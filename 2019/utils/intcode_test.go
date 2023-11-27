package utils

import (
	"testing"

	"github.com/stretchr/testify/assert"
)

func TestIntCode(t *testing.T) {
	a := assert.New(t)

	tests := []struct {
		i []int
		e []int
	}{
		{
			i: []int{1, 9, 10, 3, 2, 3, 11, 0, 99, 30, 40, 50},
			e: []int{3500, 9, 10, 70, 2, 3, 11, 0, 99, 30, 40, 50},
		},
		{
			i: []int{1, 0, 0, 0, 99}, e: []int{2, 0, 0, 0, 99},
		},
		{
			i: []int{2, 3, 0, 3, 99}, e: []int{2, 3, 0, 6, 99},
		},
		{
			i: []int{2, 4, 4, 5, 99, 0}, e: []int{2, 4, 4, 5, 99, 9801},
		},
		{
			i: []int{1, 1, 1, 4, 99, 5, 6, 0, 99}, e: []int{30, 1, 1, 4, 2, 5, 6, 0, 99},
		},
	}

	for _, tt := range tests {
		ExecIntCode(tt.i)
		a.Equal(tt.e, tt.i)
	}
}
