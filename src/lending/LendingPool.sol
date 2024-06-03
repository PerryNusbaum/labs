// // SPDX-License-Identifier: MIT

// pragma solidity ^0.8.20;
// contract LendingPool interface ILendingPool{
//         function _sendDaiToAave(uint256 _amount) internal {
//         dai.approve(address(aave), _amount);
//         aave.deposit(address(dai), _amount, address(this), 0);
//     }

//     function _withdrawDaiFromAave(uint256 _amount) internal {
//         aave.withdraw(address(dai), _amount, msg.sender);
//     }

//     function _sendWethToAave(uint256 _amount) internal {
//         wethGateway.depositETH{value: _amount}(address(aave), address(this), 0);
//     }

//     function _withdrawWethFromAave(uint256 _amount) internal {
//         aWeth.approve(address(wethGateway), _amount);
//         wethGateway.withdrawETH(address(aave), _amount, address(this));
//     }
// }