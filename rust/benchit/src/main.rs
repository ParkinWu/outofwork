
struct Test (Option<i32>);

fn main() {
    let x = Test(Some(32));
    println!("x.0 = {:#?}", x.0.take());
}
