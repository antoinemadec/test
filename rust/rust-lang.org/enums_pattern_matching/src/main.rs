// https://doc.rust-lang.org/stable/book/ch06-00-enums.html

enum IpAddrKind {
    V4,
    V6,
}

struct IpAddrStuct {
    _kind: IpAddrKind,
    _address: String,
}

enum IpAddr {
    V4(String),
    V6(String),
}

#[derive(Debug)]
enum Message {
    Quit,
    Move { x: i32, y: i32 },
    Write(String),
    ChangeColor(i32, i32, i32),
}

impl Message {
    fn call(&self) {
        match self {
            Message::Quit => println!("Quit"),
            Message::Move { x, y } => println!("MOVE {} {}", x, y),
            Message::Write(msg) => println!("WRITE {}", msg),
            Message::ChangeColor(r, g, b) => println!("COLOR {} {} {}", r, g, b),
        }
    }
}

fn plus_one(x: Option<i32>) -> Option<i32> {
    match x {
        None => None,
        Some(i) => Some(i+1),
    }
}

fn print_val(x: Option<i32>) {
    match x {
        None => (),
        Some(i) => match i {
            5 => println!("is equal to 5"),
            _ => println!("value not supported"),
        }
    }
}

fn main() {
    let _four = IpAddrKind::V4;
    let _six = IpAddrKind::V6;

    // using a stuct with enum kind + address
    let _home = IpAddrStuct {
        _kind: IpAddrKind::V4,
        _address: String::from("127.0.0.1"),
    };

    let _loopback = IpAddrStuct {
        _kind: IpAddrKind::V6,
        _address: String::from("::1"),
    };

    // using enum instead to associate a string to each enum variant
    let _home = IpAddr::V4(String::from("127.0.0.1"));
    let _loopback = IpAddr::V6(String::from("::1"));

    // enums can also define methods !
    let m = Message::Write(String::from("hello"));
    m.call();
    let m = Message::ChangeColor(43, 56, 78);
    m.call();
    let m = Message::Move { x: 3, y: 6 };
    m.call();
    let m = Message::Quit;
    m.call();

    // Option enum (built-in, part of prelude):
    //      enum Option<T> {
    //          Some(T),
    //          None,
    //      }
    let _some_number = Some(5);
    let _some_string = Some("a string");

    // if we use None rather than Some, we need to tell Rust what type of Option<T> we have,
    // because the compiler can’t infer the type that the Some variant will hold by looking only at
    // a None value
    let _absent_num: Option<i32> = None;

    // why is Option<T> better than null ?
    // because T and Option<T> are not the same type
    // let x: i32 = 5;
    // let y: Option<i32> = Some(5);
    // let z = x+y; // ERROR: cannot add `Option<i32>` to `i32`

    let five = Some(5);
    let six = plus_one(five);
    let none = plus_one(None);
    print_val(five);
    print_val(six);
    print_val(none);

    if five == Some(6) {
        println!("5 == 6 [!]");
    }

    match five {
        Some(i) => println!("match val={}", i),
        _ => (),
    }

    if let Some(i) = five {
        println!("if let val={}", i);
    }
}
