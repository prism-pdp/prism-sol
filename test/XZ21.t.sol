// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.13;

import {Test, console} from "forge-std/Test.sol";
import {XZ21} from "../src/XZ21.sol";

contract XZ21Test is Test {
    XZ21 public regContract;

    string constant PAIRING = "test-value(pairing)";
    bytes constant G = "0xAA";
    bytes constant U = "0xBB";
    address constant TPA_ADDR = 0x0000000000000000000000000000000000000000;
    address constant USER1_ADDR = 0x1111111111111111111111111111111111111111;
    address constant USER2_ADDR = 0x2222222222222222222222222222222222222222;
    address constant SP_ADDR = 0x9999999999999999999999999999999999999999;

    function setUp() public {
        regContract = new XZ21(PAIRING, G, U, SP_ADDR, TPA_ADDR);
    }

    function testRead() public view {
        XZ21.Para memory para = regContract.getPara();
        assertEq(para.pairing, PAIRING);
        assertEq(para.g, G);
        assertEq(para.u, U);

        assertEq(regContract.sp(), SP_ADDR);
        assertEq(regContract.tpa(), TPA_ADDR);
    }

    function testUpdateFileIndex() public {
        regContract.updateFileIndex("1", USER1_ADDR);
        regContract.updateFileIndex("1", USER2_ADDR);

        XZ21.FileIndex memory fileIndex = regContract.readFileIndex("1");
        assertEq(fileIndex.owners[0], USER1_ADDR);
        assertEq(fileIndex.owners[1], USER2_ADDR);
    }
}
