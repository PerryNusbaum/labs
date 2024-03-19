// SPDX-License-Identifier: UNLICENSED

//what us mean this operands in the pragma line?
pragma solidity >=0.7.0 <0.9.0;

/// @title Storage
/// @author Perry Nusbaum
/// @dev Store & retrieve value in a variable

contract Storage{

    // a number after the uint data type limits the number
    uint256 number;

    //this mark /** use for documentation?
    /**
    * @dev Store value in variable
    * @param num value to store
    */
    function store(uint256 num) public {
        number = num;
    }

    //when we write @dev in the documentation it speak to the developer?
    /**
    * @dev Return value
    * @return value of 'number'
    */
    function retrieve() public view returns(uint256){
        return number;
    }
}