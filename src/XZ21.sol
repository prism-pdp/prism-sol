// SPDX-License-Identofier: UNLICENSED
pragma solidity ^0.8.24;

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

    event EventSetAuditingResult(bytes32 hash, bool result);

    modifier isSM()
    {
        require(addrSM == msg.sender, "Authentication error (Only by SM)");
        _;
    }

    modifier isSP()
    {
        require(addrSP == msg.sender, "Authentication error (Only by SP)");
        _;
    }

    modifier isSU()
    {
        require(userAccountTable[msg.sender].pubKey.length > 0, "Authentiction error (Only by SU)");
        _;
    }

    modifier isTPA()
    {
        bool found = false;
        for (uint i = 0; i < auditorAddrList.length; i++) {
            if (auditorAddrList[i] == msg.sender) {
                found = true;
                break;
            }
        }
        require(found, "Authentication error (Only by TPA)");
        _;
    }
    
    constructor(
        address _addrSP
    )
    {
        require(_addrSP != address(0), "addrSP is zero");
        addrSM = msg.sender;
        addrSP = _addrSP;
        doneRegisterParam = false;
    }

    function registerParam(
        string memory paramP,
        bytes memory paramG,
        bytes memory paramU
    ) isSM() public
    {
        require(!doneRegisterParam, "Do not overwrite registerParam");
        param.P = paramP;
        param.U = paramU;
        param.G = paramG;
        doneRegisterParam = true;
    }

    function enrollAccount(
        int accountType,
        address addr,
        bytes calldata pubKey
    ) public isSM() returns(bool)
    {
        require(accountType == 0 || accountType == 1, "Invalid account type");

        if (accountType == 0) {
            bool found = false;
            uint len = auditorAddrList.length;
            for (uint i = 0; i < len; i++) {
                if (auditorAddrList[i] == addr) {
                    found = true;
                    break;
                }
            }
            require(!found, "Duplicate TPA address");
            auditorAddrList.push(addr);
        } else {
            require(userAccountTable[addr].pubKey.length == 0, "Duplicate SU account");
            userAccountTable[addr] = Account(pubKey, new bytes32[](0));
        }

        return true;
    }

    function getUserAccount(
        address addr
    ) public view returns(Account memory) {
        return userAccountTable[addr];
    }

    function getAuditorAddrList() public view returns(address[] memory) {
        return auditorAddrList;
    }

    function getParam() public view returns(Param memory) {
        return param;
    }

    function registerFile(
        bytes32 hash,
        uint32 splitNum,
        address owner
    ) public isSP() {
        require(splitNum > 0, "invalid split num");

        fileIndexTable[hash].splitNum = splitNum;
        fileIndexTable[hash].creator = owner;
        userAccountTable[owner].fileList.push(hash);
    }

    function searchFile(bytes32 hash) public view returns(FileProperty memory) {
        return fileIndexTable[hash];
    }

    function getFileList(address owner) public view returns(bytes32[] memory) {
        uint fileListLength = userAccountTable[owner].fileList.length;
        bytes32[] memory fileList = new bytes32[](fileListLength);
        for(uint i = 0; i < userAccountTable[owner].fileList.length; i++) {
            fileList[i] = userAccountTable[owner].fileList[i];
        }
        return fileList;
    }

    function appendOwner(
        bytes32 hash,
        address owner
    ) public isSP() {
        require(fileIndexTable[hash].splitNum > 0, "invalid file");

        userAccountTable[owner].fileList.push(hash);
    }

    function setChal(
        bytes32 hash,
        bytes calldata chal
    ) public isSU() {
        uint size = auditingLogTable[hash].length;
        if (size > 0) {
            uint pos = size - 1;
            require(auditingLogTable[hash][pos].stage == Stages.DoneAuditing, "Not WaitingChal");
        }

        AuditingLog memory log = AuditingLog(
            chal,
            "",
            false,
            0,
            Stages.WaitingProof
        );
        auditingLogTable[hash].push(log);
    }

    function setProof(
        bytes32 hash,
        bytes calldata proof
    ) public isSP() {
        uint size = auditingLogTable[hash].length;
        require(size > 0, "Missing challenge");
        uint pos = size - 1;
        require(auditingLogTable[hash][pos].stage == Stages.WaitingProof, "Not WaitingProof");

        auditingLogTable[hash][pos].proof = proof;
        auditingLogTable[hash][pos].stage = Stages.WaitingResult;
    }

    function getLatestAuditingLog(bytes32 hash) public view returns(AuditingLog memory) {
        uint size = auditingLogTable[hash].length;
        require(size > 0, "No data");
        uint pos = size - 1;
        return auditingLogTable[hash][pos];
    }

    function setAuditingResult(
        bytes32 hash,
        bool result
    ) public isTPA() {
        uint size = auditingLogTable[hash].length;
        require(size > 0, "Missing proof");
        uint pos = size - 1;
        require(auditingLogTable[hash][pos].stage == Stages.WaitingResult, "Not WaitingResult");

        if (pos > 0) {
            uint tail = pos - 1;
            require(auditingLogTable[hash][tail].date < block.timestamp, "timestamp error");
        }

        auditingLogTable[hash][pos].result = result;
        auditingLogTable[hash][pos].date = block.timestamp;
        auditingLogTable[hash][pos].stage = Stages.DoneAuditing;

        emit EventSetAuditingResult(hash, result);
    }

    function getAuditingLogs(bytes32 hash) public view returns(AuditingLog[] memory) {
        return auditingLogTable[hash];
    }
}
