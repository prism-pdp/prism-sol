// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.24;

import "./Base_XZ21_Setup.t.sol";

contract G1_Authz_XZ21 is Base_XZ21_Setup {

    function check_G1_registerParam_onlySM(
        address caller
    ) public {
        vm.assume(caller != SM_ADDR);
        string memory testP = "P2"; // param.P は string だが内部では string
        bytes  memory testG = bytes("G2");
        bytes  memory testU = bytes("U2");

        vm.prank(SM_ADDR);
        s = new XZ21(SP_ADDR);

        vm.prank(caller);
        try s.registerParam(testP, testG, testU) {
            fail();
        } catch {
        }
    }

    function check_G1_enrollAccount_onlySM(
        address caller,
        int accountType,
        address enrollAddr
    ) public {
        vm.assume(caller != SM_ADDR);
        vm.assume(accountType == 0 || accountType == 1);

        vm.prank(caller);
        try s.enrollAccount(accountType, enrollAddr, hex"01") {
            fail();
        } catch {}
    }

    function check_G1_registerFile_onlySP(address caller) public {
        vm.assume(caller != SP_ADDR);

        vm.prank(caller);
        try s.registerFile(keccak256("file"), 1, SU_ADDR) {
            fail();
        } catch {}
    }

    function check_G1_appendOwner_onlySP(address caller) public {
        vm.assume(caller != SP_ADDR);

        vm.prank(caller);
        try s.appendOwner(keccak256("file"), SU_ADDR) {
            fail();
        } catch {}
    }

    function check_G1_setChal_onlySU(address caller) public {
        vm.assume(caller != SU_ADDR);

        vm.prank(caller);
        try s.setChal(keccak256("file"), hex"11") {
            fail();
        } catch {}
    }

    function check_G1_setProof_onlySP(address caller) public {
        vm.assume(caller != SP_ADDR);
        bytes32 hashVal = keccak256("file");

        // 前段: SU が challenge を入れる
        vm.prank(SU_ADDR);
        s.setChal(hashVal, hex"11");

        vm.prank(caller);
        try s.setProof(hashVal, hex"22") {
            fail();
        } catch {}
    }

    function check_G1_setAuditingResult_onlyTPA(address caller) public {
        vm.assume(caller != TPA_ADDR);
        bytes32 hashVal = keccak256("file");

        // 前段: SU -> SP の順で進める
        vm.prank(SU_ADDR);
        s.setChal(hashVal, hex"11");
        vm.prank(SP_ADDR);
        s.setProof(hashVal, hex"22");

        // 非TPA を弾く
        vm.prank(caller);
        try s.setAuditingResult(hashVal, true) {
            fail();
        } catch {}
    }
}