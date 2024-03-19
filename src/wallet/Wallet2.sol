// SPDX-License-Identifier: GPL-3.0

pragma solidity >=0.7.0 <0.9.0;

/// @title Wallet1
/// @dev

contract Wallet1 {
    // i did the owner public to get the get function when i compile the code
    // to let others to see who is the owner
    address public owner;
    // address[] public gabaiAddresses;
    // address[] public gabaiAddresses = [
    //     0x1234567890123456789012345678901234567890,
    //     0x9876543210987654321098765432109876543210
    // ];
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

    //     function addAddress(address _newAddress) public {
    //         require(gabaiAddresses.length < 3);
    //             gabaiAddresses.push(_newAddress);
    // }
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
        require(msg.sender == owner || msg.sender == gabai1 || msg.sender == gabai2 || msg.sender == gabai3, "you dont have permition");
        require(
            address(this).balance >= amount,
            "there is'nt enough funds in the contract"
        );
        // transfer is a built in function
        // we can use it only on address that is payable
        // thas function send funds from one address to an other
        payable(msg.sender).transfer(amount);
    }

    // function hasPermitionToWithdraw(address _address)
    //     internal
    //     view
    //     returns (bool)
    // {
    //     if (owner == _address) {
    //         return true;
    //     }
    //     for (uint256 i = 0; i < gabaiAddresses.length; i++) {
    //         if (gabaiAddresses[i] == _address) {
    //             return true;
    //         }
    //     }
    //     return false;
    // }

    function getBalance() public view returns (uint256) {
        return address(this).balance;
    }
}