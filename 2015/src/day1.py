

def part1(inpt):
    return sum(map(lambda c: 1 if c == "(" else -1, inpt))


def part2(inpt):
    floor = 0
    for i, s in enumerate(map(lambda c: 1 if c == "(" else -1, inpt)):
        floor += s
        if floor < 0:
            return i + 1


assert part1("(())") == 0
assert part1("()()") == 0
assert part1("(((") == 3
assert part1("(()(()(") == 3
assert part1("))(((((") == 3
assert part1("())") == -1
assert part1("))(") == -1
assert part1(")))") == -3
assert part1(")())())") == -3

assert part2(")") == 1
assert part2("()())") == 5

inpt = open("input/day1.txt").read().strip()

print(part1(inpt))
print(part2(inpt))
