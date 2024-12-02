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
        c = new XZ21(ADDR_SP);
        vm.prank(ADDR_SM);
        c.RegisterParam(P, G, U);
        vm.prank(ADDR_SM);
        vm.expectRevert(bytes("Do not overwrite RegisterParam"));
        c.RegisterParam(P, G, U);
        vm.prank(ADDR_SM);
        vm.expectRevert(bytes("Invalid type"));
        c.EnrollAccount(9, ADDR_TPA, "");
        vm.prank(ADDR_SM);
        c.EnrollAccount(0, ADDR_TPA, "");
        vm.prank(ADDR_SM);
        vm.expectRevert(bytes("Duplicate TPA address"));
        c.EnrollAccount(0, ADDR_TPA, "");
        vm.prank(ADDR_SM);
        c.EnrollAccount(1, ADDR_USER1, KEY_USER1);
        vm.prank(ADDR_SM);
        c.EnrollAccount(1, ADDR_USER2, KEY_USER2);
        vm.prank(ADDR_SM);
        c.EnrollAccount(1, ADDR_USER3, KEY_USER3);
        vm.prank(ADDR_SM);
        vm.expectRevert(bytes("Duplicate SU account"));
        c.EnrollAccount(1, ADDR_USER3, KEY_USER3);
    }

    function testSetupPhase() public view {
        address addrSM = c.addrSM();
        assertEq(addrSM, ADDR_SM);

        address[] memory addrListTPA = c.GetAuditorAddrList();
        assertEq(addrListTPA.length, 1);
        assertEq(addrListTPA[0], ADDR_TPA);

        address addrSP = c.addrSP();
        assertEq(addrSP, ADDR_SP);

        XZ21.Param memory param = c.GetParam();
        assertEq(param.P, P);
        assertEq(param.G, G);
        assertEq(param.U, U);

        XZ21.Account memory su1 = c.GetUserAccount(ADDR_USER1);
        assertEq(su1.pubKey, KEY_USER1);

        XZ21.Account memory su2 = c.GetUserAccount(ADDR_USER2);
        assertEq(su2.pubKey, KEY_USER2);

        XZ21.Account memory su3 = c.GetUserAccount(ADDR_USER3);
        assertEq(su3.pubKey, KEY_USER3);

        XZ21.Account memory su0 = c.GetUserAccount(ADDR_USER0);
        assertEq(su0.pubKey, "");
    }

    function testUploadPhase() public {
        vm.prank(ADDR_USER1);
        XZ21.FileProperty memory fileProp = c.SearchFile(HASH_FILE1);
        assertEq(address(0), fileProp.creator);
        assertEq(0, fileProp.splitNum);

        vm.expectRevert(bytes("Authentication error"));
        vm.prank(ADDR_USER1); c.RegisterFile(HASH_FILE1, 9, ADDR_USER1);

        vm.expectRevert(bytes("Authentication error"));
        vm.prank(ADDR_USER1); c.AppendOwner(HASH_FILE2, ADDR_USER2);

        vm.prank(ADDR_SP); c.RegisterFile(HASH_FILE1, 9, ADDR_USER1);
        vm.prank(ADDR_SP); c.RegisterFile(HASH_FILE2, 20, ADDR_USER1);
        vm.prank(ADDR_SP); c.AppendOwner(HASH_FILE2, ADDR_USER2);

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
        uint256 date0 = 1727740800;        // 2024-10-01 00:00:00
        uint256 date1 = date0 + 1 minutes; // 2024-10-01 00:01:00

        // USER1 reqests audiging of FILE1 and FILE2.
        reqAuditing(ADDR_USER1, HASH_FILE1, chal1);
        reqAuditing(ADDR_USER1, HASH_FILE2, chal2);

        // !!! Error case !!!
        // USER1 makes an auditing request for FILE1 that has already been requested for auditing.
        vm.expectRevert(bytes("Not WaitingChal"));
        reqAuditing(ADDR_USER1, HASH_FILE1, chal1);

        // SP makes proofs.
        makeProof(HASH_FILE1, proof1);
        makeProof(HASH_FILE2, proof2);

        // !!! Error case !!!
        // SP creates again a proof for a request that has already been processed.
        vm.expectRevert(bytes("Not WaitingProof"));
        makeProof(HASH_FILE1, proof1);

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
        checkLog(ADDR_USER1, HASH_FILE1, 0, chal1, proof1, true, date1);
        checkLog(ADDR_USER1, HASH_FILE2, 0, chal2, proof2, true, date1);

        // Check if the request is empty
        checkBlank();

        // !!! Error case !!!
        // Request auditing for FILE1 again, and register the log with a timestamp earlier than the previous result.
        reqAuditing(ADDR_USER1, HASH_FILE1, chal1);
        makeProof(HASH_FILE1, proof1);
        vm.prank(ADDR_TPA);
        vm.warp(date0);
        vm.expectRevert(bytes("timestamp error"));
        c.SetAuditingResult(HASH_FILE1, false);
    }

    function reqAuditing(address _user, bytes32 _hash, bytes memory _chal) private {
        // A user reqests audiging of a file.
        vm.prank(_user);
        c.SetChal(_hash, _chal);
    }

    function makeProof(bytes32 _hash, bytes memory _proof) private {
        vm.prank(ADDR_SP);
        c.SetProof(_hash, _proof);
    }

    function verifyProof(bytes32 _hash, bool _result, uint256 _date) private {
        vm.prank(ADDR_TPA);
        vm.warp(_date);
        c.SetAuditingResult(_hash, _result);
    }

    function checkLog(address _user, bytes32 _hash, uint _index, bytes memory _chal, bytes memory _proof, bool _result, uint256 _date) private {
        vm.prank(_user);
        XZ21.AuditingLog[] memory logs = c.GetAuditingLogs(_hash);
        assertEq(logs[_index].req.chal, _chal);
        assertEq(logs[_index].req.proof, _proof);
        assertEq(logs[_index].result, _result);
        assertEq(logs[_index].date, _date);
    }

    function checkBlank() private {
        vm.prank(ADDR_TPA);
        (bytes32[] memory fileList, XZ21.AuditingReq[] memory reqList) = c.GetAuditingReqList();
        assertEq(fileList.length, 0);
        assertEq(reqList.length, 0);
    }
}
