// SPDX-License-Identifier: MIT

pragma solidity ^0.8.20;

import "@hack/myCoin/MyERC20.sol";
import "@openzeppelin/contracts/token/ERC20/IERC20.sol";
contract Lending{
    IERC20 public daiToken;

    MyERC20 public bondToken;

    address public owner;

    uint public rewardPerS;
    uint public wad = 10 ** 18;

    mapping (address => uint) public daiDeposits;
    mapping (address => uint) public depositsTime;
    mapping (address => uint) public rewards;


    constructor(address bond) {
        owner = msg.sender;
        daiToken = IERC20(0x6B175474E89094C44Da98b954EedeAC495271d0F);
        bondToken = MyERC20(bond);
        rewardPerS = 0.000000000002 * 1e18;
    }

    modifier updateReward(address user) {
        if(daiDeposits[user] > 0){
            uint duration = block.timestamp - depositsTime[user];
            rewards[user] += (duration * rewardPerS) / 1e18;
            depositsTime[user] = block.timestamp;
        }
        _;
    }

    function depositDai(uint amount) external updateReward(msg.sender){
        require(amount != 0, "amount equals 0");
        require(daiToken.balanceOf(msg.sender) >= amount);
        daiDeposits[msg.sender] += amount;
        daiToken.transferFrom(msg.sender, address(this), amount);
        bondToken.mint(msg.sender, amount);
    }

    function withdrawDai(uint amount) external updateReward(msg.sender){
        require(amount != 0, "amount equals 0");
        require(amount <= (rewards[msg.sender] + daiDeposits[msg.sender]));
        daiToken.transferFrom(address(this), msg.sender, amount);
        if(rewards[msg.sender] < amount){
            amount -= rewards[msg.sender];
            rewards[msg.sender] = 0;
            daiDeposits[msg.sender] -= amount;
            bondToken.burn(msg.sender, amount);
        }
        else{
            rewards[msg.sender] -= amount;
        }
    }
}