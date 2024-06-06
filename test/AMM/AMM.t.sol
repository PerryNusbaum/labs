// SPDX-License-Identifier: Unlicense
pragma solidity 0.8.19;

import "forge-std/Test.sol";
import "forge-std/console.sol";
import "@hack/amm/AMM.sol";
import "@hack/myCoin/MyERC20.sol";
import "openzeppelin-contracts/contracts/token/ERC20/ERC20.sol";

contract AMMTest is Test {
    AMM public amm;
    MyERC20 public a;
    MyERC20 public b;

    function setUp() public {
        a = new MyERC20("tokenA", "a");
        b = new MyERC20("tokenB", "b");
        amm = new AMM(address(a), address(b), 100, 200);
    }

    function tradeAToBTest() public {}
}
