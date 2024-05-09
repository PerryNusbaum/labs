// SPDX-License-Identifier: MIT
// https://medium.com/@marketing.blockchain/how-to-create-a-multisig-wallet-in-solidity-cfb759dbdb35
pragma solidity ^0.8.20;
import "../myCoin/MyERC20.sol";
import "../myCoin/MyERC721.sol";

contract Auction {
    bool public flagFinish;

    address public owner;
    address winner;

    uint public finishTime;

    mapping(address=>uint) bidders;

    address [] public addresses;

    MyERC20 public immutable myToken;
    MyERC721 public immutable nft;

    constructor(uint sum,address token,address n){
        owner=msg.sender;
        myToken = MyERC20(token);
        nft=MyERC721(n);
        nft.mint(owner,5);
        bidders[msg.sender]=sum;
        winner=msg.sender;
        finishTime=block.timestamp + 7 days;
        flagFinish=false;
    }

    function Proposal(uint amount) external{  
        require(amount>bidders[winner],"not enough money");
        if(block.timestamp<finishTime){
            bidders[msg.sender]=amount;
            addresses.push(msg.sender);
            myToken.transferFrom(msg.sender,address(this),amount);
            winner=msg.sender;
        }
        else if(!flagFinish){
            flagFinish=true;
            finish();
        } 
    }

    function cancelation() external{
        require(winner!=msg.sender,"the winner cant cancel");
        if(block.timestamp<finishTime){
            myToken.transferFrom(msg.sender,address(this),bidders[msg.sender]);
            bidders[msg.sender]=0;
        }
        else if(!flagFinish){
            flagFinish=true;
            finish();
        } 
    }

    function finish() public{
        if(winner==owner){
            myToken.transferFrom(address(this),owner,bidders[owner]);
        }
        else{
        for(uint i=0;i<addresses.length;i++){
            if(bidders[addresses[i]]>0&&addresses[i]!=winner)
                myToken.transferFrom(address(this),addresses[i],bidders[addresses[i]]);
        }
        nft.transferFrom(owner,winner,5);
        }
    }

    function getCurrentWinner() external view returns(uint){
        return bidders[winner];
    }
}
