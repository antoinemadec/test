// https://doc.rust-lang.org/stable/book/ch03-05-control-flow.html

fn main() {
    for n in 40..42 {
        println!("fibo_rec({}) = 0x{:x}", n, fibo_rec(n));
    }
    for n in 40..42 {
        println!("fibo_seq({}) = 0x{:x}", n, fibo_seq(n));
    }
    for n in 180..=185 {
        println!("fibo_seq({}) = 0x{:x}", n, fibo_seq(n));
    }
}

fn fibo_rec(n: u32) -> u128 {
    if n <= 1 {
        1
    } else {
        fibo_rec(n-1) + fibo_rec(n-2)
    }
}

fn fibo_seq(n: u32) -> u128 {
    let mut r = 1;
    if n > 1 {
        let mut m1 = 1;
        let mut m2 = 1;
        for _ in 1..n {
            r = m1 + m2;
            m2 = m1;
            m1 = r;
        }
    }
    r
}
