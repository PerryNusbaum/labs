// SPDX-License-Identifier: MIT
pragma solidity ^0.8.24;

// import "../myCoin/MyERC20.sol";
import "@openzeppelin/contracts/token/ERC20/ERC20.sol";


contract AMM{
    address public owner;

    uint public total;
    uint public balanceA;
    uint public balanceB;

    ERC20 public immutable A;
    ERC20 public immutable B;

    // MyERC20 public immutable A;
    // MyERC20 public immutable B;

    // constructor(string memory nameA, string memory symbolA, string memory nameB, string memory symbolB) {
        constructor(address a, address b){
        owner = msg.sender;
        // A = new MyERC20(nameA, symbolA);
        // B = new MyERC20(nameB, symbolB);
        A = ERC20(a);
        B = ERC20(b);
        balanceA = 100;
        balanceB = 100;
        A.transferFrom(msg.sender, address(this), balanceA);  
        B.transferFrom(msg.sender, address(this), balanceB);
        // A.mint (address(this), balanceA); 
        // B.mint (address(this), balanceB);    
    }

    function price() public view returns(uint){
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
}