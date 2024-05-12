// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.13;

import {Test, console} from "forge-std/Test.sol";
import {BaseCounter} from "../src/BaseCounter.sol";

contract BaseCounterTest is Test {
    BaseCounter public counter;
    BaseCounter public counterMin;
    BaseCounter public counterMax;

    uint256 num = 100;
    uint256 numMin = 0;
    uint256 numMax = 2**256 - 1;

    function setUp() public {
        counter = new BaseCounter(num);
        counterMin = new BaseCounter(numMin);
        counterMax = new BaseCounter(numMax);
    }

    function testIncrement() public {
        counter.increment();
        assertEq(counter.count(), num + 1);
    }

    function testDecrement() public {
        counter.decrement();
        assertEq(counter.count(), num - 1);
    }

    function testOverflow() public {
        counterMax.increment();
        assertEq(counterMax.count(), numMax);
    }

    function testUnderflow() public {
        counterMin.decrement();
        assertEq(counterMin.count(), numMin);
    }
}
