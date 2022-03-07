use std::{
    fs::File,
    io::{BufRead, BufReader},
};

fn read(filename: &str) -> (Vec<u32>, usize) {
    let f1 = File::open(filename).unwrap();
    let f2 = File::open(filename).unwrap();
    let vec = BufReader::new(f1)
        .lines()
        .map(|line| u32::from_str_radix(line.unwrap().as_str(), 2).unwrap())
        .collect();
    let width = BufReader::new(f2).lines().next().unwrap().unwrap().len();
    return (vec, width);
}

fn most_common_bit(numbers: &Vec<u32>, pos: usize) -> u32 {
    let cnt: u32 = numbers.iter().map(|val| (val >> pos) & 1).sum();
    return (cnt >= (numbers.len() as u32 + 1) / 2) as u32;
}

fn p1(filename: &str) -> u32 {
    let (numbers, width) = read(filename);
    let mut gamma: u32 = 0;
    let epsilon: u32;

    for pos in 0..width {
        gamma += most_common_bit(&numbers, pos) << pos;
    }
    epsilon = !gamma & ((1 << width) - 1);
    return gamma * epsilon;
}

fn p2(filename: &str) -> u32 {
    let (numbers, width) = read(filename);
    let mut numbers_o2 = numbers.clone();
    let mut numbers_co2 = numbers.clone();

    for pos in (0..width).rev() {
        if numbers_o2.len() != 1 {
            let mcb = most_common_bit(&numbers_o2, pos);
            numbers_o2.retain(|&val| ((val >> pos) & 1) == mcb);
        }
        if numbers_co2.len() != 1 {
            let mcb = most_common_bit(&numbers_co2, pos);
            numbers_co2.retain(|val| ((val >> pos) & 1) != mcb);
        }
    }

    return numbers_o2[0] * numbers_co2[0];
}

fn main() {
    println!("p1 {}", p1("src/input.txt"));
    println!("p2 {}", p2("src/input.txt"));
}
