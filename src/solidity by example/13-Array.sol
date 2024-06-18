//SPDX-License-Identifier:MIT
pragma solidity 0.8.19;

contract Array {
    uint256 [] public arr;
    uint256 [] public arr2 = [1, 5, 10];
    uint256 [10] public myFixedSizeArr;

    function get(uint256 i) public view returns(uint256){
        return arr[i];
    }

    function getArr() public view returns(uint256[] memory){
        return arr;
    }

    function push(uint256 i) public {
        arr.push(i);
    }

    function pop() public {
        arr.pop();
    }

    function getLength() public view returns(uint256){
        return arr.length;
    }

    function remove(uint256 i) public {
        delete arr[i];
    }

    function removeByShifting(uint256 index) public {
        require(index < arr.length);
        for(uint256 i = index; i < arr.length; i++){
            arr[i] += arr[i+1];
        }
        arr.pop();
    }

    function replaceFromEnd(uint256 i) public {
        arr[i] = arr[arr.length - 1];
    }

    function examples() external {
        uint256[] memory a = new uint256[](5);
    }
}