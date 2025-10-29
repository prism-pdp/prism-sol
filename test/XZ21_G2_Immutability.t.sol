// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.24;

import {Test} from "forge-std/Test.sol";
import {XZ21} from "../src/XZ21.sol"; // 置き場所に合わせて調整

contract G2_Immutability_XZ21_RegisterParam is Test {
    XZ21 internal s;

    address constant SM_ADDR  = address(0x1000);       // デプロイヤ = SM
    address constant SP_ADDR  = address(0x2000);

    string constant P = "P"; // param.P は string だが内部では string
    bytes constant G = bytes("G");
    bytes constant U = bytes("U");

    function setUp() public {
        // SM が SP を指定してデプロイ
        vm.prank(SM_ADDR);
        s = new XZ21(SP_ADDR);

        // 初期パラメタ登録（SM のみ）
        vm.prank(SM_ADDR);
        s.registerParam(P, G, U);
    }

    //function test_G2_registerParam_onlyOnce (
    //    string memory testP,
    //    bytes  memory testG,
    //    bytes  memory testU
    //) public {
    //    // Halmos/ fuzz 安定化のため入力を軽く制約（任意）
    //    vm.assume(bytes(testP).length <= 16);
    //    vm.assume(testG.length <= 32);
    //    vm.assume(testU.length <= 32);

    //    vm.prank(SM_ADDR);
    //    try s.registerParam(testP, testG, testU) {
    //        fail();
    //    } catch {
    //        // OK（常に revert を期待）
    //    }
    //}

    function invariant_G2_registerParam () public {
        XZ21.Param memory param = s.getParam();
        assertEq(keccak256(bytes(param.P)), keccak256(bytes(P)), "P changed");
        assertEq(keccak256(param.U), keccak256(U), "U changed");
        assertEq(keccak256(param.G), keccak256(G), "G changed");
    }
}