// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.13;

import "forge-std/console.sol";

contract XZ21 {
    Para para;

    address public addrSM;
    address public addrSP;
    address public addrTPA;

    mapping(address => Account) private accountIndexTable;
    mapping(bytes32 => FileProperty) private fileIndexTable;

    struct Para {
        string Params;
        bytes U;
        bytes G;
    }

    struct Account {
        bytes pubKey;
    }

    struct FileProperty {
        uint32 splitNum;
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

    function ReadFile(bytes32 _hash) public view returns(FileProperty memory) {
        return fileIndexTable[_hash];
    }

    function RegisterPara(
        string memory _params,
        bytes memory _g,
        bytes memory _u
    ) public
    {
        para.Params = _params;
        para.U = _u;
        para.G = _g;
    }

    function EnrollAccount(
        address _addr,
        bytes calldata _pubKey
    ) public onlyBy(addrSM)
    {
        console.log("Enroll SU account (Address:%s)", _addr);
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

    function RegisterFileProperty(bytes32 _hash, uint32 _splitNum, address _owner) public {
        fileIndexTable[_hash].splitNum = _splitNum;
        fileIndexTable[_hash].owners.push(_owner);
    }

    function FetchFileProperty(bytes32 _hash) public view returns(FileProperty memory) {
        return fileIndexTable[_hash];
    }
}
