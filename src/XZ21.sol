// SPDX-License-Identofier: UNLICENSED
pragma solidity ^0.8.13;

import "forge-std/console.sol";

contract XZ21 {
    Param param;
    bool doneRegisterParam;

    address public immutable addrSM;
    address public immutable addrSP;
    address[] public auditorAddrList;

    mapping(address => Account) private userAccountTable;
    mapping(bytes32 => FileProperty) private fileIndexTable;
    mapping(bytes32 => AuditingReq) private auditingReqTable;
    mapping(bytes32 => AuditingLog[]) private auditingLogTable;

    bytes32[] reqBuffer;

    enum Stages {
        WaitingChal,
        WaitingProof,
        WaitingResult
    }

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
        Stages stage;
    }

    struct AuditingLog {
        AuditingReq req;
        bool result;
        uint256 date;
    }

    event EventSetAuditingResult(bytes32 _hash, bool _result);

    modifier onlyBy(address _addr)
    {
        require(msg.sender == _addr);
        _;
    }

    constructor(
        address _addrSP
    )
    {
        addrSM = msg.sender;
        addrSP = _addrSP;
        doneRegisterParam = false;
    }

    function RegisterParam(
        string memory _p,
        bytes memory _g,
        bytes memory _u
    ) onlyBy(addrSM) public
    {
        require(doneRegisterParam == false, "Do not overwrite RegisterParam");
        param.P = _p;
        param.U = _u;
        param.G = _g;
        doneRegisterParam = true;
    }

    function EnrollAccount(
        int _type,
        address _addr,
        bytes calldata _pubKey
    ) public onlyBy(addrSM) returns(bool)
    {
        if (_type == 0) {
            console.log("Enroll TPA account (Address:%s)", _addr);
            auditorAddrList.push(_addr); // TODO: Implement deduplication
        } else if (_type == 1) {
            console.log("Enroll SU account (Address:%s)", _addr);
            userAccountTable[_addr] = Account(_pubKey, new bytes32[](0));
        } else {
            // console.log("Unknown type (type:%d)", _type);
            return false;
        }
        return true;
    }

    function GetUserAccount(
        address _addr
    ) public view returns(Account memory) {
        return userAccountTable[_addr];
    }

    function GetAuditorAddrList() public view returns(address[] memory) {
        return auditorAddrList;
    }

    function GetParam() public view returns(Param memory) {
        return param;
    }

    function RegisterFile(bytes32 _hash, uint32 _splitNum, address _owner) public {
        require(_splitNum > 0, "invalid split num");

        fileIndexTable[_hash].splitNum = _splitNum;
        fileIndexTable[_hash].creator = _owner;
        userAccountTable[_owner].fileList.push(_hash);
    }

    function SearchFile(bytes32 _hash) public view returns(FileProperty memory) {
        return fileIndexTable[_hash];
    }

    function GetFileList(address _owner) public view returns(bytes32[] memory) {
        uint fileListLength = userAccountTable[_owner].fileList.length;
        bytes32[] memory fileList = new bytes32[](fileListLength);
        for(uint i = 0; i < userAccountTable[_owner].fileList.length; i++) {
            fileList[i] = userAccountTable[_owner].fileList[i];
        }
        return fileList;
    }

    function AppendOwner(bytes32 _hash, address _owner) public {
        require(fileIndexTable[_hash].splitNum > 0, "invalid file");

        userAccountTable[_owner].fileList.push(_hash);
    }

    function SetChal(bytes32 _hash, bytes calldata _chal) public {
        require(auditingReqTable[_hash].stage == Stages.WaitingChal, "Not WaitingChal");

        auditingReqTable[_hash].chal = _chal;
        reqBuffer.push(_hash);

        auditingReqTable[_hash].stage = Stages.WaitingProof;
    }

    function SetProof(bytes32 _hash, bytes calldata _proof) public {
        require(auditingReqTable[_hash].stage == Stages.WaitingProof, "Not WaitingProof");

        auditingReqTable[_hash].proof = _proof;

        auditingReqTable[_hash].stage = Stages.WaitingResult;
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
        require(auditingReqTable[_hash].stage == Stages.WaitingResult, "Not WaitingResult");

        if (auditingLogTable[_hash].length > 0) {
            uint tail = auditingLogTable[_hash].length - 1;
            require(auditingLogTable[_hash][tail].date < block.timestamp, "timestamp error");
        }

        AuditingLog memory log = AuditingLog(
            auditingReqTable[_hash],
            _result,
            block.timestamp
        );
        auditingLogTable[_hash].push(log);

        // Remove AuditingReq from the map
        auditingReqTable[_hash] = AuditingReq("", "", Stages.WaitingChal);

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
