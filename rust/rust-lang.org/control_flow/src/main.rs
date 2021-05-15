// https://doc.rust-lang.org/stable/book/ch03-05-control-flow.html

fn main() {
    let x = 3;

    if x < 5 {
        println!("cond is true");
    } else {
        println!("cond is false");
    }

    if x % 4 == 0 {
        println!("x is divisible by 4");
    } else if x % 3 == 0 {
        println!("x is divisible by 3");
    } else if x % 2 == 0 {
        println!("x is divisible by 2");
    } else {
        println!("x is not divisible by 4, 3, or 2");
    }

    // if expression (not a statement)
    // this is how the ternary operator looks like in Rust
    let x = if true { 5 } else { 4 };
    println!("x = {}", x);

    // loop expression (not a statement)
    let mut counter = 0;
    let result = loop {
        counter += 1;

        if counter == 10 {
            break counter * 2; // break <RETURN_VAL>;
        }
    };
    println!("The result is {}", result);

    // while statement
    while counter < 5 {
        counter += 1;
    }
    println!("counter = {}", counter);

    // for statement
    let a = [12, 13, 14, 15];
    for element in a.iter() {
        println!("element = {}", element);
    }
    for number in (1..4).rev() {
        println!("number = {}", number);
    }
}
