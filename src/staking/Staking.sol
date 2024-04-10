// SPDX-License-Identifier: MIT

pragma solidity ^0.8.24;

import "@openzeppelin/contracts/token/ERC20/ERC20.sol";
import "@openzeppelin/contracts/token/ERC20/IERC20.sol";
import "../myCoin/MyERC20.sol";

contract Staking is ERC20{

    IERC20 public immutable stakingToken;

    address public owner;

    mapping (address => mapping(uint => uint)) usersDeposit;
    mapping (address => uint) numOfDeposit;
    
    uint256 public rewardAmount = 1000000; 
    
    constructor () ERC20 ("myToken","MTK"){
        owner = msg.sender;
        stakingToken = IERC20(address(this));
        _mint (address(this), rewardAmount);
    }

    function deposit(uint amount) external{
        require(amount > 0, "amount = 0");
        stakingToken.transfer(address(this), amount);
        usersDeposit[msg.sender][block.timestamp] = amount;
        numOfDeposit[msg.sender] += 1;
    } 

    modifier reward(address user){
        require(user!=address(0), "Address does not make sense");
        _;
    }

    function calculateRewards(uint amount) internal view returns (uint) {
        uint balance = stakingToken.balanceOf(address(this)) - rewardAmount;
        uint percentage = (amount * 100) / balance;
        uint totalReward = (rewardAmount * 2) / 100;
        uint rewardToSend = (totalReward * percentage) / 100;
        return (rewardToSend);
    }

    function withdraw(uint amount)  external reward(msg.sender){
        require(amount > 0, "amount = 0");

        for (uint i = 0; i < numOfDeposit[msg.sender] && amount != 0; i++) {
            //variable time = the time he deposit
            uint time = usersDeposit[msg.sender][i];
            // Check if the timestamp is valid (not 0) and if it's been more than a week
            require(block.timestamp > time + 1 weeks, "Time has not passed");
            uint depositedAmount = usersDeposit[msg.sender][time];
            if (amount <= depositedAmount) {
                usersDeposit[msg.sender][time] -= amount;
                amount=0;
            } else {
                usersDeposit[msg.sender][time] = 0;
                amount -= depositedAmount;
            }
        }
        require(amount == 0, "you cant withdraw this amount");        
        // Calculate and transfer rewards
        uint rewardToSend = calculateRewards(amount);
        stakingToken.transferFrom(address(this), msg.sender, rewardToSend + amount * 10 ** uint(decimals()));
        rewardAmount -= rewardToSend;
    }

    function getBalance() external view returns(uint){
        return stakingToken.balanceOf(address(this));
    }
}