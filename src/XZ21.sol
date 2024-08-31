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

    bytes32[] chalBuffer;
    bytes32[] auditingReqList;

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
        AuditingReq memory req = AuditingReq(_chal, "");
        auditingReqTable[_hash] = req; // TODO: check overwrite
        chalBuffer.push(_hash); // TODO: check duplicate push
    }

    function GetChalList() public view returns(bytes32[] memory, bytes[] memory) {
        uint num = chalBuffer.length;
        bytes32[] memory fileList = new bytes32[](num);
        bytes[] memory chalList = new bytes[](num);
        for (uint i = 0; i < num; i++) {
            bytes32 h = chalBuffer[i];
            fileList[i] = h;
            chalList[i] = auditingReqTable[h].chal;
        }
        return (fileList, chalList);
    }

    function SetProof(bytes32 _hash, bytes calldata _proof) public {
        bool found = false;
        uint found_index = 0;
        for (uint i = 0; i < chalBuffer.length; i++) {
            if (_hash == chalBuffer[i]) {
                found = true;
                found_index = i;
                break;
            }
        }

        require(found, "Unknown hash value");

        auditingReqTable[_hash].proof = _proof;
        auditingReqList.push(_hash);

        for (uint i = found_index; i < chalBuffer.length - 1; i++) {
            chalBuffer[i] = chalBuffer[i+1];
        }
        chalBuffer.pop();
    }

    function GetAuditingReqList() public view returns(bytes32[] memory, AuditingReq[] memory) {
        uint num = auditingReqList.length;
        bytes32[] memory fileList = new bytes32[](num);
        AuditingReq[] memory reqList = new AuditingReq[](num);
        for (uint i = 0; i < num; i++) {
            bytes32 h = auditingReqList[i];
            fileList[i] = h;
            reqList[i] = auditingReqTable[h];
        }
        return (fileList, reqList);
    }

    function SetAuditingResult(bytes32 _hash, bool _result) public {
        bool found = false;
        uint found_index = 0;
        for (uint i = 0; i < auditingReqList.length; i++) {
            if (_hash == auditingReqList[i]) {
                found = true;
                found_index = i;
                break;
            }
        }

        require(found, "Unknown hash value");

        AuditingLog memory log = AuditingLog(
            auditingReqTable[_hash].chal,
            auditingReqTable[_hash].proof,
            _result
        );
        auditingLogTable[_hash].push(log);

        for (uint i = found_index; i < auditingReqList.length - 1; i++) {
            auditingReqList[i] = auditingReqList[i+1];
        }
        auditingReqList.pop();
    }

    function GetAuditingLogs(bytes32 _hash) public view returns(AuditingLog[] memory) {
        return auditingLogTable[_hash];
    }
}
