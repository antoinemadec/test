// https://doc.rust-lang.org/stable/book/ch05-01-defining-structs.html

// derive(Debug) allows to print structures
#[derive(Debug)]
struct User {
    username: String,
    email: String,
    sign_in_count: u64,
    active: bool,
}

#[derive(Debug)]
struct Rectangle {
    width: u32,
    height: u32,
}

impl Rectangle {
    fn area(&self) -> u32 {
        self.width * self.height
    }
    fn can_hold(&self, other_rect: &Rectangle) -> bool {
        self.width >= other_rect.width && self.height >= other_rect.height
    }
    // associated function does not take "self" (=static func)
    fn square(size: u32) -> Rectangle {
        Rectangle {
            width: size,
            height: size,
        }
    }
}

fn main() {
    // either the whole struct is mutable or none of its fields are mutable
    let mut user1 = User {
        email: String::from("someone@example.com"),
        username: String::from("someusername123"),
        active: true,
        sign_in_count: 1,
    };
    user1.email = String::from("toto@prout.cul");
    user1 = build_user(
        String::from("coucou@loulous.les"),
        String::from("Jean-Mich Caca"),
    );

    let user2 = User {
        email: String::from("another@example.com"),
        username: String::from("anotherusername567"),
        ..user1 // equivalent to active: user1.active and sign_in_count: user1.sign_in_count
    };

    println!("{:?}", user1);
    println!("{:?}", user2);

    // Tuple Structs (without named fields)
    #[derive(Debug)]
    struct Color(i32, i32, i32);
    #[derive(Debug)]
    struct Point(i32, i32, i32);

    let black = Color(0, 0, 0);
    let origin = Point(0, 0, 0);
    println!("{:?}", black);
    println!("{:?}", origin);

    // example: compute area
    // -- tuple
    let rect = (20, 40);
    println!("area = {}", area_tuple(rect));
    // -- struct
    let rect = Rectangle {
        width: 20,
        height: 40,
    };
    println!("rectangle = {:#?}", rect); // {:#?} prints fields line by line
    println!("area = {}", area_struct(&rect));
    // -- struct  with method
    println!("area = {}", rect.area());
    let rect1 = Rectangle {
        width: 30,
        height: 50,
    };
    let rect2 = Rectangle {
        width: 10,
        height: 40,
    };
    let rect3 = Rectangle {
        width: 60,
        height: 45,
    };
    println!("Can rect1 hold rect2? {}", rect1.can_hold(&rect2));
    println!("Can rect1 hold rect3? {}", rect1.can_hold(&rect3));
    println!("square 5 = {:#?}", Rectangle::square(5));
}

fn build_user(email: String, username: String) -> User {
    User {
        email,    // equivalent to email: email
        username, // equivalent to username: username
        active: true,
        sign_in_count: 1,
    }
}

fn area_tuple(r: (u32, u32)) -> u32 {
    r.0 * r.1
}

fn area_struct(r: &Rectangle) -> u32 {
    r.width * r.height
}
