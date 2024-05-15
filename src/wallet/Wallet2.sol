// SPDX-License-Identifier: GPL-3.0

pragma solidity >=0.7.0 <0.9.0;

/// @title Wallet2
/// @dev

contract Wallet2 {
    // i did the owner public to get the get function when i compile the code
    // to let others to see who is the owner
    address public owner;
    address public gabai1;
    address public gabai2;
    address public gabai3;

    constructor() {
        //the oener is equal to the owner's address
        owner = msg.sender;
        gabai1 = 0x9876543210987654321098765432109876543210;
        gabai2 = 0x9876543210987654321098765432109876543210;
        gabai3 = 0x9876543210987654321098765432109876543210;
    }

    function getOwner() public view returns (address) {
        return owner;
    }

    function getGabai1() public view returns (address) {
        return gabai1;
    }

    function getGabai2() public view returns (address) {
        return gabai2;
    }

    function getGabai3() public view returns (address) {
        return gabai3;
    }

    function changeUser(address oldUser, address newUser) external {
        require(owner == msg.sender, "you can't do this action");
        if (gabai1 == oldUser) {
            gabai1 = newUser;
            return;
        }
        if (gabai2 == oldUser) {
            gabai2 = newUser;
            return;
        }
        if (gabai3 == oldUser) {
            gabai3 = newUser;
            return;
        }
    }

    // there is a built in function called receive
    // this function deposit funds to the wallet's contract
    // it must be external
    receive() external payable {}

    function withdraw(uint256 amount) external {
        require(
            msg.sender == owner || msg.sender == gabai1 || msg.sender == gabai2 || msg.sender == gabai3,
            "you dont have permition"
        );
        require(address(this).balance >= amount, "there is'nt enough funds in the contract");
        // transfer is a built in function
        // we can use it only on address that is payable
        // thas function send funds from one address to an other
        payable(msg.sender).transfer(amount);
    }

    function getBalance() public view returns (uint256) {
        return address(this).balance;
    }
}
