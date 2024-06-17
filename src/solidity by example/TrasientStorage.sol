//SPDX-License-Identifier:MIT
pragma solidity 0.8.19;

interface ITest {
    function val() external view returns (uint256);
    function test() external;
}

contract Callback {
    uint256 public val;

    fallback() external {
        val = ITest(ms)
    }
}