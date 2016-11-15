extern crate time;
fn timestamp() -> f64 {
    let timespec = time::get_time();
    // 1459440009.113178
    let mills: f64 = timespec.sec as f64 + (timespec.nsec as f64 / 1000.0 / 1000.0 / 1000.0 );
    mills

}

fn main() {
    let mut start = timestamp();
    let x = factorial1(20, 1);
    let mut end = timestamp();
    println!("x = {:#?}", x);
    println!("end - start = {:#?}", end - start);


    start = timestamp();
    let y = factorial2(20);
    end = timestamp();
    println!("y = {:#?}", y);
    println!("end - start = {:#?}", end - start);


    start = timestamp();
    let z = factorial3(20);
    end = timestamp();
    println!("z = {:#?}", z);
    println!("end - start = {:#?}", end - start);
}
//
fn factorial1(n: i64, total: i64) -> i64 {
    if n == 1 {
        return total;
    }
    factorial1(n-1, n * total)
}
fn factorial2(n: i64) -> i64 {
    let mut result = 1;
    for i in 1..n + 1 {
        result = result * i
    }
    return result;
}


fn factorial3(n: u64) -> u64 {
    if n == 1 {
        return 1;
    }
    factorial3(n - 1) * n
}
