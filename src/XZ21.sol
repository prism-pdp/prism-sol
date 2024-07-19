// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.13;

contract XZ21 {
    Para para;

    address public addrSM;
    address public addrSP;
    address public addrTPA;

    mapping(address => Account) private accountIndexTable;
    mapping(bytes32 => File) private fileIndexTable;

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
        bytes32[] owners; // Owner list
    }

    modifier onlyBy(address _addr)
    {
        require(msg.sender == _addr);
        _;
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
        accountIndexTable[_addr] = Account(_pubKey);
    }

    function AccountStatus() public view returns(bool) {
        if (bytes(accountIndexTable[msg.sender].pubKey).length == 0) {
            return false;
        }
        return true;
    }

    function GetPara() public view returns(Para memory) {
        return para;
    }

    function RegisterFile(bytes32 _hash, bytes32 _id) public {
        fileIndexTable[_hash].hash = _hash;
        fileIndexTable[_hash].owners.push(_id);
    }

    function SearchFile(bytes32 _hash) public view returns(bool) {
        if (fileIndexTable[_hash].hash == 0) {
            return false;
        }
        return true;
    }

    function AppendAccount() public {
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
