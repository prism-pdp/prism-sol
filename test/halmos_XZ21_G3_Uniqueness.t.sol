// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.24;

import "./Base_XZ21_Setup.t.sol";

contract G3_Uniqueness_XZ21 is Base_XZ21_Setup {
    function check_G3_registerFile_NoDuplication (
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