package max

func Max(seq []int) int {
	i := 0
	max := seq[i]
	for i := 0; i < len(seq); i++ {
		if max < seq[i] {
			max = seq[i]
		}
	}
	return max
}
