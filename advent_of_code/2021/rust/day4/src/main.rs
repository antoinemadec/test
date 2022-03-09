use std::{
    fs::File,
    io::{BufRead, BufReader},
};

struct Bingo {
    grid: [[u8; 5]; 5],
    marks: [[u8; 5]; 5],
    check_rows: [u8; 5],
    check_cols: [u8; 5],
}

impl Bingo {
    pub fn new(grid: [[u8; 5]; 5]) -> Self {
        Bingo {
            grid,
            marks: [[0; 5]; 5],
            check_rows: [0; 5],
            check_cols: [0; 5],
        }
    }

    pub fn update(&mut self, n: u8) {
        for i in 0..5 {
            for j in 0..5 {
                if self.grid[i][j] == n {
                    self.check_rows[j] += 1;
                    self.check_cols[i] += 1;
                    self.marks[i][j] = 1;
                }
            }
        }
    }

    pub fn bingo(&self) -> bool {
        for i in 0..5 {
            if self.check_rows[i] == 5 || self.check_cols[i] == 5 {
                return true;
            }
        }
        return false;
    }

    pub fn score(&self, n: u8) -> u32 {
        let mut s: u32 = 0;
        for i in 0..5 {
            for j in 0..5 {
                if self.marks[i][j] == 0 {
                    s += self.grid[i][j] as u32;
                }
            }
        }
        s * (n as u32)
    }
}

fn read(filename: &str) -> (Vec<Bingo>, Vec<u8>) {
    let mut lines = BufReader::new(File::open(filename).unwrap()).lines();

    let numbers: Vec<u8> = lines
        .next()
        .unwrap()
        .unwrap()
        .split(',')
        .map(|n| n.parse().unwrap())
        .collect();

    let mut bingos: Vec<Bingo> = Vec::new();
    let mut grid = [[0; 5]; 5];
    let mut i = 0;
    for line in lines {
        let line = line.unwrap();
        if line == "" {
            continue;
        }
        for (j, val) in line
            .split_whitespace()
            .map(|n| n.parse::<u8>().unwrap())
            .enumerate()
        {
            grid[i][j] = val;
        }
        i += 1;
        if i == 5 {
            bingos.push(Bingo::new(grid));
            i = 0;
        }
    }

    (bingos, numbers)
}

fn p1(filename: &str) -> u32 {
    let (mut bingos, numbers) = read(filename);
    for n in numbers {
        for b in &mut bingos {
            b.update(n);
            if b.bingo() {
                return b.score(n);
            }
        }
    }
    return 0;
}

fn p2(filename: &str) -> u32 {
    let (mut bingos, numbers) = read(filename);
    for n in numbers {
        for b in &mut bingos {
            b.update(n);
        }
        if bingos.len() == 1 && bingos[0].bingo() {
            return bingos[0].score(n);
        }
        bingos.retain(|b| b.bingo() == false);
    }
    return 0;
}

fn main() {
    println!("p1 {}", p1("src/input.txt"));
    println!("p2 {}", p2("src/input.txt"));
}
