// When modules get large, you might want to move their definitions to a separate file to make the
// code easier to navigate.

// tells Rust to load the contents of the module from another file with the same name as the module
mod front_of_house;

pub use crate::front_of_house::hosting;

pub fn eat_at_restaurant() {
    hosting::add_to_waitlist();
    hosting::add_to_waitlist();
    hosting::add_to_waitlist();
}
