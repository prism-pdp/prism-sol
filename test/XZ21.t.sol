// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.13;

import {Test, console} from "forge-std/Test.sol";
import {XZ21} from "../src/XZ21.sol";

contract XZ21Test is Test {
    XZ21 public xz21Contract;

    string constant PAIRING = "test-value(pairing)";
    bytes constant G = "0xAA";
    bytes constant U = "0xBB";
    address constant ADDR_SM    = 0x7FA9385bE102ac3EAc297483Dd6233D62b3e1496;
    address constant ADDR_TPA   = 0x9999999999999999999999999999999999999999;
    address constant ADDR_SP    = 0x8888888888888888888888888888888888888888;
    address constant USER1_ADDR = 0x1111111111111111111111111111111111111111;
    address constant USER2_ADDR = 0x2222222222222222222222222222222222222222;

    function setUp() public {
        //testContract = new XZ21(PAIRING, G, U, ADDR_SP, ADDR_TPA);
        xz21Contract = new XZ21(ADDR_TPA, ADDR_SP);
    }

    function testAccount() public view {
        address addrSM = xz21Contract.GetAddrSM();
        assertEq(addrSM, ADDR_SM);

        address addrTPA = xz21Contract.GetAddrTPA();
        assertEq(addrTPA, ADDR_TPA);

        address addrSP = xz21Contract.GetAddrSP();
        assertEq(addrSP, ADDR_SP);
    }

    function testPara() public {
        xz21Contract.RegisterPara(PAIRING, G, U);
        XZ21.Para memory para = xz21Contract.GetPara();
        assertEq(para.Pairing, PAIRING);
        assertEq(para.G, G);
        assertEq(para.U, U);
    }

    // function testUpdateFileIndex() public {
    //     regContract.updateFileIndex("1", USER1_ADDR);
    //     regContract.updateFileIndex("1", USER2_ADDR);

    //     XZ21.FileIndex memory fileIndex = regContract.readFileIndex("1");
    //     assertEq(fileIndex.owners[0], USER1_ADDR);
    //     assertEq(fileIndex.owners[1], USER2_ADDR);
    // }
}
