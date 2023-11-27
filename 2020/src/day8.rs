use aoc_runner_derive::{aoc, aoc_generator};
use std::{collections::HashSet, convert::TryInto};

enum Operation {
    Acc(i32),
    Jmp(i32),
    Nop(i32),
}

#[derive(Default)]
struct State {
    accumulator: i32,
}

#[aoc_generator(day8)]
fn input_generator(input: &str) -> Vec<Operation> {
    input
        .lines()
        .map(|l| {
            let parts: Vec<_> = l.split_whitespace().collect();
            match parts.as_slice() {
                ["acc", num] => Operation::Acc(num.parse().unwrap()),
                ["jmp", num] => Operation::Jmp(num.parse().unwrap()),
                ["nop", num] => Operation::Nop(num.parse().unwrap()),
                p => {
                    panic!("Unmatched operation: {:?}", p)
                }
            }
        })
        .collect()
}

#[aoc(day8, part1)]
fn solve_part1(operations: &[Operation]) -> usize {
    let mut state = State::default();
    let mut ip = 0i32;
    let mut ips = HashSet::new();
    loop {
        if ips.contains(&ip) {
            break;
        } else {
            ips.insert(ip);
        }

        let op = &operations[ip as usize];
        match op {
            Operation::Acc(n) => {
                state.accumulator += n;
                ip += 1i32
            }
            Operation::Jmp(n) => ip += n,
            Operation::Nop(n) => ip += 1i32,
        }
    }
    state.accumulator.try_into().unwrap()
}

#[aoc(day8, part2)]
fn solve_part2(operations: &[Operation]) -> usize {
    0
}
