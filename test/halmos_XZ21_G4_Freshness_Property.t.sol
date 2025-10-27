// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.24;

import {XZ21, Base_XZ21_Setup} from "./Base_XZ21_Setup.t.sol";
import {console2} from "forge-std/console2.sol";

contract G4_Freshness_XZ21 is Base_XZ21_Setup {
    function test_G4_AuditingLogsOrder (
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
        try s.setAuditingResult(hashVal, true) {
        } catch {
            fail();
        }

        _setupAuditing(hashVal);
        vm.warp(time1); vm.prank(TPA_ADDR);
        try s.setAuditingResult(hashVal, true) {
        } catch {
            fail();
        }

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
        vm.prank(SU_ADDR);
        s.setChal(hashVal, CHAL);

        vm.prank(SP_ADDR);
        s.setProof(hashVal, PROOF);
    }

    function invariant_G4_freshness() public view {
        XZ21.AuditingLog[] memory logs = s.getAuditingLogs(HASH_VAL);
        uint256 len = logs.length;
        console2.log(len);
        uint256 prev_date = 0;
        for (uint256 i = 0; i < len; i++) {
            if (logs[i].stage == XZ21.Stages.DoneAuditing) {
                assertTrue(prev_date < logs[i].date);
                prev_date = logs[i].date;
            }
        }
    }
}