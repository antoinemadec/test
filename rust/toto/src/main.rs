fn main() {
    let toto = "jicfb";
    println!("{}", toto);
    f(toto);
}

fn f(toto: &str) {
    println!("{}", toto);
}
