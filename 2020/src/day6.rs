use aoc_runner_derive::aoc;
use aoc_runner_derive::aoc_generator;

#[aoc_generator(day6)]
fn input_generator(input: &str) -> Vec<Vec<String>> {
    input
        .split("\n\n")
        .map(|g| g.lines().map(|s| s.to_string()).collect())
        .collect()
}

#[aoc(day6, part1)]
fn solve_part1(groups: &[Vec<String>]) -> usize {
    groups
        .iter()
        .map(|g| {
            let mut answers = [false; 26];
            for p in g {
                for c in p.chars() {
                    answers[c as usize - 'a' as usize] = true
                }
            }
            answers.iter().filter(|&&x| x).count()
        })
        .sum()
}

#[aoc(day6, part2)]
fn solve_part2(groups: &[Vec<String>]) -> usize {
    groups
        .iter()
        .map(|g| {
            let mut answers = [0; 26];
            for p in g {
                for c in p.chars() {
                    answers[c as usize - 'a' as usize] += 1
                }
            }
            answers.iter().filter(|&&n| n == g.len()).count()
        })
        .sum()
}
