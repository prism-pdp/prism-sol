// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.13;

import {Test} from "forge-std/Test.sol";
import {XZ21} from "../src/XZ21.sol";

contract XZ21Test is Test {
    XZ21 public c;

    string constant P = "test parameter";
    bytes constant G = "0xAA";
    bytes constant U = "0xBB";
    bytes32 constant HASH_FILE1 = keccak256("File1");
    bytes32 constant HASH_FILE2 = keccak256("File2");
    bytes constant USER1_KEY = "0x1111";
    bytes constant USER2_KEY = "0x1212";
    bytes constant USER3_KEY = "0x1313";

    address constant SM_ADDR = address(0x1000);
    address constant SP_ADDR = address(0x2000);
    address constant TPA_ADDR = address(0x3000);
    address constant USER0_ADDR = address(0x4000);
    address constant USER1_ADDR = address(0x4001);
    address constant USER2_ADDR = address(0x4002);
    address constant USER3_ADDR = address(0x4003);

    function setUp() public {
        // Prepare variables
        // SM_ADDR    = vm.addr(1000);
        // SP_ADDR    = vm.addr(1001);
        // TPA_ADDR   = vm.addr(1002);
        // USER0_ADDR = vm.addr(2000); // dummy user
        // USER1_ADDR = vm.addr(2001);
        // USER2_ADDR = vm.addr(2002);
        // ADDR_USER3 = vm.addr(2003);

        vm.prank(SM_ADDR);
        c = new XZ21(SP_ADDR);
        vm.prank(SM_ADDR);
        c.registerParam(P, G, U);
        vm.prank(SM_ADDR);
        vm.expectRevert(bytes("Do not overwrite registerParam"));
        c.registerParam(P, G, U);
        vm.prank(SM_ADDR);
        vm.expectRevert(bytes("Invalid account type"));
        c.enrollAccount(9, TPA_ADDR, "");
        vm.prank(SM_ADDR);
        c.enrollAccount(0, TPA_ADDR, "");
        vm.prank(SM_ADDR);
        vm.expectRevert(bytes("Duplicate TPA address"));
        c.enrollAccount(0, TPA_ADDR, "");
        vm.prank(SM_ADDR);
        c.enrollAccount(1, USER1_ADDR, USER1_KEY);
        vm.prank(SM_ADDR);
        c.enrollAccount(1, USER2_ADDR, USER2_KEY);
        vm.prank(SM_ADDR);
        c.enrollAccount(1, USER3_ADDR, USER3_KEY);
        vm.prank(SM_ADDR);
        vm.expectRevert(bytes("Duplicate SU account"));
        c.enrollAccount(1, USER3_ADDR, USER3_KEY);
    }

    function testSetupPhase() public view {
        assertEq(c.SM_ADDR(), SM_ADDR);

        address[] memory tpaAddrList = c.getAuditorAddrList();
        assertEq(tpaAddrList.length, 1);
        assertEq(tpaAddrList[0], TPA_ADDR);

        assertEq(c.SP_ADDR(), SP_ADDR);

        XZ21.Param memory param = c.getParam();
        assertEq(param.P, P);
        assertEq(param.G, G);
        assertEq(param.U, U);

        XZ21.Account memory su1 = c.getUserAccount(USER1_ADDR);
        assertEq(su1.pubKey, USER1_KEY);

        XZ21.Account memory su2 = c.getUserAccount(USER2_ADDR);
        assertEq(su2.pubKey, USER2_KEY);

        XZ21.Account memory su3 = c.getUserAccount(USER3_ADDR);
        assertEq(su3.pubKey, USER3_KEY);

        XZ21.Account memory su0 = c.getUserAccount(USER0_ADDR);
        assertEq(su0.pubKey, "");
    }

    function testUploadPhase() public {
        vm.prank(USER1_ADDR);
        XZ21.FileProperty memory fileProp = c.searchFile(HASH_FILE1);
        assertEq(address(0), fileProp.creator);
        assertEq(0, fileProp.splitNum);

        vm.expectRevert(bytes("Authentication error (Only by SP)"));
        vm.prank(USER1_ADDR); c.registerFile(HASH_FILE1, 9, USER1_ADDR);

        vm.expectRevert(bytes("Authentication error (Only by SP)"));
        vm.prank(USER1_ADDR); c.appendOwner(HASH_FILE2, USER2_ADDR);

        vm.prank(SP_ADDR); c.registerFile(HASH_FILE1, 9, USER1_ADDR);
        vm.prank(SP_ADDR); c.registerFile(HASH_FILE2, 20, USER1_ADDR);
        vm.prank(SP_ADDR); c.appendOwner(HASH_FILE2, USER2_ADDR);

        vm.prank(SP_ADDR);
        fileProp = c.searchFile(HASH_FILE1);
        assertEq(USER1_ADDR, fileProp.creator);
        assertEq(9, fileProp.splitNum);

        vm.prank(USER1_ADDR);
        bytes32[] memory fileList1 = c.getFileList(USER1_ADDR);
        assertEq(fileList1[0], HASH_FILE1);
        assertEq(fileList1[1], HASH_FILE2);

        vm.prank(USER2_ADDR);
        bytes32[] memory fileList2 = c.getFileList(USER2_ADDR);
        assertEq(fileList2[0], HASH_FILE2);
    }

    function testAuditing() public {
        bytes memory chal1 = "chal1";
        bytes memory chal2 = "chal2";
        bytes memory proof1 = "proof1";
        bytes memory proof2 = "proof2";
        uint256 date0 = 1727740800;        // 2024-10-01 00:00:00
        uint256 date1 = date0 + 1 minutes; // 2024-10-01 00:01:00

        vm.prank(SP_ADDR);
        vm.expectRevert(bytes("Authentication error (Only by SU)"));
        c.setChal(HASH_FILE1, chal1);

        // USER1 reqests audiging of FILE1 and FILE2.
        reqAuditing(USER1_ADDR, HASH_FILE1, chal1);
        reqAuditing(USER1_ADDR, HASH_FILE2, chal2);

        // !!! Error case !!!
        // USER1 makes an auditing request for FILE1 that has already been requested for auditing.
        vm.expectRevert(bytes("Not WaitingChal"));
        reqAuditing(USER1_ADDR, HASH_FILE1, chal1);

        // !!! Error case !!!
        vm.prank(USER1_ADDR);
        vm.expectRevert("Authentication error (Only by SP)");
        c.setProof(HASH_FILE1, proof1);

        // SP makes proofs.
        makeProof(HASH_FILE1, proof1);
        makeProof(HASH_FILE2, proof2);

        // !!! Error case !!!
        // SP creates again a proof for a request that has already been processed.
        vm.expectRevert(bytes("Not WaitingProof"));
        makeProof(HASH_FILE1, proof1);

        // !!! Error case !!!
        vm.prank(SP_ADDR);
        vm.expectRevert(bytes("Authentication error (Only by TPA)"));
        c.setAuditingResult(HASH_FILE1, true);

        // TPA verifies proofs.
        vm.expectEmit(false, false, false, true); emit XZ21.EventSetAuditingResult(HASH_FILE1, true); // Event log
        verifyProof(HASH_FILE1, true, date1);
        vm.expectEmit(false, false, false, true); emit XZ21.EventSetAuditingResult(HASH_FILE2, true); // Event log
        verifyProof(HASH_FILE2, true, date1);

        // !!! Error case !!!
        // TPA creates again a result for a request that has already been processed
        vm.expectRevert(bytes("Not WaitingResult"));
        verifyProof(HASH_FILE1, true, date1);

        // USER1 checks the auditing result.
        checkLog(USER1_ADDR, HASH_FILE1, 0, chal1, proof1, true, date1);
        checkLog(USER1_ADDR, HASH_FILE2, 0, chal2, proof2, true, date1);

        // !!! Error case !!!
        // Request auditing for FILE1 again, and register the log with a timestamp earlier than the previous result.
        reqAuditing(USER1_ADDR, HASH_FILE1, chal1);
        makeProof(HASH_FILE1, proof1);
        vm.prank(TPA_ADDR);
        vm.warp(date0);
        vm.expectRevert(bytes("timestamp error"));
        c.setAuditingResult(HASH_FILE1, false);
    }

    function reqAuditing(address _user, bytes32 _hash, bytes memory _chal) private {
        // A user reqests audiging of a file.
        vm.prank(_user);
        c.setChal(_hash, _chal);
    }

    function makeProof(bytes32 _hash, bytes memory _proof) private {
        vm.prank(SP_ADDR);
        c.setProof(_hash, _proof);
    }

    function verifyProof(bytes32 _hash, bool _result, uint256 _date) private {
        vm.prank(TPA_ADDR);
        vm.warp(_date);
        c.setAuditingResult(_hash, _result);
    }

    function checkLog(address _user, bytes32 _hash, uint _index, bytes memory _chal, bytes memory _proof, bool _result, uint256 _date) private {
        vm.prank(_user);
        XZ21.AuditingLog[] memory logs = c.getAuditingLogs(_hash);
        assertEq(logs[_index].chal, _chal);
        assertEq(logs[_index].proof, _proof);
        assertEq(logs[_index].result, _result);
        assertEq(uint(logs[_index].stage), uint(XZ21.Stages.DoneAuditing));
        assertEq(logs[_index].date, _date);
    }
}
