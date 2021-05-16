// https://doc.rust-lang.org/stable/book/ch04-01-what-is-ownership.html

fn main() {
    {
        let s = String::from("coucou"); // alocate memory on the heap
        println!("{}", s);
    }
    // deallocate memory at the end of s lifetime

    // move (shallow copy + invalidate)
    {
        // deallocating memory at the end of s1 and s2 would create a double free error, so Rust
        // compiler considers s1 not to be valid when s2 = s1
        //
        // because Rust invalidates the first variable, instead of being called a shallow copy,
        // it’s known as a move
        //
        // s1 was moved to s2
        let s1 = String::from("hello");
        let s2 = s1;
        // println!("{}", s1); // FAIL
        println!("{}", s2);
    }

    // clone (deep copy)
    {
        let s1 = String::from("hello");
        let s2 = s1.clone();

        println!("s1 = {}, s2 = {}", s1, s2);
    }

    // copy (stack-only data)
    {
        let x = 5;
        let y = x;
        println!("{} {}", x, y);
    }

    // ownership and functions
    {
        let s = String::from("hello");
        takes_ownership(s); // s's value moves into the function...
                            // ... and so is no longer valid here
        // println!("{}", s); // FAIL

        let x = 5;          // x comes into scope
        makes_copy(x);      // x would move into the function,
                            // but i32 is Copy, so it's okay to still
        println!("{}", x);  // use x afterward
    }


    // return values and scope
    {
        let s1 = gives_ownership();         // gives_ownership moves its return
        // value into s1

        let s2 = String::from("hello");     // s2 comes into scope

        let s3 = takes_and_gives_back(s2);  // s2 is moved into
        // takes_and_gives_back, which also
        // moves its return value into s3
        println!("{} {}", s1, s3);
    }
}

fn takes_and_gives_back(some_string: String) -> String {
    some_string
}

fn gives_ownership() -> String {
    let some_string = String::from("coucou");
    some_string
}

fn makes_copy(some_int: i32) {
    println!("{}", some_int)
}

fn takes_ownership(some_string: String) {
    println!("{}", some_string);
}
