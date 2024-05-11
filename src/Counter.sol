// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.13;

contract Counter {
    uint256 public number;

    constructor(uint256 _num) {
        number = _num;
    }

    function increment() public {
        if (number < (2**256 - 1)) {
            number++;
        }
    }

    function decrement() public {
        if (0 < number) {
            number--;
        }
    }
}
