use aoc_runner_derive::aoc;
use aoc_runner_derive::aoc_generator;

#[aoc_generator(day1)]
pub fn input_generator(input: &str) -> Vec<u32> {
    input.lines().map(|x| x.parse().unwrap()).collect()
}

#[aoc(day1, part1)]
pub fn solve_part1(input: &[u32]) -> u32 {
    let mut input = Vec::from(input);
    input.sort_unstable();
    let mut l = 0;
    let mut r = input.len() - 1;
    loop {
        let sum = input[l] + input[r];
        if sum > 2020 {
            r -= 1
        }
        if sum < 2020 {
            l += 1
        }
        if sum == 2020 {
            return input[l] * input[r];
        }
    }
}

#[aoc(day1, part2)]
fn solve_part2(nums: &[u32]) -> Option<u32> {
    for l in 0..nums.len() {
        for m in l + 1..nums.len() {
            for r in m + 1..nums.len() {
                if nums[l] + nums[m] + nums[r] == 2020 {
                    return Some(nums[l] * nums[m] * nums[r]);
                }
            }
        }
    }
    None
}

#[cfg(test)]
mod tests {
    use super::*;

    #[test]
    fn test_solve() {
        assert_eq!(solve_part1(&[1721, 979, 366, 299, 675, 1456]), 514579);
        assert_eq!(
            solve_part2(&[1721, 979, 366, 299, 675, 1456]),
            Some(241861950)
        )
    }
}
