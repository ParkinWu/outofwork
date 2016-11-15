use std::thread;
use std::time::Duration;

fn main() {
    // 创建一个线程
    let new_thread = thread::spawn(move || {
        // 再创建一个线程
        thread::spawn(move || {
            loop {
                println!("I am a new thread.");
            }
        })
    });

    // 等待新创建的线程执行完成
    new_thread.join().unwrap();
    println!("Child thread is finish!");

    // 睡眠一段时间，看子线程创建的子线程是否还在运行
    thread::sleep(Duration::from_millis(1));
}