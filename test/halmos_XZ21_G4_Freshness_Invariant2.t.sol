// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.24;

import {XZ21} from "../src/XZ21.sol";
import {Test} from "forge-std/Test.sol";
import {StdInvariant} from "forge-std/StdInvariant.sol";
import {console2} from "forge-std/console2.sol";

contract G4_Freshness3_XZ21 is Test {
    XZ21 internal s;

    // 役割
    address constant SM_ADDR  = address(0x1000);       // デプロイヤ = SM
    address constant SP_ADDR  = address(0x2000);
    address constant TPA_ADDR = address(0x3000);
    address constant SU_ADDR  = address(0x4000);

    // 共通テストデータ
    bytes constant SU_KEY = hex"01";
    string constant P = "P"; // param.P は string だが内部では string
    bytes constant G = bytes("G");
    bytes constant U = bytes("U");
    bytes32 constant HASH_VAL = keccak256("test file");
    bytes32 constant HASH_VAL_A = keccak256("test file A");
    bytes32 constant HASH_VAL_B = keccak256("test file B");
    bytes32 constant HASH_VAL_C = keccak256("test file C");
    bytes constant CHAL   = bytes("test chal");
    bytes constant PROOF  = bytes("test proof");

    uint256 public maxLenSeen;

    function setUp() public virtual {
        // SM が SP を指定してデプロイ
        vm.prank(SM_ADDR);
        s = new XZ21(SP_ADDR);

        // 初期パラメタ登録（SM のみ）
        vm.prank(SM_ADDR);
        s.registerParam(P, G, U);

        // アカウント登録（SM のみ）
        // accountType==0: TPA, ==1: SU
        vm.prank(SM_ADDR);
        s.enrollAccount(0, TPA_ADDR, ""); // TPA 追加
        vm.prank(SM_ADDR);
        s.enrollAccount(1, SU_ADDR, SU_KEY);

        // 1. fuzzer がいじる「対象コントラクト」はこのハーネス自身
        targetContract(address(this));

        // 2. fuzzer が呼んでいい関数 selector 群を登録する
        bytes4[] memory sels = new bytes4[](3);
        sels[0] = this.step_setChal.selector;
        sels[1] = this.step_setProof.selector;
        sels[2] = this.step_setAuditingResult.selector;

        targetSelector(FuzzSelector({
            addr: address(this),
            selectors: sels
        }));
    }
    // --- fuzzでランダムに呼ばれる "操作ステップ" 群 ---
    function step_setChal() public {
        vm.prank(SU_ADDR);
        s.setChal(HASH_VAL_A, CHAL);
    }

    function step_setProof() public {
        vm.prank(SP_ADDR);
        s.setProof(HASH_VAL_A, PROOF);
    }

    function step_setAuditingResult(uint256 time) public {
        vm.warp(time);
        vm.prank(TPA_ADDR);
        s.setAuditingResult(HASH_VAL_A, true);
    }

    function invariant_G4_freshness2() public {
        XZ21.AuditingLog[] memory logs = s.getAuditingLogs(HASH_VAL_A);
        uint256 len = logs.length;
        uint256 prev_date = 0;
        for (uint256 i = 0; i < len; i++) {
            if (logs[i].stage == XZ21.Stages.DoneAuditing) {
                assertTrue(prev_date < logs[i].date);
                prev_date = logs[i].date;
            }
        }
    }
}