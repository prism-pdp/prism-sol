// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.24;

import {XZ21} from "../src/XZ21.sol";

contract XZ21Echidna {
    XZ21 public s;

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

    constructor() {
        s = new XZ21(SP_ADDR);

        s.registerParam("P", G, U);

        s.enrollAccount(0, TPA_ADDR, "");
        s.enrollAccount(1, SU_ADDR, SU_KEY);
    }

    /// SM 以外が RegisterParam を呼べないこと
    function echidna_G1_only_sm_can_register_param() external returns (bool) {
        // すでに1回済なので、誰が呼んでも失敗するはず（=成功が起きない）
        // Echidna は revert をOK扱いにするので、“成功してしまったら false”にする
        (bool ok, ) = address(s).call(
            abi.encodeWithSignature("RegisterParam(string,bytes,bytes)", "X", hex"01", hex"02")
        );
        return ok == false;
    }
}
