// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.13;

import {Test, console} from "forge-std/Test.sol";
import {Counter} from "../src/Counter.sol";

contract CounterTest is Test {
    Counter public counter;
    Counter public counterMin;
    Counter public counterMax;

    uint256 num = 100;
    uint256 numMin = 0;
    uint256 numMax = 2**256 - 1;

    function setUp() public {
        counter = new Counter(num);
        counterMin = new Counter(numMin);
        counterMax = new Counter(numMax);
    }

    function testIncrement() public {
        counter.increment();
        assertEq(counter.number(), num + 1);
    }

    function testDecrement() public {
        counter.decrement();
        assertEq(counter.number(), num - 1);
    }

    function testOverflow() public {
        counterMax.increment();
        assertEq(counterMax.number(), numMax);
    }

    function testUnderflow() public {
        counterMin.decrement();
        assertEq(counterMin.number(), numMin);
    }
}
