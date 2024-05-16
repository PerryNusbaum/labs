// SPDX-License-Identifier: UNLICENSED

pragma solidity >=0.7.0 <0.9.0;

/**
 * @title Owner
 * @dev Set & change owner
 */
contract Owner {
    address private owner;

    //what is an event EVM logging
    event OwnerSet(address indexed oldOwner, address indexed newOwner);

    //what is modifier? how it is work?
    modifier isOwner() {
        //if the require returns false
        //anything will happend Unlike in the past
        //in require we can send a second argument to explain what he check
        require(msg.sender == owner, "Caller is not owner");
        //what it is mean _; ?
        _;
    }

    /**
     * @dev Set contract deployer as owner
     */
    constructor() {
        owner = msg.sender;
        emit OwnerSet(address(0), owner);
    }

    /**
     * @dev change owner
     * @param newOwner address of new owner
     */
    function changeOwner(address newOwner) public isOwner {
        emit OwnerSet(owner, newOwner);
        owner = newOwner;
    }

    /**
     * @dev Return Owner address
     * @return address of owner
     */

    //what is external
    function getOwner() external view returns (address) {
        return owner;
    }
}
