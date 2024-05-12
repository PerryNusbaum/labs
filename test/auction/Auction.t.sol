// SPDX-License-Identifier: Unlicense
pragma solidity ^0.8.24;

import "forge-std/Test.sol";
import "forge-std/console.sol";
import "@hack/auction/Auction.sol";
import "@hack/myCoin/MyERC20.sol";
import "@hack/myCoin/MyERC721.sol";
// import "@openzeppelin/contracts/token/ERC20/ERC20.sol";


contract AuctionTest is Test{
    Auction public auc;
    MyERC20 public token;
    MyERC721 public nft;


    function setUp() public{
        token = new MyERC20("tokenA", "a");
        nft = new MyERC721();
        auc = new Auction(80, address(token), address(nft));
    } 

    function testProposal() public{
        address user = vm.addr(1);
        vm.startPrank(user);
        token.mint(address(user), 120);
        console.log(token.balanceOf(user));
        token.approve(address(auc), 120);
        auc.proposal(120);
        console.log(token.balanceOf(user));
        assertEq(auc.winner(), user);
        assertEq(token.balanceOf(user),0);
        assertEq(auc.bidders(user), 120);
        vm.stopPrank();
    }

    function testWinnerCantCancel() public{
        address user = vm.addr(1);
        vm.startPrank(user);
        console.log(token.balanceOf(user));
        token.mint(address(user), 120);
        token.approve(address(auc), 120);
        auc.proposal(120);
        vm.expectRevert();
        auc.cancelation();
        vm.stopPrank();
    }

function testCancelation() public{
        address user1=vm.addr(1);
        address user2=vm.addr(2);
        vm.startPrank(user1);
        token.mint(address(user1),100);
        token.approve(address(auc),100);
        auc.proposal(100);
        vm.stopPrank();

        vm.startPrank(user2);
        token.mint(address(user2),130);
        token.approve(address(auc),130);
        auc.proposal(130);
        vm.stopPrank();

        vm.startPrank(user1);
        token.approve(user1,100);
        auc.cancelation();
        assertEq(token.balanceOf(address(user1)),100,"error not mach money");
        assertEq(token.balanceOf(address(auc)),130,"error not mach money");
        vm.stopPrank();
    }

        function testOverTime() public{
        address user = vm.addr(1);
        vm.startPrank(user);
        token.mint(address(user), 120);
        token.approve(address(auc), 120);
        auc.proposal(120);
        vm.warp(block.timestamp+ 9 days);
        vm.expectRevert();
        auc.cancelation();
        vm.stopPrank();
    }

    function testFinish() public{
        address user1=vm.addr(1);
        address user2=vm.addr(2);
        vm.startPrank(user1);
        token.mint(address(user1),100);
        token.approve(address(auc),100);
        auc.Proposal(100);
        vm.stopPrank();

        vm.startPrank(user2);
        token.mint(address(user2),130);
        token.approve(address(auc),130);
        auc.Proposal(130);
        vm.stopPrank();

        vm.startPrank(user1);
        vm.warp(block.timestamp+ 9 days);
        nft.approve(address(this),5);
        a.cancelation();
        assertEq(nftToken.balanceOf(user2),1,"error");
                          
        vm.stopPrank();
    }
}