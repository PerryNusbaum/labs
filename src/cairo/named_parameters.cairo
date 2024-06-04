fn foo(x: u8, y: u8) {
    x + y
}

fn main(){
    let first_arg = 3;
    let second_arg = 4;
    // parameter_name: value
    foo(x: first_arg, y:second_arg);
    // foo(y: second_arg, x: first_arg); <- this would produce an error
    let x = 1;
    let y = 2;
    foo(:x, :y);
}