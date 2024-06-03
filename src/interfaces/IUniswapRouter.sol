//SPDX-License-Identifier: Unlicense
pragma solidity ^0.8.7;

import "./ISwapRouter.sol";

interface IUniswapRouter is ISwapRouter {
    function refundETH() external payable;
}