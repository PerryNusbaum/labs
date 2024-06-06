// SPDX-License-Identifier: Unlicense
pragma solidity 0.8.19;

import "forge-std/Test.sol";
import "forge-std/console.sol";
import "@hack/staking/Staking.sol";
import "@hack/myCoin/MyERC20.sol";

contract StakingTest is Test {
    Staking public s;
    MyERC20 public token;

    function setUp() public {
        token = new MyERC20("MyToken", "MTK");
        s = new Staking(address(token));
    }

    //     function testDeposit() public{
    //         uint initialBalance = s.getBalance();
    //         console.log(address(s).balance);
    //         console.log(address(s));
    //         console.log(address(this).balance);
    //         uint amount = 120;
    //         token.mint(address(this),amount);
    //         token.approve(address(s),amount);
    //         s.deposit(amount);
    //         console.log(s.getBalance());
    //         console.log(initialBalance);
    //         assertEq(s.getBalance() - initialBalance, amount);
    //         // s.usersDeposit
    //     }

    //     function testWithdraw() public{
    //         uint amount = 120;
    //         token.mint(address(this),amount);
    //         token.approve(address(s),amount);
    //         s.deposit(amount);
    //         vm.warp(block.timestamp + 7 days);
    //         uint initialBalance = s.getBalance();
    //         console.log(initialBalance);
    //         s.withdraw(amount);
    //         uint afterBalance = s.getBalance();
    //         console.log(afterBalance);
    //         assertEq(initialBalance - amount, afterBalance);
    //     }
}
