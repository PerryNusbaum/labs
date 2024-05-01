// SPDX-License-Identifier: Unlicense
pragma solidity ^0.8.24;

import "forge-std/Test.sol";
import "forge-std/console.sol";
// import "@openzeppelin/contracts/token/ERC20/IERC20.sol";
import "@hack/staking/StakingRewards.sol";
import "@hack/myCoin/MyERC20.sol";

contract StakingRewardsTest is Test{
    uint wad = 10 ** 18;
    StakingRewards public nms;
    // MyERC20 st;
    // MyERC20 rt;
    MyERC20 public st;
    MyERC20 public rt;

    address user1=vm.addr(1);
    address user2=vm.addr(2);
    address user3=vm.addr(3);

    function setUp() public{
        st = new MyERC20("StekingToken","ST");
        rt = new MyERC20("RewardToken","RT");

        nms = new StakingRewards(address(st), address(rt));

        rt.mint(address(nms), 100000 * wad);

        st.mint(user1, 100 * wad);
        st.mint(user2, 100 * wad);
        st.mint(user3, 100 * wad);
    }

}

