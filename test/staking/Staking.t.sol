// SPDX-License-Identifier: Unlicense
pragma solidity ^0.8.24;

import "forge-std/Test.sol";
import "forge-std/console.sol";
import "@hack/staking/Staking.sol";

contract StakingTest is Test{
    Staking public s;

    function setUp() public{
        s = new Staking();
    } 

    function testDeposit() public{
        uint initialBalance = address(s).balance;
        console.log(address(s).balance);
        uint amount = 120;
        s.deposit(amount);
        console.log(address(s).balance);
        assertEq(address(s).balance - initialBalance, amount);
    }
}