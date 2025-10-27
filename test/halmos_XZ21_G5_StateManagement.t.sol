// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.24;

import "./Base_XZ21_Setup.t.sol";

contract G5_StateManagement_XZ21 is Base_XZ21_Setup {
    function test_G5_Start2WaitingProof (
        bytes32 hashVal
    ) public {
        vm.assume(hashVal != HASH_VAL);

        vm.prank(SU_ADDR);
        s.setChal(hashVal, CHAL);

        XZ21.AuditingLog[] memory logs = s.getAuditingLogs(hashVal);
        if (logs[0].stage != XZ21.Stages.WaitingProof) {
            fail();
        }
    }

    function test_G5_WaitingProof2WaitingResult (
        bytes32 hashVal
    ) public {
        vm.assume(hashVal != HASH_VAL);

        vm.prank(SU_ADDR);
        s.setChal(hashVal, CHAL);

        vm.prank(SP_ADDR);
        s.setProof(hashVal, PROOF);

        XZ21.AuditingLog[] memory logs = s.getAuditingLogs(hashVal);
        if (logs[0].stage != XZ21.Stages.WaitingResult) {
            fail();
        }
    }

    function test_G5_WaitingResult2DoneAuditing (
        bytes32 hashVal
    ) public {
        vm.assume(hashVal != HASH_VAL);

        vm.prank(SU_ADDR);
        s.setChal(hashVal, CHAL);

        vm.prank(SP_ADDR);
        s.setProof(hashVal, PROOF);

        vm.prank(TPA_ADDR);
        s.setAuditingResult(hashVal, true);

        XZ21.AuditingLog[] memory logs = s.getAuditingLogs(hashVal);
        if (logs[0].stage != XZ21.Stages.DoneAuditing) {
            fail();
        }
    }
}