include "./util/number.dfy"
include "./util/maps.dfy"
include "./util/tx.dfy"
include "./erc20.dfy"


import opened Number
import opened Maps
import opened Tx


class Bond {
  // a 160-bit unsigned integer that uniquely identifies the address. However,
  // this value is not directly used as the external representation, that is in u256

    const baseRate: u256 := 20_000_000_000_000_000
    const annuRate: u256 := 300_000_000_000_000_000

    var a: nat
    var balances:   mapping<u160,u256>
    var collateral: mapping<u160, u256>
    var borrowed:   mapping<u160, u256>
    var b: nat

    method addTwo(num1: nat, num2: nat) returns (r: nat)
    modifies this`a
    requires num1 > 0 && num2 > 0
    ensures a >= 2{
        a := num1 + num2;
        return a;
    }

    method sum(num1: nat, num2: nat) returns (r: Result<()>)
    modifies this`b, this`a
    requires num1 > 0 && num2 > 0
    ensures b >= 2{
        b := addTwo(num1,num2);
        return Ok(());
    }


    // deposit dai
    method bondAsset(msg: Transaction) returns (r: Result<()>) 
    // add collateral
    method deposit(msg: Transaction) returns (r: Result<()>)
    modifies this`collateral {
        assume {:axiom} (MAX_U256 as u256 - collateral.Get(msg.sender)) >= msg.value;
        collateral := balances.Set(msg.sender, collateral.Get(msg.sender) + msg.value);
        return Ok(());
    }


}