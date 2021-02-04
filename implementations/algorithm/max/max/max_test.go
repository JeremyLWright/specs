package max

import (
	"testing"

	"github.com/stretchr/testify/assert"
)

//Failing Model example
func TestMaxEmptyList(t *testing.T) {
	empty := []int{}
	assert.Panics(t, func() { Max(empty) }, "Expected this method to panic per the model")
}
