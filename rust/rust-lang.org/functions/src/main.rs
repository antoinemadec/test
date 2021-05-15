fn main() {
    println!("Hello, world!");

    // let foo = 4; is an statement, it does not returns a value
    // same for functions etc

    // {stuff} is an expression, it returns a value
    let y = {
        let x = 3;
        x + 1
    };
    println!("y = {}", y);

    // function with no return value
    another_function(24, 29);

    // functions with return value
    let x = five();
    println!("x = {}", x);

    let x = plus_one(7);
    println!("x = {}", x);
}

fn plus_one(x: i32) -> i32 {
    x + 1
}

fn five() -> i32 {
    5
}

fn another_function(x: i32, y: i32) {
    println!("another_function: x = {}", x);
    println!("another_function: y = {}", y);
}
