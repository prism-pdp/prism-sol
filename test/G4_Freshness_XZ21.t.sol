// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.24;

import "./Base_XZ21_Setup.t.sol";

contract G4_Freshness_XZ21 is Base_XZ21_Setup {
    function check_G4_AuditingLogsOrder (
        bytes32 hashVal,
        uint256 time1,
        uint256 time2
    ) public {
        vm.assume(100 < time1);
        vm.assume(time2 < time1);

        vm.prank(SP_ADDR);
        s.registerFile(hashVal, 10, SU_ADDR);

        _setupAuditing(hashVal);
        vm.warp(100); vm.prank(TPA_ADDR);
        s.setAuditingResult(hashVal, true);

        _setupAuditing(hashVal);
        vm.warp(time1); vm.prank(TPA_ADDR);
        s.setAuditingResult(hashVal, true);

        _setupAuditing(hashVal);
        vm.warp(time2); vm.prank(TPA_ADDR);
        try s.setAuditingResult(hashVal, true) {
            fail();
        } catch {
        }
    }

    function _setupAuditing(
        bytes32 hashVal
    ) private {
        bytes memory chal  = bytes("test chal");
        bytes memory proof = bytes("test proof");

        vm.prank(SU_ADDR);
        s.setChal(hashVal, chal);

        vm.prank(SP_ADDR);
        s.setProof(hashVal, proof);
    }
}