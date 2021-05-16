// https://doc.rust-lang.org/stable/book/ch04-02-references-and-borrowing.html

fn main() {
    // painful...
    {
        let s1 = String::from("hello");
        let (s2, len) = calculate_length(s1);
        println!("The length of '{}' is {}.", s2, len);
    }

    // ...reference is better
    {
        let s = String::from("hello");
        let len = calculate_length_with_ref(&s);
        println!("The length of '{}' is {}.", s, len);
    }

    // mutable reference
    {
        let mut s = String::from("hello");
        change(&mut s);
        println!("{}", s);
    }

    // multiple references
    {
        // mutliple refs:       OK
        // 1 mut ref:           OK
        // 2 mut ref:           FAIL
        // 1 mut ref + 1 ref:   FAIL
        //
        // Note that a reference’s scope starts from where it is introduced and continues through
        // the last time that reference is used. For instance, this code will compile because the
        // last usage of the immutable references occurs before the mutable reference is
        // introduced:
        let mut s = String::from("hello");
        let r1 = &s; // no problem
        let r2 = &s; // no problem
        println!("{} and {}", r1, r2);
        // r1 and r2 are no longer used after this point
        let r3 = &mut s; // no problem
        println!("{}", r3);
    }
}

fn change(s: &mut String) {
    s.push_str(" world");
}

fn calculate_length_with_ref(s: &String) -> usize {
    let length = s.len();
    length
}

fn calculate_length(s: String) -> (String, usize) {
    let length = s.len(); // len() returns the length of a String
    (s, length)
}
