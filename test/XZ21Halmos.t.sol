// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.13;

import {Test} from "forge-std/Test.sol";
import {XZ21} from "../src/XZ21.sol";

contract XZ21HalmosSpec is Test {
    string constant P = "test parameter";
    bytes constant G = "0xAA";
    bytes constant U = "0xBB";

    address constant ADDR_SM = address(0x1000);
    address constant ADDR_SP = address(0x2000);
    address constant ADDR_TPA = address(0x3000);
    address constant ADDR_USER = address(0x4000);

    bytes constant KEY_USER = "0x4000";

    XZ21 internal c;

    function setUp() public virtual {
        vm.prank(ADDR_SM);
        c = new XZ21(ADDR_SP);
   }

    function check_SystemManagerCanRegisterParam(
        address caller,
        string calldata paramP,
        bytes calldata paramG,
        bytes calldata paramU
    ) public {
        vm.assume(
            caller == ADDR_SM || caller == ADDR_SP || caller == ADDR_TPA || caller == ADDR_USER
        );

        vm.prank(caller);
        c.registerParam(paramP, paramG, paramU);
    }

    function check_SystemManagerCanEnrollAccount(
        address caller,
        int accountType,
        address addr,
        bytes calldata pubKey
    ) public {
        vm.assume(
            caller == ADDR_SM || caller == ADDR_SP || caller == ADDR_TPA || caller == ADDR_USER
        );

        vm.prank(caller);
        c.enrollAccount(accountType, addr, pubKey);
    }

    function check_ServiceProviderCanRegisterFile(
        address caller,
        bytes32 hashVal,
        uint32 splitNum,
        address owner
    ) public {
        vm.assume(
            caller == ADDR_SM || caller == ADDR_SP || caller == ADDR_TPA || caller == ADDR_USER
        );

        vm.prank(caller);
        c.registerFile(hashVal, splitNum, owner);
    }

    //function check_ServiceProviderCannotRegisterDuplicateFile(
    //    address caller,
    //    bytes32 hashVal,
    //    uint32 splitNum,
    //    address owner
    //) public {
    //    vm.assume(caller == ADDR_SP);

    //    vm.prank(caller);
    //    c.registerFile(hashVal, splitNum, owner);
    //    vm.prank(caller);
    //    c.registerFile(hashVal, splitNum, owner);
    //}

    function check_ServiceProviderCanAppendOwner(
        address caller,
        bytes32 hashVal,
        address owner
    ) public {
        vm.assume(
            caller == ADDR_SM || caller == ADDR_SP || caller == ADDR_TPA || caller == ADDR_USER
        );

        vm.prank(ADDR_SP);
        c.registerFile(hashVal, 10, ADDR_USER);

        vm.prank(caller);
        c.appendOwner(hashVal, owner);
    }
}