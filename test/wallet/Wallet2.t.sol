// SPDX-License-Identifier: Unlicense
pragma solidity ^0.8.24;

import "forge-std/Test.sol";
import "forge-std/console.sol";
import "@hack/wallet/Wallet2.sol";


contract Wallet2Test is Test {
    Wallet2 public w;

    // Everything I need to start my test
    function setUp() public {
        w = new Wallet2();
    }

receive() external payable {}

function testRecieve() public payable{
    uint256 initialBalance = w.getBalance();
    uint256 amount = 50;
    // Send Ether to the contract
    payable(address(w)).transfer(amount);
    // Check if the contract balance has increased by the sent amount
    assertEq(w.getBalance() - initialBalance, amount);
    console.log(w.getBalance());
}

function testFuzz_recieve(uint256 amount) public payable{
    vm.assume(amount>0);
    address any = address(0x5);
    vm.startPrank(any);
    uint256 initialBalance = w.getBalance();
    // Send Ether to the contract
    vm.deal(any, amount);
    payable(address(w)).transfer(amount);
    // Check if the contract balance has increased by the sent amount
    assertEq(w.getBalance() - initialBalance, amount);
    vm.stopPrank();
    console.log(w.getBalance());
}

function testWithdraw() public {
    uint256 amount = 20;
    payable(address(w)).transfer(amount);
    uint256 initialBalance = address(w).balance; // Use address(w) to get contract balance
    console.log(address(w).balance);
    w.withdraw(20);
    uint256 afterBalance = initialBalance - amount;
    assertEq( afterBalance, address(w).balance); // Check contract balance change
}

function testFuzz_withdraw(uint256 amount)public {
    vm.assume(amount>0);
    address any = w.getGabai1();
    vm.startPrank(any);
    // Send Ether to the contract
    vm.deal(any, amount);
    payable(address(w)).transfer(amount);
    uint256 initialBalance = address(w).balance; // Use address(w) to get contract balance
    console.log(address(w).balance);
    w.withdraw(amount);
    uint256 afterBalance = initialBalance - amount;
    assertEq( afterBalance, address(w).balance); // Check contract balance change
    vm.stopPrank();
}

function testNotAllowedWithdraw() public {
    address nonPermitted = address(0x5);// Correct variable name
    vm.startPrank(nonPermitted);
    uint256 balanceBefore = address(w).balance; // Use test contract balance
    vm.expectRevert(); // Expecting a revert due to unauthorized withdrawal
    w.withdraw(5); // Attempting withdrawal
    uint256 balanceAfter = address(w).balance; // Use test contract balance
    assert(balanceBefore == balanceAfter); // Check contract balance remains unchanged
    vm.stopPrank();
}

function testAllowedWithdraw() public {
    address payable[] memory permiteted = new address payable[](4);
    permiteted[0] = payable(w.getOwner());
    permiteted[1] = payable(w.getGabai1());
    permiteted[2] = payable(w.getGabai2());
    permiteted[3] = payable(w.getGabai3());
    uint index = uint(keccak256(abi.encodePacked(block.timestamp, block.prevrandao))) % 4;
    payable(address(w)).transfer(5);
    vm.startPrank(permiteted[index]);
    uint256 balanceBefore = permiteted[index].balance;
    w.withdraw(5); // Withdrawal by authorized user
    uint256 balanceAfter = permiteted[index].balance;
    assert(balanceAfter - balanceBefore == 5); // Check balance increase by 5
    vm.stopPrank();
}

    function testGetBalance() public{
        assertEq(address(w).balance,w.getBalance());
    }

    function testAllowedChangeUser() public {
        address owner = w.getOwner();
        address newG = address(0x4);
        address [] memory old = new address[](3);
        old[0] = payable(w.getGabai1());
        old[1] = payable(w.getGabai2());
        old[2] = payable(w.getGabai3());
        uint index = uint(keccak256(abi.encodePacked(block.timestamp, block.prevrandao))) % 3;
        vm.startPrank(owner);
        w.changeUser(old[index], newG);
        assert(w.getGabai1() == newG || w.getGabai2() == newG || w.getGabai3() == newG);
        vm.stopPrank();
    }
    function testNotAlloweChangeUser() public {
        address other = address(0x6);
        address newG = address(0x4);
        address [] memory old = new address[](3);
        old[0] = payable(w.getGabai1());
        old[1] = payable(w.getGabai2());
        old[2] = payable(w.getGabai3());
        uint index = uint(keccak256(abi.encodePacked(block.timestamp, block.prevrandao))) % 3;
        vm.startPrank(other);
        vm.expectRevert();
        w.changeUser(old[index], newG);
        assert(w.getGabai1() == old[0] && w.getGabai2() == old[1] && w.getGabai3() == old[2]);
        vm.stopPrank();
    }

}
