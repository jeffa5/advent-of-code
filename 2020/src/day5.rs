use std::collections::HashSet;

use aoc_runner_derive::aoc;
use aoc_runner_derive::aoc_generator;

enum RowSelector {
    Front,
    Back,
}

enum ColumnSelector {
    Left,
    Right,
}

#[aoc_generator(day5)]
fn input_generator(input: &str) -> Vec<(Vec<RowSelector>, Vec<ColumnSelector>)> {
    input
        .lines()
        .map(|l| {
            let rows = l
                .chars()
                .take(7)
                .filter_map(|c| {
                    if c == 'F' {
                        Some(RowSelector::Front)
                    } else if c == 'B' {
                        Some(RowSelector::Back)
                    } else {
                        None
                    }
                })
                .collect();
            let cols = l
                .chars()
                .skip(7)
                .take(3)
                .filter_map(|c| {
                    if c == 'L' {
                        Some(ColumnSelector::Left)
                    } else if c == 'R' {
                        Some(ColumnSelector::Right)
                    } else {
                        None
                    }
                })
                .collect();
            (rows, cols)
        })
        .collect()
}

fn find_row(rows: &[RowSelector]) -> usize {
    let mut min = 0;
    let mut max = 127;
    let mut end = 0;
    for r in rows {
        match r {
            RowSelector::Front => {
                let diff = max - min;
                if diff % 2 == 0 {
                    max -= diff / 2
                } else {
                    max -= (diff + 1) / 2
                }
                end = max
            }
            RowSelector::Back => {
                let diff = max - min;
                if diff % 2 == 0 {
                    min += diff / 2
                } else {
                    min += (diff + 1) / 2
                }
                end = min
            }
        }
    }
    end
}

fn find_column(cols: &[ColumnSelector]) -> usize {
    let mut min = 0;
    let mut max = 7;
    let mut end = 0;
    for c in cols {
        match c {
            ColumnSelector::Left => {
                let diff = max - min;
                if diff % 2 == 0 {
                    max -= diff / 2
                } else {
                    max -= (diff + 1) / 2
                }
                end = max
            }
            ColumnSelector::Right => {
                let diff = max - min;
                if diff % 2 == 0 {
                    min += diff / 2
                } else {
                    min += (diff + 1) / 2
                }
                end = min
            }
        }
    }
    end
}

#[aoc(day5, part1)]
fn solve_part1(passes: &[(Vec<RowSelector>, Vec<ColumnSelector>)]) -> usize {
    passes
        .iter()
        .map(|(rows, cols)| {
            let row = find_row(rows);
            let col = find_column(cols);
            row * 8 + col
        })
        .max()
        .unwrap()
}

#[aoc(day5, part2)]
fn solve_part2(passes: &[(Vec<RowSelector>, Vec<ColumnSelector>)]) -> usize {
    let seat_ids: HashSet<usize> = passes
        .iter()
        .map(|(rows, cols)| {
            let row = find_row(rows);
            let col = find_column(cols);
            row * 8 + col
        })
        .collect();

    let max = seat_ids.iter().max().unwrap();
    for i in (0..*max).filter(|i| !seat_ids.contains(i)) {
        if seat_ids.contains(&(i - 1)) && seat_ids.contains(&(i + 1)) {
            return i;
        }
    }
    0
}
