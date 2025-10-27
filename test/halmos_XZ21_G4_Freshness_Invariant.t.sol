// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.24;

//import {XZ21} from "../src/XZ21.sol";
//import {Test} from "forge-std/Test.sol";
//import {StdInvariant} from "forge-std/StdInvariant.sol";
//import {console2} from "forge-std/console2.sol";
//
//contract G4_Freshness2_XZ21 is StdInvariant, Test {
//   XZ21 internal s;
//
//    // 役割
//    address constant SM_ADDR  = address(0x1000);       // デプロイヤ = SM
//    address constant SP_ADDR  = address(0x2000);
//    address constant TPA_ADDR = address(0x3000);
//    address constant SU_ADDR  = address(0x4000);
//
//    // 共通テストデータ
//    bytes constant SU_KEY = hex"01";
//    string constant P = "P"; // param.P は string だが内部では string
//    bytes constant G = bytes("G");
//    bytes constant U = bytes("U");
//    bytes32 constant HASH_VAL = keccak256("test file");
//    bytes32 constant HASH_VAL_A = keccak256("test file A");
//    bytes32 constant HASH_VAL_B = keccak256("test file B");
//    bytes32 constant HASH_VAL_C = keccak256("test file C");
//    bytes constant CHAL   = bytes("test chal");
//    bytes constant PROOF  = bytes("test proof");
//
//    function setUp() public virtual {
//        // SM が SP を指定してデプロイ
//        vm.prank(SM_ADDR);
//        s = new XZ21(SP_ADDR);
//
//        // 初期パラメタ登録（SM のみ）
//        vm.prank(SM_ADDR);
//        s.registerParam("P", G, U);
//
//        // アカウント登録（SM のみ）
//        // accountType==0: TPA, ==1: SU
//        vm.prank(SM_ADDR);
//        s.enrollAccount(0, TPA_ADDR, ""); // TPA 追加
//        vm.prank(SM_ADDR);
//        s.enrollAccount(1, SU_ADDR, SU_KEY);
//
//        targetContract(address(this));
//        // 2. selectorリストを作る
//        bytes4;
//        sels[0] = G4_Freshness2_XZ21.act.selector;
//
//        // 3. それをfuzzerに渡す
//        targetSelector(
//            FuzzSelector({
//                addr: address(this),
//                selectors: sels
//            })
//        );
//    }
//
//    function act (
//        bytes32 seed,
//        uint256 loopNum
//    ) public {
//        loopNum = 1;
//
//        for (uint256 i = 0; i < loopNum; i++) {
//            bytes32 newSeed = keccak256(abi.encodePacked(seed));
//            //uint256 choice = uint256(newSeed) % 3;
//            //uint256 time = uint256(newSeed);
//            uint256 time = i + 1;
//            bytes32 chosenHashVal;
//
//            chosenHashVal = HASH_VAL_A;
//            //if (choice == 0) {
//            //    chosenHashVal = HASH_VAL_A;
//            //} else if (choice == 1) {
//            //    chosenHashVal = HASH_VAL_B;
//            //} else {
//            //    chosenHashVal = HASH_VAL_C;
//            //}
//
//            XZ21.AuditingLog[] memory logs = s.getAuditingLogs(chosenHashVal);
//            if (logs.length > 0) {
//                XZ21.AuditingLog memory tailLog = logs[logs.length - 1];
//                vm.warp(time);
//                if (tailLog.stage == XZ21.Stages.WaitingProof) {
//                    vm.prank(SP_ADDR);
//                    s.setProof(chosenHashVal, PROOF);
//                } else if (tailLog.stage == XZ21.Stages.WaitingResult) {
//                    vm.prank(TPA_ADDR);
//                    s.setAuditingResult(chosenHashVal, true);
//                } else if (tailLog.stage == XZ21.Stages.DoneAuditing) {
//                    vm.prank(SU_ADDR);
//                    s.setChal(chosenHashVal, CHAL);
//                } else {
//                    vm.prank(SU_ADDR);
//                    s.setChal(chosenHashVal, CHAL);
//                }
//            } else {
//                vm.prank(SU_ADDR);
//                s.setChal(chosenHashVal, CHAL);
//            }
//
//            seed = newSeed;
//        }
//        //vm.warp(time);
//
//        //uint256 choice = idxHashVal % 3;
//        //bytes32 chosenHashVal;
//        //if (choice == 0) {
//        //    chosenHashVal = HASH_VAL_A;
//        //} else if (choice == 1) {
//        //    chosenHashVal = HASH_VAL_B;
//        //} else {
//        //    chosenHashVal = HASH_VAL_C;
//        //}
//
//        //XZ21.AuditingLog[] memory logs = s.getAuditingLogs(chosenHashVal);
//        //XZ21.AuditingLog memory tailLog = logs[logs.length - 1];
//
//        //if (tailLog.stage == XZ21.Stages.WaitingProof) {
//        //    s.setProof(chosenHashVal, PROOF);
//        //} else if (tailLog.stage == XZ21.Stages.WaitingResult) {
//        //    s.setAuditingResult(chosenHashVal, true);
//        //} else if (tailLog.stage == XZ21.Stages.DoneAuditing) {
//        //} else {
//        //    s.setChal(chosenHashVal, CHAL);
//        //}
//    }
//
//    function invariant_G4_freshness2() public view {
//        XZ21.AuditingLog[] memory logs = s.getAuditingLogs(HASH_VAL_A);
//        uint256 len = logs.length;
//        console2.log(len);
//        uint256 prev_date = 0;
//        for (uint256 i = 0; i < len; i++) {
//            if (logs[i].stage == XZ21.Stages.DoneAuditing) {
//                assertTrue(prev_date < logs[i].date);
//                prev_date = logs[i].date;
//            }
//        }
//    }
//}