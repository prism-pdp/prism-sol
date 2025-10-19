// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.24;

import "./Base_XZ21_Setup.t.sol";

contract G2_Immutability_XZ21 is Base_XZ21_Setup {
    function test_G2_registerParam_onlyOnce (
        string memory testP,
        bytes  memory testG,
        bytes  memory testU
    ) public {
        // Halmos/ fuzz 安定化のため入力を軽く制約（任意）
        vm.assume(bytes(testP).length <= 16);
        vm.assume(testG.length <= 32);
        vm.assume(testU.length <= 32);

        vm.prank(SM_ADDR);
        try s.registerParam(testP, testG, testU) {
            fail();
        } catch {
            // OK（常に revert を期待）
        }
    }
}