use aoc_runner_derive::aoc;
use aoc_runner_derive::aoc_generator;

#[aoc_generator(day3)]
fn input_generator(input: &str) -> Vec<Vec<bool>> {
    input
        .lines()
        .map(|l| {
            l.chars()
                .map(|c| {
                    if c == '.' {
                        false
                    } else if c == '#' {
                        true
                    } else {
                        panic!("Unexpected char {} in input", c)
                    }
                })
                .collect()
        })
        .collect()
}

fn solve(tree_grid: &[Vec<bool>], slopes: &[(usize, usize)]) -> usize {
    slopes
        .iter()
        .map(|(r, d)| {
            (0..tree_grid[0].len())
                .cycle()
                .step_by(*r)
                .zip((0..tree_grid.len()).step_by(*d))
                .map(|(x, y)| tree_grid[y][x] as usize)
                .sum::<usize>()
        })
        .product()
}

#[aoc(day3, part1)]
fn solve_part1(tree_grid: &[Vec<bool>]) -> usize {
    solve(tree_grid, &[(3, 1)])
}

#[aoc(day3, part2)]
fn solve_part2(tree_grid: &[Vec<bool>]) -> usize {
    solve(tree_grid, &[(1, 1), (3, 1), (5, 1), (7, 1), (1, 2)])
}
