use aoc_runner_derive::aoc;
use aoc_runner_derive::aoc_generator;

struct PassRule {
    min: usize,
    max: usize,
    letter: char,
    password: String,
}

#[aoc_generator(day2)]
fn input_generator(input: &str) -> Vec<PassRule> {
    input
        .lines()
        .filter_map(|l| {
            if let [constraints, password] = l.splitn(2, ':').collect::<Vec<_>>().as_slice() {
                let password = password.trim();
                if let [range, letter] = constraints.splitn(2, ' ').collect::<Vec<_>>().as_slice() {
                    if let [min, max] = range.splitn(2, '-').collect::<Vec<_>>().as_slice() {
                        return Some(PassRule {
                            min: min.parse().unwrap(),
                            max: max.parse().unwrap(),
                            letter: letter.chars().next().unwrap(),
                            password: password.to_string(),
                        });
                    }
                }
            }
            None
        })
        .collect()
}

#[aoc(day2, part1)]
fn solve_part1(passrules: &[PassRule]) -> usize {
    passrules
        .iter()
        .filter(|r| {
            let lcount = r.password.chars().filter(|&c| c == r.letter).count();
            lcount >= r.min && lcount <= r.max
        })
        .count()
}

#[aoc(day2, part2)]
fn solve_part2(passrules: &[PassRule]) -> usize {
    passrules
        .iter()
        .filter_map(|r| {
            let first = r.password.chars().nth(r.min - 1)?;
            let last = r.password.chars().nth(r.max - 1)?;
            if (first == r.letter) ^ (last == r.letter) {
                Some(())
            } else {
                None
            }
        })
        .count()
}

#[cfg(test)]
mod tests {
    use super::*;

    #[test]
    fn test_solve() {
        assert_eq!(
            solve_part1(&[
                PassRule {
                    min: 1,
                    max: 3,
                    letter: 'a',
                    password: "abcde".to_string()
                },
                PassRule {
                    min: 1,
                    max: 3,
                    letter: 'b',
                    password: "cdefg".to_string()
                },
                PassRule {
                    min: 2,
                    max: 9,
                    letter: 'c',
                    password: "ccccccccc".to_string(),
                }
            ]),
            2
        );
        assert_eq!(
            solve_part2(&[
                PassRule {
                    min: 1,
                    max: 3,
                    letter: 'a',
                    password: "abcde".to_string()
                },
                PassRule {
                    min: 1,
                    max: 3,
                    letter: 'b',
                    password: "cdefg".to_string()
                },
                PassRule {
                    min: 2,
                    max: 9,
                    letter: 'c',
                    password: "ccccccccc".to_string(),
                }
            ]),
            1
        )
    }
}
