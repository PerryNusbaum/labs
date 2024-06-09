// SPDX-License-Identifier: MIT
pragma solidity 0.8.19;

// Transparent upgradeable proxy pattern

contract CounterV1 {
    uint256 public count;
    address public add;

    function inc() external {
        count += 1;
    }

    // add.delegatecall
}

