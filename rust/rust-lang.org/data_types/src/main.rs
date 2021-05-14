fn main() {
    let c: char = 'z';
    let heart_eyed_cat: char = '😻'; // char is on 4 bytes
    let f: bool = false;
    println!("{} {} {}", c, heart_eyed_cat, f);

    let sum = 5 + 10;
    let difference = 95.5 - 4.3;
    let product = 4 * 30;
    let quotient = 56.7 / 32.2;
    let remainder = 43 % 5;
    println!(
        "{} {} {} {} {}",
        sum, difference, product, quotient, remainder
    );

    let tup = (500, 6.4, 1);
    let (_x, y, _z) = tup;
    println!("y is {}", y);

    let x: (i32, f64, u8) = (500, 6.4, 1);
    let five_hundred = x.0;
    let six_point_four = x.1;
    let one = x.2;
    println!("{} {} {}", five_hundred, six_point_four, one);

    let mut a: [i32; 5] = [1, 2, 3, 4, 5];
    println!("a={:?}", a);
    println!("a[4]={}", a[4]);
    a = [3; 5];
    println!("a={:?}", a);

    // thread 'main' panicked at 'index out of bounds: the len is 5 but the index is 5'
    let index: usize = 5;
    println!("a[{}]={}", index, a[index]);
}
