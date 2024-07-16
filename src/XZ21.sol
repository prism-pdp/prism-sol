// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.13;

contract XZ21 {
    Para para;

    address public addrSM;
    address public addrSP;
    address public addrTPA;

    mapping(address => Account) AccountIndexTable;
    mapping(string => FileIndex) private fileIndexTable;

    struct Para {
        string Pairing;
        bytes U;
        bytes G;
    }

    struct Account {
        string role;
    }

    struct FileIndex {
        address[] owners; // Owner list
    }

    constructor(
        address _addrTPA,
        address _addrSP
    )
    {
        addrSM = msg.sender;
        addrSP = _addrSP;
        addrTPA = _addrTPA;
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

    function GetPara() public view returns(Para memory) {
        return para;
    }

    function createFileIndex(string memory _id, address _owner) public {
        fileIndexTable[_id].owners.push(_owner);
    }

    function readFileIndex(string memory _id) public view returns(FileIndex memory) {
        return fileIndexTable[_id];
    }

    function updateFileIndex(string memory _id, address _owner) public {
        fileIndexTable[_id].owners.push(_owner);
    }

    function GetAddrSM() public view returns(address)
    {
        return addrSM;
    }

    function GetAddrSP() public view returns(address)
    {
        return addrSP;
    }

    function GetAddrTPA() public view returns(address)
    {
        return addrTPA;
    }
}
