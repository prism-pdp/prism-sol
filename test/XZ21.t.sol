// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.13;

import "forge-std/console.sol";
import "forge-std/Test.sol";
import "../src/XZ21.sol";

contract XZ21Test is Test {
    XZ21 public c;

    string constant PAIRING = "test-value(pairing)";
    bytes constant G = "0xAA";
    bytes constant U = "0xBB";
    bytes32 constant HASH_FILE1 = keccak256("File1");
    bytes32 constant HASH_FILE2 = keccak256("File2");
    string constant KEY_USER1 = "KEY1";
    string constant KEY_USER2 = "KEY2";
    string constant KEY_USER3 = "KEY3";

    address ADDR_SM;
    address ADDR_TPA;
    address ADDR_SP;
    address ADDR_USER0;
    address ADDR_USER1;
    address ADDR_USER2;
    address ADDR_USER3;

    function setUp() public {
        // Prepare variables
        ADDR_SM    = vm.addr(1000);
        ADDR_TPA   = vm.addr(1001);
        ADDR_SP    = vm.addr(1002);
        ADDR_USER0 = vm.addr(2000); // dummy user
        ADDR_USER1 = vm.addr(2001);
        ADDR_USER2 = vm.addr(2002);
        ADDR_USER3 = vm.addr(2003);
        // c.RegisterFile(HASH_FILE1, keccak256(bytes(KEY_USER1)));
        // c.RegisterFile(HASH_FILE2, keccak256(bytes(KEY_USER1)));

        vm.prank(ADDR_SM);
        c = new XZ21(ADDR_TPA, ADDR_SP);
        vm.prank(ADDR_SM);
        c.RegisterPara(PAIRING, G, U);
        vm.prank(ADDR_SM);
        c.EnrollAccount(ADDR_USER1, KEY_USER1);
        vm.prank(ADDR_SM);
        c.EnrollAccount(ADDR_USER2, KEY_USER2);
        vm.prank(ADDR_SM);
        c.EnrollAccount(ADDR_USER3, KEY_USER3);
    }

    function testSetupPhase() public {
        address addrSM = c.GetAddrSM();
        assertEq(addrSM, ADDR_SM);

        address addrTPA = c.GetAddrTPA();
        assertEq(addrTPA, ADDR_TPA);

        address addrSP = c.GetAddrSP();
        assertEq(addrSP, ADDR_SP);

        XZ21.Para memory para = c.GetPara();
        assertEq(para.Pairing, PAIRING);
        assertEq(para.G, G);
        assertEq(para.U, U);

        vm.prank(ADDR_USER1);
        assertTrue(c.AccountStatus());

        vm.prank(ADDR_USER2);
        assertTrue(c.AccountStatus());

        vm.prank(ADDR_USER3);
        assertTrue(c.AccountStatus());

        vm.prank(ADDR_USER0);
        assertFalse(c.AccountStatus());
    }

    // function testPara() public view {
    //     XZ21.Para memory para = c.GetPara();
    //     assertEq(para.Pairing, PAIRING);
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
