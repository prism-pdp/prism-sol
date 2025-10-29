// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.24;

import {XZ21} from "../src/XZ21.sol";
import {Test} from "forge-std/Test.sol";

contract G1_Authz_XZ21_RegisterParam is Test {

    address constant SM_ADDR  = address(0x1000);
    address constant SP_ADDR  = address(0x2000);

    function test_G1_registerParam_onlySM(
        address caller
    ) public {
        vm.prank(SM_ADDR);
        XZ21 s = new XZ21(SP_ADDR);

        string memory testP = "P2"; // param.P は string だが内部では string
        bytes  memory testG = bytes("G2");
        bytes  memory testU = bytes("U2");

        vm.prank(caller);
        s = new XZ21(SP_ADDR);

        vm.prank(caller);
        try s.registerParam(testP, testG, testU) {
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