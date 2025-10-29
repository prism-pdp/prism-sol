// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.24;

import {Test} from "forge-std/Test.sol";
import {XZ21} from "../src/XZ21.sol"; // 置き場所に合わせて調整

contract G3_Uniqueness_XZ21 is Test {
    XZ21 internal s;

    address constant SM_ADDR  = address(0x1000);
    address constant SP_ADDR  = address(0x2000);
    address constant SU_ADDR  = address(0x3000);

    function setUp() public {
        vm.prank(SM_ADDR);
        s = new XZ21(SP_ADDR);

        vm.prank(SM_ADDR);
        s.enrollAccount(1, SU_ADDR, hex"01");
    }

    function test_G3_registerFile(
        bytes32 hashVal,
        uint32 otherSplitNum,
        address otherCreator
    ) public {
        // 1st register
        vm.prank(SP_ADDR);
        s.registerFile(hashVal, 10, SU_ADDR);

        // 2nd register
        vm.prank(SP_ADDR);
        try s.registerFile(hashVal, otherSplitNum, otherCreator) {
            fail();
        } catch {}
    }
}