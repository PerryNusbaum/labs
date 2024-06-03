// SPDX-License-Identifier: MIT
pragma solidity 0.8.19;

library StorageSlot {
    struct AddressSlot {
        address value;
    }

    function getAddressSlot(bytes32 slot)
        internal
        pure
        returns (AddressSlot storage r)
    {
        assembly {
            r.slot := slot
        }
    }
}

contract TestSlot {
    bytes32 public constant slot = keccak256("TEST_SLOT");

    function getSlot() external view returns (address) {
        return StorageSlot.getAddressSlot(slot).value;
    }

    function writeSlot(address _addr) external {
        StorageSlot.getAddressSlot(slot).value = _addr;
    }
}