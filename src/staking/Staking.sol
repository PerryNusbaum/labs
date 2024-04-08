// SPDX-License-Identifier: MIT

pragma solidity ^0.8.24;

import "@openzeppelin/contracts/token/ERC20/IERC20.sol";
import "../myCoin/MyERC20.sol";

contract Staking{
//    IERC20 public immutable stakingToken = IERC20(0xfF68d3992672636400ea3E6c653CCc9A4ee3C163);

    IERC20 public immutable stakingToken;

    address public owner;
//    mapping (address => uint256) public depositTime;
    mapping (address => uint) numOfDeposit;
    
    uint256 public totalSupply = 1000000; 
    
    constructor (address _stakingToken){
//    constructor(){
        owner = msg.sender;
        
        stakingToken = IERC20(_stakingToken);
//        stakingToken = IERC20(0xfF68d3992672636400ea3E6c653CCc9A4ee3C163);
        stakingToken.transfer(address(this),totalSupply);
    }

    function deposit(uint amount) external{
        require(amount > 0, "amount = 0");
        stakingToken.transfer(address(this), amount);
        usersDeposit[msg.sender][block.timestamp] = amount;
        numOfDeposit[msg.sender] += 1;
//        depositTime[msg.sender] = block.timestamp;
    } 

    function withdraw(uint amount) external{
        require(usersDeposit[msg.sender] >= amount,"you deposit less");
//        require(depositTime[msg.sender] - block.timestamp > 1 weeks);
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