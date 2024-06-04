fn main(x: felt252, y: felt252){
    assert(x != y, 'error, w is equal to y')
}

#[test]
fn test_main(){
    main(1,2);
}