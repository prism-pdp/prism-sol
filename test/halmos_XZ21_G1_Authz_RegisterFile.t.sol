// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.24;

import {XZ21} from "../src/XZ21.sol";
import {Test} from "forge-std/Test.sol";

contract G1_Authz_XZ21_RegisterFile is Test{

    address constant SM_ADDR  = address(0x1000);
    address constant SP_ADDR  = address(0x2000);
    address constant SU_ADDR  = address(0x3000);

    function test_G1_registerFile_onlySP(
        address caller
    ) public {
        vm.prank(SM_ADDR);
        XZ21 s = new XZ21(SP_ADDR);

        vm.prank(SM_ADDR);
        s.enrollAccount(1, SU_ADDR, hex"01");

        vm.prank(caller);
        try s.registerFile(keccak256("file"), 10, SU_ADDR) {
            if (caller != SP_ADDR) {
                fail();
            }
        } catch {
            if (caller == SP_ADDR) {
                fail();
            }
        }
    }
}