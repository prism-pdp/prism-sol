// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.13;

import "forge-std/console.sol";

contract XZ21 {
    Param param;

    address public addrSM;
    address public addrSP;
    address public addrTPA;

    mapping(address => Account) private accountIndexTable;
    mapping(bytes32 => FileProperty) private fileIndexTable;
    mapping(bytes32 => AuditingReq) private auditingReqTable;
    mapping(bytes32 => AuditingLog[]) private auditingLogTable;

    bytes32[] reqBuffer;

    struct Param {
        string P;
        bytes U;
        bytes G;
    }

    struct Account {
        bytes pubKey;
        bytes32[] fileList;
    }

    struct FileProperty {
        uint32 splitNum;
        address creator; // Owner list
    }

    struct AuditingReq {
        bytes chal;
        bytes proof;
    }

    struct AuditingLog {
        bytes chal;
        bytes proof;
        bool result;
    }

    event EventSetAuditingResult(bytes32 _hash, bool _result);

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

    function RegisterParam(
        string memory _p,
        bytes memory _g,
        bytes memory _u
    ) public
    {
        param.P = _p;
        param.U = _u;
        param.G = _g;
    }

    function EnrollAccount(
        address _addr,
        bytes calldata _pubKey
    ) public onlyBy(addrSM)
    {
        console.log("Enroll SU account (Address:%s)", _addr);
        accountIndexTable[_addr] = Account(_pubKey, new bytes32[](0));
    }

    function GetAccount(
        address _addr
    ) public view returns(Account memory) {
        return accountIndexTable[_addr];
    }

    function GetParam() public view returns(Param memory) {
        return param;
    }

    function RegisterFile(bytes32 _hash, uint32 _splitNum, address _owner) public {
        require(_splitNum > 0, "invalid split num");

        fileIndexTable[_hash].splitNum = _splitNum;
        fileIndexTable[_hash].creator = _owner;
        accountIndexTable[_owner].fileList.push(_hash);
    }

    function SearchFile(bytes32 _hash) public view returns(FileProperty memory) {
        return fileIndexTable[_hash];
    }

    function GetFileList(address _owner) public view returns(bytes32[] memory) {
        uint fileListLength = accountIndexTable[_owner].fileList.length;
        bytes32[] memory fileList = new bytes32[](fileListLength);
        for(uint i = 0; i < accountIndexTable[_owner].fileList.length; i++) {
            fileList[i] = accountIndexTable[_owner].fileList[i];
        }
        return fileList;
    }

    function AppendOwner(bytes32 _hash, address _owner) public {
        require(fileIndexTable[_hash].splitNum > 0, "invalid file");

        accountIndexTable[_owner].fileList.push(_hash);
    }

    function SetChal(bytes32 _hash, bytes calldata _chal) public {
        require(auditingReqTable[_hash].chal.length == 0, "chal is already set.");

        auditingReqTable[_hash].chal = _chal;
        reqBuffer.push(_hash);
    }

    function SetProof(bytes32 _hash, bytes calldata _proof) public {
        require(auditingReqTable[_hash].chal.length > 0);
        require(auditingReqTable[_hash].proof.length == 0);

        auditingReqTable[_hash].proof = _proof;
    }

    function GetAuditingReqList() public view returns(bytes32[] memory, AuditingReq[] memory) {
        uint num = reqBuffer.length;
        bytes32[] memory fileList = new bytes32[](num);
        AuditingReq[] memory reqList = new AuditingReq[](num);
        for (uint i = 0; i < num; i++) {
            bytes32 h = reqBuffer[i];
            fileList[i] = h;
            reqList[i] = auditingReqTable[h];
        }
        return (fileList, reqList);
    }

    function SetAuditingResult(bytes32 _hash, bool _result) public {
        require(auditingReqTable[_hash].chal.length > 0);
        require(auditingReqTable[_hash].proof.length > 0);

        AuditingLog memory log = AuditingLog(
            auditingReqTable[_hash].chal,
            auditingReqTable[_hash].proof,
            _result
        );
        auditingLogTable[_hash].push(log);

        // Remove AuditingReq from the map
        auditingReqTable[_hash] = AuditingReq("", "");

        // Remove hash from the list
        deleteReqBuffer(_hash);

        emit EventSetAuditingResult(_hash, _result);
    }

    function GetAuditingLogs(bytes32 _hash) public view returns(AuditingLog[] memory) {
        return auditingLogTable[_hash];
    }

    function deleteReqBuffer(bytes32 _hash) private {
        bool found = false;
        uint found_index = 0;
        for (uint i = 0; i < reqBuffer.length; i++) {
            if (_hash == reqBuffer[i]) {
                found = true;
                found_index = i;
                break;
            }
        }
        for (uint i = found_index; i < reqBuffer.length - 1; i++) {
            reqBuffer[i] = reqBuffer[i+1];
        }
        reqBuffer.pop();
    }
}
