// SPDX-License-Identifier: MIT
pragma solidity ^0.8.24;

import "../myCoin/MyERC20.sol";
// import "@openzeppelin/contracts/token/ERC20/ERC20.sol";


contract AMM{
    address public owner;

    uint public total;
    uint public balanceA;
    uint public balanceB;

    // ERC20 public immutable A;
    // ERC20 public immutable B;

    mapping (address => uint) providers;

    MyERC20 public immutable A;
    MyERC20 public immutable B;

    // constructor(string memory nameA, string memory symbolA, string memory nameB, string memory symbolB) {
        constructor(address a, address b,uint amountA, uint amountB){
        owner = msg.sender;
        A = MyERC20(a);
        B = MyERC20(b);
        // A = ERC20(a);
        // B = ERC20(b);
        balanceA = amountA;
        balanceB = amountB;
        A.transferFrom(msg.sender, address(this), balanceA);  
        B.transferFrom(msg.sender, address(this), balanceB);
        // A.mint (address(this), balanceA); 
        // B.mint (address(this), balanceB);    
    }

    function price() public returns(uint){
        total = balanceA * balanceB;
        return total;
    }

    function tradeAToB(uint amountA) external {
        require (amountA > 0, "it must be greaternthan 0");
        uint initialB = balanceB;
        balanceA += amountA;
        balanceB = price() / balanceA;
        A.transferFrom(msg.sender, address(this), amountA);
        B.transferFrom(address(this), msg.sender, (initialB - balanceB));
    }

    function tradeBToA(uint amountB) external {
        require (amountB > 0, "it must be greaternthan 0");
        uint initialA = balanceA;
        balanceB += amountB;
        balanceA = price() / balanceB;
        B.transferFrom(msg.sender, address(this), amountB);
        A.transferFrom(address(this), msg.sender, (initialA - balanceA));
    }

    function addLiduidity(uint amount) external{
        require (amount > 0, "it must be greater than 0");
        uint calc = amount / (balanceA + balanceB);
        uint amountA = calc * balanceA;
        uint amountB = calc * balanceB;
        require(A.balanceOf(msg.sender) > amountA && B.balanceOf(msg.sender) > amountB);
        balanceA += amountA;
        balanceB += amountB;
        A.transfer(address(this), amountA);
        B.transfer(address(this), amountB);
        providers[msg.sender] = amount;
    }

        function removeLiduidity(uint amount) external{
        require (amount > 0, "it must be greater than 0");
        require (providers[msg.sender] >= amount, "you don't have enough tokens in the pool");
        uint calc = amount / (balanceA + balanceB);
        uint amountA = calc * balanceA;
        uint amountB = calc * balanceB;
        balanceA -= amountA;
        balanceB -= amountB;
        A.transferFrom(address(this), msg.sender, amountA);
        B.transferFrom(address(this), msg.sender, amountB);
        providers[msg.sender] -= amount;
    }
}