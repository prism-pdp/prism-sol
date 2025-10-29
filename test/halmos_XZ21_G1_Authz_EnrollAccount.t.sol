// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.24;

import {XZ21} from "../src/XZ21.sol";
import {Test} from "forge-std/Test.sol";

contract G1_Authz_XZ21_EnrollAccount is Test{

    address constant SM_ADDR  = address(0x1000);
    address constant SP_ADDR  = address(0x2000);

    address constant TEST_ADDR  = address(0x9000);

    function test_G1_enrollAccount_onlySM(
        address caller,
        int accountType
    ) public {
        vm.assume(accountType == 0 || accountType == 1);

        vm.prank(SM_ADDR);
        XZ21 s = new XZ21(SP_ADDR);

        vm.prank(caller);
        try s.enrollAccount(accountType, TEST_ADDR, hex"01") {
            if (caller != SM_ADDR) {
                fail();
            }
        } catch {
            if (caller == SM_ADDR) {
                fail();
            }
        }
    }
}