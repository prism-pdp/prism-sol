// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.24;

import {Test} from "forge-std/Test.sol";
import {XZ21} from "../src/XZ21.sol";

contract G5_StateManagement_XZ21 is Test {
    XZ21 internal s;

    // 役割
    address constant SM_ADDR  = address(0x1000);
    address constant SP_ADDR  = address(0x2000);
    address constant TPA_ADDR = address(0x3000);
    address constant SU_ADDR  = address(0x4000);

    // 共通テストデータ
    bytes constant SU_KEY = hex"01";
    string constant P = "P"; // param.P は string だが内部では string
    bytes constant G = bytes("G");
    bytes constant U = bytes("U");
    bytes32 constant TEST_HASH = keccak256("file");
    bytes constant TEST_CHAL   = bytes("chal");
    bytes constant TEST_PROOF  = bytes("proof");

    uint256 time = 0;
    uint256 failCount = 0;

    enum LastCall { SetChal, SetProof, SetAuditingResult }
    LastCall public lastCall = LastCall.SetAuditingResult;

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
        try s.setChal(TEST_HASH, TEST_CHAL) {
            if (lastCall != LastCall.SetAuditingResult) {
                failCount++;
            }
            lastCall = LastCall.SetChal;
        } catch {
            if (lastCall == LastCall.SetAuditingResult) {
                failCount++;
            }
        }
    }

    function step_setProof() public {
        vm.prank(SP_ADDR);
        try s.setProof(TEST_HASH, TEST_PROOF) {
            if (lastCall != LastCall.SetChal) {
                failCount++;
            }
            lastCall = LastCall.SetProof;
        } catch {
            if (lastCall == LastCall.SetChal) {
                failCount++;
            }
        }
    }

    function step_setAuditingResult() public {
        time++;
        vm.warp(time);
        vm.prank(TPA_ADDR);
        try s.setAuditingResult(TEST_HASH, true) {
            if (lastCall != LastCall.SetProof) {
                failCount++;
            }
            lastCall = LastCall.SetAuditingResult;
        } catch {
            if (lastCall == LastCall.SetProof) {
                failCount++;
            }
        }
    }

    function invariant_G5() public {
        assertEq(failCount, 0);
    }
}