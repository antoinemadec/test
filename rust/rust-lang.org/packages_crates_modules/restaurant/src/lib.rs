// Packages: A Cargo feature that lets you build, test, and share crates
// Crates: A tree of modules that produces a library or executable
// Modules and use: Let you control the organization, scope, and privacy of paths
// Paths: A way of naming an item, such as a struct, function, or module

mod front_of_house {
    pub mod hosting {
        pub fn add_to_waitlist() {}
        fn seat_at_table() {}
    }
    mod serving {
        fn take_order() {}
        fn serve_order() {}
        fn make_payement() {}
    }
}

mod back_of_house {
    // pub struct = structure is public but its fields are private
    pub struct Breakfast {
        pub toast: String,
        seasonal_fruit: String,
    }

    // pub enum = all of its variant are public
    pub enum Apetizer {
        Soup,
        Salad,
    }

    impl Breakfast {
        pub fn summer(toast: &str) -> Breakfast {
            Breakfast {
                toast: String::from(toast),
                seasonal_fruit: String::from("peaches"),
            }
        }
    }
}

pub fn eat_at_restaurant() {
    let mut meal = back_of_house::Breakfast::summer("Rye");
    meal.toast = String::from("Wheat");
    println!("I'd like {}", meal.toast);

    let order1 = back_of_house::Apetizer::Salad;
    let order2 = back_of_house::Apetizer::Soup;
}
