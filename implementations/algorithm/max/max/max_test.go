package max

import (
	"testing"

	"github.com/stretchr/testify/assert"
)

//Failing Model example
func TestMaxEmptyList(t *testing.T) {
	empty := []int{}
	//assert.Panics(t, func() { Max(empty) }, "Expected this method to panic per the model")

	_, err := Max(empty)
	assert.Error(t, err)
}

func TestNonEmpty(t *testing.T) {
	seq := []int{1, 2, 3, 4}
	m, err := Max(seq)
	assert.NoError(t, err)
	assert.Equal(t, m, 4)
}
