use std::{
    fs::File,
    io::{BufRead, BufReader},
};

fn read(filename: &str) -> Vec<i32> {
    let io = File::open(filename).unwrap();
    let br = BufReader::new(io);
    br.lines()
        .map(|line| line.unwrap().parse().unwrap())
        .collect()
}

fn core(filename: &str, win_size: usize) -> i32 {
    let mut cnt = 0;
    let vec = read(filename);
    for i in win_size..vec.len() {
        if vec[i] > vec[i - win_size] {
            cnt += 1;
        }
    }
    cnt
}

fn p1(filename: &str) -> i32 {
    core(filename, 1)
}

fn p2(filename: &str) -> i32 {
    core(filename, 3)
}

fn main() {
    println!("p1: {}", p1("src/input.txt"));
    println!("p2: {}", p2("src/input.txt"));
}
