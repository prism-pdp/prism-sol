// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.24;

import "./Base_XZ21_Setup.t.sol";

contract G5_StateManagement_XZ21 is Base_XZ21_Setup {
    function check_G5_Start2WaitingProof (
        bytes32 hashVal
    ) public {
        bytes memory chal  = bytes("test chal");

        vm.prank(SU_ADDR);
        s.setChal(hashVal, chal);

        XZ21.AuditingLog[] memory logs = s.getAuditingLogs(hashVal);
        if (logs[0].stage != XZ21.Stages.WaitingProof) {
            fail();
        }
    }

    function test_G5_WaitingProof2WaitingResult (
        bytes32 hashVal
    ) public {
        bytes memory chal   = bytes("test chal");
        bytes memory proof  = bytes("test proof");

        vm.prank(SU_ADDR);
        s.setChal(hashVal, chal);

        vm.prank(SP_ADDR);
        s.setProof(hashVal, proof);

        XZ21.AuditingLog[] memory logs = s.getAuditingLogs(hashVal);
        if (logs[0].stage != XZ21.Stages.WaitingResult) {
            fail();
        }
    }

    function test_G5_WaitingResult2DoneAuditing (
        bytes32 hashVal
    ) public {
        bytes memory chal   = bytes("test chal");
        bytes memory proof  = bytes("test proof");

        vm.prank(SU_ADDR);
        s.setChal(hashVal, chal);

        vm.prank(SP_ADDR);
        s.setProof(hashVal, proof);

        vm.prank(TPA_ADDR);
        s.setAuditingResult(hashVal, true);

        XZ21.AuditingLog[] memory logs = s.getAuditingLogs(hashVal);
        if (logs[0].stage != XZ21.Stages.DoneAuditing) {
            fail();
        }
    }
}