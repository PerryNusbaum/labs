// SPDX-License-Identifier: MIT
pragma solidity ^0.8.24;

import "@hack/like/IERC20.sol";

contract Staking{
    IERC20 public immutable stakingToken;
    IERC20 public immutable rewardsToken;

    address public owner;

    mapping (address => uint256) public usersDeposit;
    mapping (address => uint256) public depositTime;
    
    uint256 public totalSupply = 1000000; 
    
    constructor (address _stakingToken){
        owner = msg.sender;
        
        stakingToken = IERC20(_stakingToken);
        stakingToken.transfer(address(this),totalSupply);
    }

    function deposit(uint amount) external{
        require(amount > 0, "amount = 0");
        stakingToken.transfer(address(this), amount);
        usersDeposit[msg.sender] += amount;
        depositTime[msg.sender] = block.timestamp;
    } 

    function withdraw(uint amount) external{
        require(usersDeposit[msg.sender] >= amount,"you deposit less");
        require(depositTime[msg.sender] - block.timestamp > 1 weeks);
        uint balance = stakingToken.balanceOf(address(this)) - totalSupply;
        uint percentage = (amount * 100) / balance;
        stakingToken.transferFrom(address(this), msg.sender, ((totalSupply * percentage) / 100)+amount);
        totalSupply -= (totalSupply * percentage) / 100;
        usersDeposit[msg.sender] -= amount;
    }

    function getBalance() external view returns(uint){
        return stakingToken.balanceOf(address(this));
    }
}