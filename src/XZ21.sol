// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.13;

import "forge-std/console.sol";

contract XZ21 {
    Para para;

    address public addrSM;
    address public addrSP;
    address public addrTPA;

    mapping(address => Account) public accountIndexTable;
    mapping(bytes32 => File) public fileIndexTable;

    struct Para {
        string Pairing;
        bytes U;
        bytes G;
    }

    struct Account {
        string pubKey;
    }

    struct File {
        bytes32 hash;
        address[] owners; // Owner list
    }

    modifier onlyBy(address _addr)
    {
        require(msg.sender == _addr);
        _;
    }

    constructor(
        address _addrSP,
        address _addrTPA
    )
    {
        addrSM = msg.sender;
        addrSP = _addrSP;
        addrTPA = _addrTPA;
    }

    function ReadFile(bytes32 _hash) internal view returns(File memory) {
        return fileIndexTable[_hash];
    }

    function RegisterPara(
        string memory _pairing,
        bytes memory _g,
        bytes memory _u
    ) public
    {
        para.Pairing = _pairing;
        para.U = _u;
        para.G = _g;
    }

    function EnrollAccount(
        address _addr,
        string calldata _pubKey
    ) public onlyBy(addrSM)
    {
        console.log("Enroll SU account (Address:%s, PublicKey:%s)", _addr, _pubKey);
        accountIndexTable[_addr] = Account(_pubKey);
    }

    function GetAccount(
        address _addr
    ) public view returns(Account memory) {
        return accountIndexTable[_addr];
    }

    function GetPara() public view returns(Para memory) {
        return para;
    }

    function RegisterFile(bytes32 _hash, address _owner) public {
        fileIndexTable[_hash].hash = _hash;
        fileIndexTable[_hash].owners.push(_owner);
    }

    function SearchFile(bytes32 _hash) public view returns(bool) {
        if (fileIndexTable[_hash].hash == 0) {
            return false;
        }
        return true;
    }
}
