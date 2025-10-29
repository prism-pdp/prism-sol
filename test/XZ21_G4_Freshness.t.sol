// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.24;

import {XZ21} from "../src/XZ21.sol";
import {Test} from "forge-std/Test.sol";
import {console2} from "forge-std/console2.sol";

contract G4_Freshness4_XZ21 is Test {
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
    bytes32 constant TEST_HASH = keccak256("test file");
    bytes constant TEST_CHAL   = bytes("chal");
    bytes constant TEST_PROOF  = bytes("proof");

    uint256 constant LAST_TIME = type(uint256).max / 2;

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

        vm.prank(SU_ADDR);
        s.setChal(TEST_HASH, TEST_CHAL);
        vm.prank(SP_ADDR);
        s.setProof(TEST_HASH, TEST_PROOF);
        vm.prank(TPA_ADDR);
        vm.warp(LAST_TIME);
        s.setAuditingResult(TEST_HASH, true);
    }

    function test(
        uint256 time
    ) public {
        vm.assume(time > 0);

        vm.prank(SU_ADDR);
        s.setChal(TEST_HASH, TEST_CHAL);
        vm.prank(SP_ADDR);
        s.setProof(TEST_HASH, TEST_PROOF);

        vm.warp(time);
        vm.prank(TPA_ADDR);
        try s.setAuditingResult(TEST_HASH, true) {
            if (time <= LAST_TIME) {
                fail();
            }
        } catch {
            if (LAST_TIME < time) {
                fail();
            }
        }
    }
}