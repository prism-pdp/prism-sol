// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.13;

contract BaseCounter {
    uint256 public count;

    constructor() {
        count = 0;
    }

    function setCount(uint256 _newVal) public {
        count = _newVal;
    }

    function increment() public {
        if (count < (2**256 - 1)) {
            count++;
        }
    }

    function decrement() public {
        if (0 < count) {
            count--;
        }
    }
}
