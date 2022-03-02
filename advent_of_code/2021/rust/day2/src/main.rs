use std::{
    fs::File,
    io::{BufRead, BufReader},
};

#[derive(Debug)]
struct Move {
    dir: String,
    val: i32,
}

impl Move {
    pub fn new(line: String) -> Self {
        let split: Vec<&str> = line.split(' ').collect();
        Move {
            dir: String::from(split[0]),
            val: split[1].parse().unwrap(),
        }
    }
}

fn read(filename: &str) -> Vec<Move> {
    let io = File::open(filename).unwrap();
    let br = BufReader::new(io);
    br.lines().map(|line| Move::new(line.unwrap())).collect()
}

fn p1(filename: &str) -> i32 {
    let mut horiz: i32 = 0;
    let mut depth: i32 = 0;
    for m in read(filename) {
        match m.dir.as_str() {
            "forward" => horiz += m.val,
            "down" => depth += m.val,
            "up" => depth -= m.val,
            _ => panic!(),
        }
    }
    horiz * depth
}

fn p2(filename: &str) -> i32 {
    let mut horiz: i32 = 0;
    let mut depth: i32 = 0;
    let mut aim: i32 = 0;
    for m in read(filename) {
        match m.dir.as_str() {
            "down" => aim += m.val,
            "up" => aim -= m.val,
            "forward" => {
                horiz += m.val;
                depth += aim * m.val;
            }
            _ => panic!(),
        }
    }
    horiz * depth
}

fn main() {
    println!("p1 {}", p1("src/input.txt"));
    println!("p2 {}", p2("src/input.txt"));
}
