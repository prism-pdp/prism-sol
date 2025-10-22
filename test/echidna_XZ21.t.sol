// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.24;

import {XZ21} from "../src/XZ21.sol";

contract Attacker {
    function tryRegisterParam(XZ21 s) external returns (bool) {
        try s.registerParam("Q", bytes("G"), bytes("U")) { return true; } catch { return false; }
    }
    function tryEnrollAccount(XZ21 s) external returns (bool) {
        try s.enrollAccount(1, address(this), hex"01") { return true; } catch { return false; }
    }
    function tryRegisterFile(XZ21 s, bytes32 h) external returns (bool) {
        try s.registerFile(h, 10, msg.sender) { return true; } catch { return false; }
    }
    function tryAppendOwner(XZ21 s, bytes32 h, address who) external returns (bool) {
        try s.appendOwner(h, who) { return true; } catch { return false; }
    }
    function trySetChal(XZ21 s, bytes32 h) external returns (bool) {
        try s.setChal(h, bytes("C")) { return true; } catch { return false; }
    }
    function trySetProof(XZ21 s, bytes32 h) external returns (bool) {
        try s.setProof(h, bytes("P")) { return true; } catch { return false; }
    }
    function trySetAuditingResult(XZ21 s, bytes32 h) external returns (bool) {
        try s.setAuditingResult(h, true) { return true; } catch { return false; }
    }
}

contract XZ21EchidnaWrapper {
    XZ21 public immutable s;
    Attacker private attacker;

    bytes32 constant H0 = keccak256("file-0");
    bytes32 constant H1 = keccak256("file-1");
    bytes32 constant H2 = keccak256("file-2");

    //uint256 constant MAX_TIMESTAMP = type(uint64).max;

    // G3 用：一度登録したかのフラグ
    bool private _flagG3_H1_registered;

    constructor() {
        s = new XZ21(address(this));
        s.registerParam("P", bytes("G"), bytes("U"));
        bool ok1 = s.enrollAccount(0, address(this), ""); // TPA 追加
        require(ok1, "TPA enroll failed");
        bool ok2 = s.enrollAccount(1, address(this), hex"01");
        require(ok2, "SU enroll failed");

        s.registerFile(H0, 10, address(this));

        _flagG3_H1_registered = false;

        attacker = new Attacker();
    }

    // ================================================
    // G1: Authentication & Authorization
    // ================================================

    // [G1-1] RegisterParam は SM 以外は実行できない
    function echidna_G1_onlySM_can_registerParam() public returns (bool) {
        // Attacker（権限なし）からの呼び出しは失敗するはず
        bool ok = attacker.tryRegisterParam(s);
        return ok == false;
    }

    // [G1-2] EnrollAccount は SM 以外は実行できない
    function echidna_G1_onlySM_can_enrollAccount() public returns (bool) {
        bool ok = attacker.tryEnrollAccount(s);
        return ok == false;
    }

    // [G1-3] RegisterFile は SP 以外は実行できない
    function echidna_G1_onlySP_can_registerFile() public returns (bool) {
        bool ok = attacker.tryRegisterFile(s, keccak256("attacker-file"));
        return ok == false;
    }

    // [G1-4] AppendOwner は SP 以外は実行できない
    function echidna_G1_onlySP_can_appendOwner() public returns (bool) {
        bool ok = attacker.tryAppendOwner(s, H0, address(this));
        return ok == false;
    }

    // [G1-5] SetChal は SU 以外は実行できない
    function echidna_G1_onlySU_can_setChal() public returns (bool) {
        bool ok = attacker.trySetChal(s, H0);
        return ok == false;
    }

    // [G1-6] SetProof は SP 以外は実行できない
    function echidna_G1_onlySP_can_setProof() public returns (bool) {
        bool ok = attacker.trySetProof(s, H0);
        return ok == false;
    }

    // [G1-7] SetAuditingResult は TPA 以外は実行できない
    function echidna_G1_onlyTPA_can_setAuditingResult() public returns (bool) {
        bool ok = attacker.trySetAuditingResult(s, H0);
        return ok == false;
    }

    // ===========================================
    // G2: Data Immutability（上書き禁止）
    // ===========================================
    function echidna_G2_no_param_overwrite() public returns (bool) {
        // 2回目以降の RegisterParam は失敗するべき
        try s.registerParam("P2", hex"02", hex"03") {
            return false; // 成功してしまったら NG
        } catch {
            return true;  // 失敗（=上書き拒否）なら OK
        }
    }

    // ===========================================
    // G3: Data Uniqueness（重複登録禁止）
    // ===========================================
    function echidna_G3_registerFile_no_duplication() public returns (bool) {
        if (!_flagG3_H1_registered) {
            // 初回は成功するはず
            try s.registerFile(H1, 10, address(this)) {
                _flagG3_H1_registered = true;
                return true;
            } catch {
                // 初回で失敗するのは想定外
                return false;
            }
        } else {
            // 2回目は同じハッシュで失敗するべき
            try s.registerFile(H1, 10, address(this)) {
                return false; // 成功してしまったら NG
            } catch {
                return true;
            }
        }
    }

    // ==================================================================
    // G4: Data Freshness（監査ログの順序性）
    // ここでは「同じ監査エントリに二重で結果を書けない」＝
    // SetAuditingResult を連続で呼べないことを確認（時系列破壊の防止）
    // ==================================================================
    function echidna_G4_auditing_logs_order() public returns (bool) {
        // 1回の監査フロー
        try s.setChal(H0, bytes("C1")) {} catch { return true; } // 既に進行中ならこのプロパティはOK（状態管理が効いている）
        try s.setProof(H0, bytes("P1")) {} catch { return false; }
        try s.setAuditingResult(H0, false) {} catch { return false; }

        // 直後に "同じエントリ" に結果をもう一度書けてしまうとNG
        // （内部では stage==Done を要求するので失敗するはず）
        try s.setAuditingResult(H0, true) {
            return false; // 二重書き込みできたらNG
        } catch {
            return true;  // 失敗＝OK
        }
    }

    // =====================================================================
    // G5: State Management（監査状態遷移の健全性）
    // - 進行中（WaitingProof / WaitingResult）に重複リクエストができない
    // =====================================================================
    function echidna_G5_no_duplicate_auditing_request() public returns (bool) {
        // SetChal で着手
        try s.setChal(H0, bytes("CC")) {} catch { 
            // 既に監査進行中ならそれ自体がOK（重複拒否が働いている）
            return true;
        }

        // 進行中に再度 SetChal は失敗するはず
        bool secondChalOk;
        try s.setChal(H0, bytes("CC2")) { secondChalOk = true; } catch { secondChalOk = false; }
        if (secondChalOk) return false; // 重複許容はNG

        // SetProof → SetAuditingResult で完了
        try s.setProof(H0, bytes("PP")) {} catch { return false; }
        try s.setAuditingResult(H0, true) {} catch { return false; }

        return true;
    }
}
