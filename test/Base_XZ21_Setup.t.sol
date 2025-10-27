// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.24;

import {Test} from "forge-std/Test.sol";
import {XZ21} from "../src/XZ21.sol"; // 置き場所に合わせて調整

abstract contract Base_XZ21_Setup is Test {
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

    function setUp() public virtual {
        // SM が SP を指定してデプロイ
        vm.prank(SM_ADDR);
        s = new XZ21(SP_ADDR);

        // 初期パラメタ登録（SM のみ）
        vm.prank(SM_ADDR);
        s.registerParam("P", G, U);

        // アカウント登録（SM のみ）
        // accountType==0: TPA, ==1: SU
        vm.prank(SM_ADDR);
        s.enrollAccount(0, TPA_ADDR, ""); // TPA 追加
        vm.prank(SM_ADDR);
        s.enrollAccount(1, SU_ADDR, SU_KEY);

        // HASH VAL
        vm.prank(SU_ADDR);
        s.setChal(HASH_VAL, CHAL);

        vm.prank(SP_ADDR);
        s.setProof(HASH_VAL, PROOF);

        vm.prank(TPA_ADDR);
        s.setAuditingResult(HASH_VAL, true);

        // HASH VAL A
        vm.prank(SU_ADDR);
        s.setChal(HASH_VAL_A, CHAL);

        vm.prank(SP_ADDR);
        s.setProof(HASH_VAL_A, PROOF);

        vm.prank(TPA_ADDR);
        s.setAuditingResult(HASH_VAL_A, true);

        // HASH VAL B
        vm.prank(SU_ADDR);
        s.setChal(HASH_VAL_B, CHAL);

        vm.prank(SP_ADDR);
        s.setProof(HASH_VAL_B, PROOF);

        vm.prank(TPA_ADDR);
        s.setAuditingResult(HASH_VAL_B, true);

        // HASH VAL C
        vm.prank(SU_ADDR);
        s.setChal(HASH_VAL_C, CHAL);

        vm.prank(SP_ADDR);
        s.setProof(HASH_VAL_C, PROOF);

        vm.prank(TPA_ADDR);
        s.setAuditingResult(HASH_VAL_C, true);
    }
}