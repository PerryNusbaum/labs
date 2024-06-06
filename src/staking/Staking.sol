// SPDX-License-Identifier: MIT
pragma solidity 0.8.19;

import {console} from "forge-std/Test.sol";
import "openzeppelin-contracts/contracts/token/ERC20/ERC20.sol";
import "openzeppelin-contracts/contracts/token/ERC20/IERC20.sol";
import "../myCoin/MyERC20.sol";

contract Staking {
    MyERC20 public immutable stakingToken;

    address public owner;

    mapping(address => mapping(uint256 => uint256)) usersDeposit;
    mapping(address => uint256) numOfDeposit;

    uint256 public rewardAmount = 1000000;

    constructor(address token) {
        owner = msg.sender;
        stakingToken = MyERC20(token);
        stakingToken.mint(address(this), rewardAmount);
    }

    function deposit(uint256 amount) external {
        require(amount > 0, "amount = 0");
        stakingToken.transferFrom(msg.sender, address(this), amount);
        usersDeposit[msg.sender][block.timestamp] = amount;
        numOfDeposit[msg.sender] += 1;
    }

    modifier reward(address user) {
        require(user != address(0), "Address does not make sense");
        _;
    }

    function calculateRewards(uint256 amount) internal view returns (uint256) {
        uint256 balance = stakingToken.balanceOf(address(this)) - rewardAmount;
        uint256 percentage = (amount * 100) / balance;
        uint256 totalReward = (rewardAmount * 2) / 100;
        uint256 rewardToSend = (totalReward * percentage) / 100;
        return (rewardToSend);
    }

    function withdraw(uint256 amount) external reward(msg.sender) {
        require(amount > 0, "amount = 0");

        for (uint256 i = 0; i < numOfDeposit[msg.sender] && amount != 0; i++) {
            //variable time = the time he deposit
            uint256 time = usersDeposit[msg.sender][i];
            // Check if the timestamp is valid (not 0) and if it's been more than a week
            console.log(time);
            require(block.timestamp > time + 1 weeks, "Time has not passed");
            uint256 depositedAmount = usersDeposit[msg.sender][time];
            require(depositedAmount > 0, "vjhbjk");
            if (amount <= depositedAmount) {
                usersDeposit[msg.sender][time] -= amount;
                amount = 0;
            } else {
                usersDeposit[msg.sender][time] = 0;
                amount -= depositedAmount;
            }
        }
        require(amount == 0, "you cant withdraw this amount");
        // Calculate and transfer rewards
        uint256 rewardToSend = calculateRewards(amount);
        stakingToken.transferFrom(address(this), msg.sender, rewardToSend + amount * 10 ** 18);
        rewardAmount -= rewardToSend;
    }

    function getBalance() external view returns (uint256) {
        return stakingToken.balanceOf(address(this));
    }
}
