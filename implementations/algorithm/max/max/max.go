package max

import "fmt"

func Max(seq []int) (int, error) {
	i := 0
	if len(seq) == 0 {
		return 0, fmt.Errorf("cannot find max of empty list")
	}

	max := seq[i]
	for i := 0; i < len(seq); i++ {
		if max < seq[i] {
			max = seq[i]
		}
	}
	return max, nil
}
