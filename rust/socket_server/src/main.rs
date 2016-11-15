//use std::fmt::{Display, Formatter, Result};
//fn main() {
//    println!("{0}, {1}, {0}, {1}", "name", "age");
//    println!("name = {name}, age = {age}", name="parkinwu", age=25);
//    println!("22 = {:b}", 22);
//    println!("{0:>0width$}",6, width = 5);
//    println!("{0:<0width$}",6, width = 5);
//
//
//    let s = format!("{0}, {1}, {0}, {1}", "name", "age");
//
//    println!("s = {:#?}", s);
//
//    struct Person (i32);
//
//    impl Display for Person {
//        fn fmt(&self, f: &mut Formatter) -> Result {
//            write!(f, "{}", self.0)
//        }
//
//    }
//
//    println!("Person(32) = {}", Person(32));
//}

//use std::fmt;
//struct List(Vec<i32>);
//
//impl fmt::Display for List {
//    fn fmt(&self, f: &mut fmt::Formatter) -> fmt::Result {
//        let List(ref vec) = *self;
//        try!(write!(f, "["));
//        for (count, v) in vec.iter().enumerate() {
//            if count != 0 { try!(write!(f, ", ")); }
//            try!(write!(f, "{}", v));
//        }
//        write!(f, "]")
//    }
//}
//fn main() {
//    let l = List(vec![1, 2, 3, 5]);
//    println!("l = {}", l);
//}

//use std::mem;
//fn main() {
//    let x: [i32; 5] = [1, 2, 3, 4, 5];
//    let ys: [i32; 200] = [0; 200];
//    println!("mem::size_of_val = {:#?}", mem::size_of_val(&x));
//
//    let cs: [char; 5] = ['a', 'b', 'c', 'd', 'e'];
//    println!("mem::size_of_val = {:#?}", mem::size_of_val(&cs));
//
//}

//fn main() {
//    enum Color {
//        Red = 0xff0000,
//        Green = 0x00ff00,
//        Blue = 0x0000ff,
//    }
//}

const PI:f64 = 3.141592653;
fn main() {

}