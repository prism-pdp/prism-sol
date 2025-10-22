// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.24;

import {XZ21} from "../src/XZ21.sol";

contract XZ21EchidnaWrapper {
    XZ21 public s;

    address constant SM_ADDR  = address(0x1000);       // デプロイヤ = SM
    address constant SP_ADDR  = address(0x2000);
    address constant TPA_ADDR = address(0x3000);
    address constant SU_ADDR  = address(0x4000);

    bytes constant SU_KEY = hex"01";
    string constant P = "P"; // param.P は string だが内部では string
    bytes constant G = bytes("G");
    bytes constant U = bytes("U");

    uint256 constant MAX_TIMESTAMP = type(uint64).max;

    constructor() {
        s = new XZ21(address(0x2000));
        s.registerParam("P", G, U);
        s.enrollAccount(0, TPA_ADDR, ""); // TPA 追加
        s.enrollAccount(1, SU_ADDR, SU_KEY);
    }
}