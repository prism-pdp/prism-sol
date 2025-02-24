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
    mapping(bytes32 => AuditingLog[]) private auditingLogTable;

    enum Stages {
        WaitingProof,
        WaitingResult,
        DoneAuditing
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

    struct AuditingLog {
        bytes chal;
        bytes proof;
        bool result;
        uint256 date;
        Stages stage;
    }

    event EventSetAuditingResult(bytes32 _hash, bool _result);

    modifier onlyBy(address _addr)
    {
        require(msg.sender == _addr, "Authentication error");
        _;
    }

    modifier onlyBySU()
    {
        require(userAccountTable[msg.sender].pubKey.length > 0, "SU authentication error");
        _;
    }

    modifier onlyByTPA()
    {
        bool found = false;
        for (uint i = 0; i < auditorAddrList.length; i++) {
            if (auditorAddrList[i] == msg.sender) {
                found = true;
                break;
            }
        }
        require(found, "TPA authentication error");
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
        require(_type == 0 || _type == 1, "Invalid type");

        if (_type == 0) {
            bool found = false;
            for (uint i = 0; i < auditorAddrList.length; i++) {
                if (auditorAddrList[i] == _addr) {
                    found = true;
                    break;
                }
            }
            require(found == false, "Duplicate TPA address");
            console.log("Enroll TPA account (Address:%s)", _addr);
            auditorAddrList.push(_addr);
        } else {
            require(userAccountTable[_addr].pubKey.length == 0, "Duplicate SU account");
            console.log("Enroll SU account (Address:%s)", _addr);
            userAccountTable[_addr] = Account(_pubKey, new bytes32[](0));
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

    function RegisterFile(
        bytes32 _hash,
        uint32 _splitNum,
        address _owner
    ) public onlyBy(addrSP) {
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

    function AppendOwner(
        bytes32 _hash,
        address _owner
    ) public onlyBy(addrSP) {
        require(fileIndexTable[_hash].splitNum > 0, "invalid file");

        userAccountTable[_owner].fileList.push(_hash);
    }

    function SetChal(
        bytes32 _hash,
        bytes calldata _chal
    ) public onlyBySU() {
        uint size = auditingLogTable[_hash].length;
        if (size > 0) {
            uint pos = size - 1;
            require(auditingLogTable[_hash][pos].stage == Stages.DoneAuditing, "Not WaitingChal");
        }

        AuditingLog memory log = AuditingLog(
            _chal,
            "",
            false,
            0,
            Stages.WaitingProof
        );
        auditingLogTable[_hash].push(log);
    }

    function SetProof(
        bytes32 _hash,
        bytes calldata _proof
    ) public onlyBy(addrSP) {
        uint size = auditingLogTable[_hash].length;
        require(size > 0, "Missing challenge");
        uint pos = size - 1;
        require(auditingLogTable[_hash][pos].stage == Stages.WaitingProof, "Not WaitingProof");

        auditingLogTable[_hash][pos].proof = _proof;
        auditingLogTable[_hash][pos].stage = Stages.WaitingResult;
    }

    function GetLatestAuditingLog(bytes32 _hash) public view returns(AuditingLog memory) {
        uint size = auditingLogTable[_hash].length;
        require(size > 0, "No data");
        uint pos = size - 1;
        return auditingLogTable[_hash][pos];
    }

    function SetAuditingResult(
        bytes32 _hash,
        bool _result
    ) public onlyByTPA() {
        uint size = auditingLogTable[_hash].length;
        require(size > 0, "Missing proof");
        uint pos = size - 1;
        require(auditingLogTable[_hash][pos].stage == Stages.WaitingResult, "Not WaitingResult");

        if (pos > 0) {
            uint tail = pos - 1;
            require(auditingLogTable[_hash][tail].date < block.timestamp, "timestamp error");
        }

        auditingLogTable[_hash][pos].result = _result;
        auditingLogTable[_hash][pos].date = block.timestamp;
        auditingLogTable[_hash][pos].stage = Stages.DoneAuditing;

        emit EventSetAuditingResult(_hash, _result);
    }

    function GetAuditingLogs(bytes32 _hash) public view returns(AuditingLog[] memory) {
        return auditingLogTable[_hash];
    }
}
