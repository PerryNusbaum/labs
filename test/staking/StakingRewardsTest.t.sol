// // SPDX-License-Identifier: Unlicense
// pragma solidity ^0.8.24;

// import "forge-std/Test.sol";
// import "forge-std/console.sol";
// // import "@openzeppelin/contracts/token/ERC20/IERC20.sol";
// import "@hack/staking/StakingRewards.sol";
// import "@hack/myCoin/MyERC20.sol";

// contract StakingRewardsTest is Test{
//     uint wad = 10 ** 18;
//     StakingRewards public sr;
//     // MyERC20 st;
//     // MyERC20 rt;
//     MyERC20 public st;
//     MyERC20 public rt;

//     address user1=vm.addr(1);
//     address user2=vm.addr(2);
//     address user3=vm.addr(3);

//     function setUp() public{
//         st = new MyERC20("StekingToken","ST");
//         rt = new MyERC20("RewardToken","RT");

//         sr = new StakingRewards(address(st), address(rt));

//         rt.mint(address(sr), 100000 * wad);

//         st.mint(user1, 100 * wad);
//         st.mint(user2, 100 * wad);
//         st.mint(user3, 100 * wad);
//     }

//     // function stakeTest() public{
//     //     vm.startPrank(user1);
//     //     sr.stake(100 * wad);
//     //     vm.warp(block.timestamp + 2 days);
//     //     sr.getReward();
//     //     assertEq(user1.balance, 172800 * 0.0016);
//     //     vm.stopPrank();
//     // }
// // function stakeTest() public {
// //     // Store initial balance of user1
// //     uint256 initialBalance = user1.balance;
    
// //     // Start the staking process
// //     vm.startPrank(user1);
// //     sr.stake(100 * wad);
    
// //     // Fast forward time by 2 days
// //     vm.warp(block.timestamp + 2 days);
    
// //     // Claim reward
// //     sr.getReward();
    
// //     // Calculate reward amount
// //     uint256 rewardAmount = (172800 * 16) / 10000; // Calculate reward amount as a separate step
    
// //     // Calculate expected balance after staking and reward claim
// //     uint256 expectedBalance = initialBalance + rewardAmount;
    
// //     // Assert the balance of user1
// //     assertEq(user1.balance, expectedBalance);
    
// //     // Stop the staking process
// //     vm.stopPrank();
// // }

// function testStake()public {
//         vm.startPrank(user1);
//         uint256 initialBalance = user1.balance;
//         st.approve(address(sr),100);
//         sr.stake(100);
//         vm.warp(block.timestamp + 2 days);
//         sr.getReward();
//         uint256 balance = address(user1).balance;
//         uint256 scale = 10000;
//         uint256 scaledMultiplier = 16;
//         uint256 twoDays = (172800 * scaledMultiplier) / scale;
//         assertEq(balance, initialBalance + twoDays, "wrong!!!" );
//         vm.stopPrank();
//     }


// }

