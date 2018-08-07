use std::env;
use std::io;
use std::process::Command;

fn main() {
    let usr = env::var("USER").unwrap();
    let width: f32 = {
        let get_width = Command::new("tmux")
            .args(&["display-message", "-p", "#{window_width}"])
            .output()
            .expect("failed to get tmux width");
        let output = String::from_utf8_lossy(&get_width.stdout);
        output[0..output.find('\n').unwrap()].parse().unwrap()
    };
    let ratio: f32 = {
        let mut args = env::args();
        args.next().unwrap();
        args.next().unwrap().parse().unwrap()
    };
    let length = (width * ratio) as usize;
    let path = {
        let mut s = String::new();
        io::stdin().read_line(&mut s).unwrap();
        s = s.replace(&format!("/Users/{}", usr), "~");
        let l = s.len();
        if l > length {
            s.replace_range(0..l - length, &"");
            if let Some(i) = s.find('/') {
                s.replace_range(0..i + 1, &"");
            }
        }
        s
    };
    println!("{}", path);
}
