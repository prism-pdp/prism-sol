// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.13;

import "forge-std/Test.sol";
import "../src/XZ21.sol";

contract XZ21Test is Test {
    XZ21 public c;

    string constant P = "test parameter";
    bytes constant G = "0xAA";
    bytes constant U = "0xBB";
    bytes32 constant HASH_FILE1 = keccak256("File1");
    bytes32 constant HASH_FILE2 = keccak256("File2");
    bytes constant KEY_USER1 = "0x1111";
    bytes constant KEY_USER2 = "0x1212";
    bytes constant KEY_USER3 = "0x1313";

    address ADDR_SM;
    address ADDR_SP;
    address ADDR_TPA;
    address ADDR_USER0;
    address ADDR_USER1;
    address ADDR_USER2;
    address ADDR_USER3;

    function setUp() public {
        // Prepare variables
        ADDR_SM    = vm.addr(1000);
        ADDR_SP    = vm.addr(1001);
        ADDR_TPA   = vm.addr(1002);
        ADDR_USER0 = vm.addr(2000); // dummy user
        ADDR_USER1 = vm.addr(2001);
        ADDR_USER2 = vm.addr(2002);
        ADDR_USER3 = vm.addr(2003);

        vm.prank(ADDR_SM);
        c = new XZ21(ADDR_SP, ADDR_TPA);
        vm.prank(ADDR_SM);
        c.RegisterParam(P, G, U);
        vm.prank(ADDR_SM);
        c.EnrollAccount(ADDR_USER1, KEY_USER1);
        vm.prank(ADDR_SM);
        c.EnrollAccount(ADDR_USER2, KEY_USER2);
        vm.prank(ADDR_SM);
        c.EnrollAccount(ADDR_USER3, KEY_USER3);
    }

    function testSetupPhase() public view {
        address addrSM = c.addrSM();
        assertEq(addrSM, ADDR_SM);

        address addrTPA = c.addrTPA();
        assertEq(addrTPA, ADDR_TPA);

        address addrSP = c.addrSP();
        assertEq(addrSP, ADDR_SP);

        XZ21.Param memory param = c.GetParam();
        assertEq(param.P, P);
        assertEq(param.G, G);
        assertEq(param.U, U);

        XZ21.Account memory su1 = c.GetAccount(ADDR_USER1);
        assertEq(su1.pubKey, KEY_USER1);

        XZ21.Account memory su2 = c.GetAccount(ADDR_USER2);
        assertEq(su2.pubKey, KEY_USER2);

        XZ21.Account memory su3 = c.GetAccount(ADDR_USER3);
        assertEq(su3.pubKey, KEY_USER3);

        XZ21.Account memory su0 = c.GetAccount(ADDR_USER0);
        assertEq(su0.pubKey, "");
    }

    function testUploadPhase() public {
        vm.prank(ADDR_USER1);
        XZ21.FileProperty memory fileProp = c.SearchFile(HASH_FILE1);
        assertEq(address(0), fileProp.creator);
        assertEq(0, fileProp.splitNum);

        vm.prank(ADDR_SP);
        c.RegisterFile(HASH_FILE1, 9, ADDR_USER1);
        c.RegisterFile(HASH_FILE2, 20, ADDR_USER1);
        c.AppendOwner(HASH_FILE2, ADDR_USER2);

        vm.prank(ADDR_SP);
        fileProp = c.SearchFile(HASH_FILE1);
        assertEq(ADDR_USER1, fileProp.creator);
        assertEq(9, fileProp.splitNum);

        vm.prank(ADDR_USER1);
        bytes32[] memory fileList1 = c.GetFileList(ADDR_USER1);
        assertEq(fileList1[0], HASH_FILE1);
        assertEq(fileList1[1], HASH_FILE2);

        vm.prank(ADDR_USER2);
        bytes32[] memory fileList2 = c.GetFileList(ADDR_USER2);
        assertEq(fileList2[0], HASH_FILE2);
    }

    function testAuditing() public {
        bytes memory chal1 = "chal1";
        bytes memory chal2 = "chal2";
        bytes memory proof1 = "proof1";
        bytes memory proof2 = "proof2";

        // USER1 reqests audiging of FILE1 and FILE2.
        vm.prank(ADDR_USER1);
        bool setChal1 = c.SetChal(HASH_FILE1, chal1);
        assertEq(setChal1, true);
        vm.prank(ADDR_USER1);
        bool setChal2 = c.SetChal(HASH_FILE2, chal2);
        assertEq(setChal2, true);

        // SP downloads the list of chal.
        vm.prank(ADDR_SP);
        (bytes32[] memory fileList, bytes[] memory chalList) = c.GetChalList();
        assertEq(fileList[0], HASH_FILE1);
        assertEq(chalList[0], chal1);
        assertEq(fileList[1], HASH_FILE2);
        assertEq(chalList[1], chal2);

        // SP uploads the proof for each chal.
        vm.prank(ADDR_SP);
        c.SetProof(fileList[0], proof1);
        vm.prank(ADDR_SP);
        c.SetProof(fileList[1], proof2);

        // TPA downloads the list of auditing reqs (chal and proof).
        vm.prank(ADDR_TPA);
        (bytes32[] memory fileList2, XZ21.AuditingReq[] memory reqList) = c.GetAuditingReqList();
        assertEq(fileList2[0], HASH_FILE1);
        assertEq(reqList[0].chal, chal1);
        assertEq(reqList[0].proof, proof1);
        assertEq(fileList2[1], HASH_FILE2);
        assertEq(reqList[1].chal, chal2);
        assertEq(reqList[1].proof, proof2);

        // TPA uploads the auditing result.
        vm.prank(ADDR_TPA);
        c.SetAuditingResult(fileList2[0], false);
        vm.prank(ADDR_TPA);
        c.SetAuditingResult(fileList2[1], true);

        // USER1 checks the auditing result.
        vm.prank(ADDR_USER1);
        XZ21.AuditingLog[] memory logs = c.GetAuditingLogs(HASH_FILE1);
        assertEq(logs.length, 1);
        assertEq(logs[0].chal, chal1);
        assertEq(logs[0].proof, proof1);
        assertEq(logs[0].result, false);

        // =============================
        // check status after auditing
        // =============================

        // blank chal list
        vm.prank(ADDR_SP);
        (bytes32[] memory fileList1_After, bytes[] memory chalList1_After) = c.GetChalList();
        assertEq(fileList1_After.length, 0);
        assertEq(chalList1_After.length, 0);

        vm.prank(ADDR_TPA);
        (bytes32[] memory fileList2_After, XZ21.AuditingReq[] memory reqList2_After) = c.GetAuditingReqList();
        assertEq(fileList2_After.length, 0);
        assertEq(reqList2_After.length, 0);
    }

    // function testPara() public view {
    //     XZ21.Para memory para = c.GetPara();
    //     assertEq(para.PARAM, PARAM);
    //     assertEq(para.G, G);
    //     assertEq(para.U, U);
    // }

    // function testFile() public view {
    //     bool ret;

    //     ret = c.SearchFile(HASH_FILE0);
    //     assertFalse(ret);

    //     ret = c.SearchFile(HASH_FILE1);
    //     assertTrue(ret);

    //     ret = c.SearchFile(HASH_FILE2);
    //     assertTrue(ret);
    // }
}
