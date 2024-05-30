// SPDX-License-Identifier: Unlicense
pragma solidity ^0.8.24;

import "forge-std/Test.sol";
import "forge-std/console.sol";
import "@hack/amm/CP.sol";
import "openzeppelin-contracts/token/ERC20/IERC20.sol";
import "@hack/myCoin/MyERC20.sol";

contract CPTest is Test {
    CP public cp;
    MyERC20 public t1;
    MyERC20 public t2;

    function setUp() public {
        t1 = new MyERC20("token1", "t1");
        t2 = new MyERC20("token2", "t2");
        cp = new CP(address(t1), address(t2));
    }

    function testSwap() public {
        address user = vm.addr(1);
        vm.startPrank(user);
        t1.mint(address(user), 200);
        t2.mint(address(user), 200);
        t1.approve(address(cp), 50);
        t2.approve(address(cp), 90);
        cp.addLiquidity(50, 90);
        console.log(address(t1));
        uint256 initial2 = t2.balanceOf(address(cp));
        uint256 initial1 = t1.balanceOf(address(cp));
        console.log(t1.balanceOf(address(cp)));
        t1.approve(address(cp), 20);

        cp.swap(address(t1), 20);
        console.log(t1.balanceOf(address(cp)));
        console.log(t2.balanceOf(address(cp)));
    }
}
