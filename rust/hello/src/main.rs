fn main() {
    let x = 1..10000000000;
    let mut sum:i64 = 0;
    for i in x {
        sum += i;
    }
    println!("sum = {:#?}", sum);
}