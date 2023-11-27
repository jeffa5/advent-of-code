package utils

func ExecIntCode(mem []int) {
	i := 0
	for {
		switch mem[i] {
		case 1:
			a, b, o := mem[i+1], mem[i+2], mem[i+3]
			mem[o] = mem[a] + mem[b]
			i += 4
		case 2:
			a, b, o := mem[i+1], mem[i+2], mem[i+3]
			mem[o] = mem[a] * mem[b]
			i += 4
		case 99:
			return
		}
	}
}
