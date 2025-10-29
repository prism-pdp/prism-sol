// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.24;

import {XZ21} from "../src/XZ21.sol";
import {Test} from "forge-std/Test.sol";

contract G1_Authz_XZ21_RegisterParam is Test {

    address constant SM_ADDR  = address(0x1000);
    address constant SP_ADDR  = address(0x2000);

    function test_G1(
        address caller
    ) public {
        vm.prank(SM_ADDR);
        XZ21 s = new XZ21(SP_ADDR);

        string memory testP = "P2"; // param.P は string だが内部では string
        bytes  memory testG = bytes("G2");
        bytes  memory testU = bytes("U2");

        vm.prank(caller);
        s = new XZ21(SP_ADDR);

        vm.prank(caller);
        try s.registerParam(testP, testG, testU) {
            if (caller != SM_ADDR) {
                fail();
            }
        } catch {
            if (caller == SM_ADDR) {
                fail();
            }
        }
    }
}

contract G1_Authz_XZ21_EnrollAccount is Test{

    address constant SM_ADDR  = address(0x1000);
    address constant SP_ADDR  = address(0x2000);

    address constant TEST_ADDR  = address(0x9000);

    function test_G1(
        address caller,
        int accountType
    ) public {
        vm.assume(accountType == 0 || accountType == 1);

        vm.prank(SM_ADDR);
        XZ21 s = new XZ21(SP_ADDR);

        vm.prank(caller);
        try s.enrollAccount(accountType, TEST_ADDR, hex"01") {
            if (caller != SM_ADDR) {
                fail();
            }
        } catch {
            if (caller == SM_ADDR) {
                fail();
            }
        }
    }
}

contract G1_Authz_XZ21_RegisterFile is Test {

    address constant SM_ADDR  = address(0x1000);
    address constant SP_ADDR  = address(0x2000);
    address constant SU_ADDR  = address(0x3000);

    function test_G1(
        address caller
    ) public {
        vm.prank(SM_ADDR);
        XZ21 s = new XZ21(SP_ADDR);

        vm.prank(SM_ADDR);
        s.enrollAccount(1, SU_ADDR, hex"01");

        vm.prank(caller);
        try s.registerFile(keccak256("file"), 10, SU_ADDR) {
            if (caller != SP_ADDR) {
                fail();
            }
        } catch {
            if (caller == SP_ADDR) {
                fail();
            }
        }
    }
}

contract G1_Authz_XZ21_AppendOwner is Test {

    address constant SM_ADDR  = address(0x1000);
    address constant SP_ADDR  = address(0x2000);
    address constant SU_ADDR  = address(0x3000);

    bytes32 constant TEST_HASH = keccak256("file");
    address constant TEST_ADDR = address(0x9000);

    function test_G1(
        address caller
    ) public {
        vm.prank(SM_ADDR);
        XZ21 s = new XZ21(SP_ADDR);

        vm.prank(SM_ADDR);
        s.enrollAccount(1, SU_ADDR, hex"01");
        vm.prank(SM_ADDR);
        s.enrollAccount(1, TEST_ADDR, hex"02");

        vm.prank(SP_ADDR);
        s.registerFile(TEST_HASH, 10, SU_ADDR);

        vm.prank(caller);
        try s.appendOwner(TEST_HASH, TEST_ADDR) {
            if (caller != SP_ADDR) {
                fail();
            }
        } catch {
            if (caller == SP_ADDR) {
                fail();
            }
        }
    }
}

contract G1_Authz_XZ21_SetChal is Test{

    address constant SM_ADDR  = address(0x1000);
    address constant SP_ADDR  = address(0x2000);
    address constant SU_ADDR  = address(0x3000);

    bytes32 constant TEST_HASH = keccak256("file");
    bytes constant TEST_CHAL = bytes("chal");

    function test_G1(
        address caller
    ) public {
        vm.prank(SM_ADDR);
        XZ21 s = new XZ21(SP_ADDR);

        vm.prank(SM_ADDR);
        s.enrollAccount(1, SU_ADDR, hex"01");

        vm.prank(SP_ADDR);
        s.registerFile(TEST_HASH, 10, SU_ADDR);

        vm.prank(caller);
        try s.setChal(TEST_HASH, TEST_CHAL) {
            if (caller != SU_ADDR) {
                fail();
            }
        } catch {
            if (caller == SU_ADDR) {
                fail();
            }
        }
    }
}

contract G1_Authz_XZ21_SetProof is Test {

    address constant SM_ADDR  = address(0x1000);
    address constant SP_ADDR  = address(0x2000);
    address constant SU_ADDR  = address(0x3000);

    bytes32 constant TEST_HASH = keccak256("file");
    bytes constant TEST_CHAL = bytes("chal");
    bytes constant TEST_PROOF = bytes("proof");

    function test_G1(
        address caller
    ) public {
        vm.prank(SM_ADDR);
        XZ21 s = new XZ21(SP_ADDR);

        vm.prank(SM_ADDR);
        s.enrollAccount(1, SU_ADDR, hex"01");

        vm.prank(SP_ADDR);
        s.registerFile(TEST_HASH, 10, SU_ADDR);

        vm.prank(SU_ADDR);
        s.setChal(TEST_HASH, TEST_CHAL);

        vm.prank(caller);
        try s.setProof(TEST_HASH, TEST_PROOF) {
            if (caller != SP_ADDR) {
                fail();
            }
        } catch {
            if (caller == SP_ADDR) {
                fail();
            }
        }
    }
}

contract G1_Authz_XZ21_SetAuditingResult is Test{

    address constant SM_ADDR  = address(0x1000);
    address constant SP_ADDR  = address(0x2000);
    address constant SU_ADDR  = address(0x3000);
    address constant TPA_ADDR = address(0x4000);

    bytes32 constant TEST_HASH = keccak256("file");
    bytes constant TEST_CHAL = bytes("chal");
    bytes constant TEST_PROOF = bytes("proof");

    function test_G1(
        address caller
    ) public {
        vm.prank(SM_ADDR);
        XZ21 s = new XZ21(SP_ADDR);

        vm.prank(SM_ADDR);
        s.enrollAccount(0, TPA_ADDR, hex"01");
        vm.prank(SM_ADDR);
        s.enrollAccount(1, SU_ADDR, hex"02");

        vm.prank(SP_ADDR);
        s.registerFile(TEST_HASH, 10, SU_ADDR);

        vm.prank(SU_ADDR);
        s.setChal(TEST_HASH, TEST_CHAL);

        vm.prank(SP_ADDR);
        s.setProof(TEST_HASH, TEST_PROOF);

        vm.warp(1000000);
        vm.prank(caller);
        try s.setAuditingResult(TEST_HASH, true) {
            if (caller != TPA_ADDR) {
                fail();
            }
        } catch {
            if (caller == TPA_ADDR) {
                fail();
            }
        }
    }
}
