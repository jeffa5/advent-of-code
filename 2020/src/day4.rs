use aoc_runner_derive::aoc;
use aoc_runner_derive::aoc_generator;
use regex::Regex;
use std::collections::HashMap;

#[aoc_generator(day4)]
fn input_generator(input: &str) -> Vec<HashMap<String, String>> {
    input
        .split("\n\n")
        .map(|g| {
            g.split_whitespace()
                .filter_map(|p| {
                    let parts = p.splitn(2, ':').collect::<Vec<_>>();
                    if let [a, b] = parts.as_slice() {
                        Some((a.to_string(), b.to_string()))
                    } else {
                        None
                    }
                })
                .collect()
        })
        .collect()
}

#[aoc(day4, part1)]
fn solve_part1(passports: &[HashMap<String, String>]) -> usize {
    passports
        .iter()
        .filter(|p| {
            p.get("byr").is_some()
                && p.get("iyr").is_some()
                && p.get("eyr").is_some()
                && p.get("hgt").is_some()
                && p.get("hcl").is_some()
                && p.get("ecl").is_some()
                && p.get("pid").is_some()
        })
        .count()
}

#[aoc(day4, part2)]
fn solve_part2(passports: &[HashMap<String, String>]) -> usize {
    let re = Regex::new(r"#[0-9a-f]{6}").unwrap();
    passports
        .iter()
        .filter(|p| {
            p.get("byr").is_some()
                && p.get("iyr").is_some()
                && p.get("eyr").is_some()
                && p.get("hgt").is_some()
                && p.get("hcl").is_some()
                && p.get("ecl").is_some()
                && p.get("pid").is_some()
        })
        .filter(|p| {
            let byr = p["byr"].parse::<u32>().unwrap();
            (1920..=2002).contains(&byr)
        })
        .filter(|p| {
            let iyr = p["iyr"].parse::<u32>().unwrap();
            (2010..=2020).contains(&iyr)
        })
        .filter(|p| {
            let eyr = p["eyr"].parse::<u32>().unwrap();
            (2020..=2030).contains(&eyr)
        })
        .filter(|p| {
            let hgt = &p["hgt"];
            if let Some(cm) = hgt.strip_suffix("cm") {
                let cm = cm.parse::<u32>().unwrap();
                (150..=193).contains(&cm)
            } else if let Some(inch) = hgt.strip_suffix("in") {
                let inch = inch.parse::<u32>().unwrap();
                (59..=76).contains(&inch)
            } else {
                false
            }
        })
        .filter(|p| {
            let hcl = &p["hcl"];
            re.is_match(hcl)
        })
        .filter(|p| {
            let ecl = &p["ecl"];
            ecl == "amb"
                || ecl == "blu"
                || ecl == "brn"
                || ecl == "gry"
                || ecl == "grn"
                || ecl == "hzl"
                || ecl == "oth"
        })
        .filter(|p| {
            let pid = &p["pid"];
            pid.len() == 9 && pid.parse::<u32>().is_ok()
        })
        .count()
}
