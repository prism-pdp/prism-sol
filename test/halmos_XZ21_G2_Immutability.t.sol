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

    function invariant_G2_registerParam () public {
        XZ21.Param memory param = s.getParam();
        assertEq(keccak256(bytes(param.P)), keccak256(bytes(P)), "P changed");
        assertEq(keccak256(param.U), keccak256(U), "U changed");
        assertEq(keccak256(param.G), keccak256(G), "G changed");
    }
}