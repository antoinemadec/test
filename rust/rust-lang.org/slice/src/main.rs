// https://doc.rust-lang.org/stable/book/ch04-03-slices.html

fn main() {
    let s = String::from("hello world this is dad");
    let mut word = first_word(&s);
    println!("{}", word);

    word = nth_word(&s, 1);
    println!("{}", word);
    word = nth_word(&s, 3);
    println!("{}", word);

    let a = [1, 2, 3, 4, 5];
    let slice = &a[1..3];
    println!("{}", slice[0]);
}

fn nth_word(s: &str, n: usize) -> &str {
    let mut word_index = 0;
    let mut start_byte = 0;
    for (i, item) in s.bytes().enumerate() {
        if item == b' ' {
            if word_index == n {
                return &s[start_byte..i];
            }
            word_index += 1;
            start_byte = i + 1;
        }
    }
    &s[start_byte..]
}

fn first_word(s: &str) -> &str {
    let bytes = s.as_bytes();
    for (i, &item) in bytes.iter().enumerate() {
        if item == b' ' {
            return &s[..i];
        }
    }
    &s[..]
}
