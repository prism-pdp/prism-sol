// SPDX-License-Identofier: UNLICENSED
pragma solidity ^0.8.24;

contract XZ21 {
    Param param;
    bool doneRegisterParam;

    address public immutable SM_ADDR;
    address public immutable SP_ADDR;
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

    event EventSetAuditingResult(bytes32 hashVal, bool result);

    modifier smOnly() {
        _smOnly();
        _;
    }

    function _smOnly() internal view {
        require(SM_ADDR == msg.sender, "Authentication error (Only by SM)");
    }

    modifier spOnly() {
        _spOnly();
        _;
    }

    function _spOnly() internal view {
        require(SP_ADDR == msg.sender, "Authentication error (Only by SP)");
    }

    modifier suOnly() {
        _suOnly();
        _;
    }

    function _suOnly() internal view {
        require(userAccountTable[msg.sender].pubKey.length > 0, "Authentication error (Only by SU)");
    }

    modifier tpaOnly() {
        _tpaOnly();
        _;
    }

    function _tpaOnly() internal view {
        require(isAuditor(msg.sender), "Authentication error (Only by TPA)");
    }

    function isAuditor(address addr) public view returns(bool) {
        for (uint i = 0; i < auditorAddrList.length; i++) {
            if (auditorAddrList[i] == addr) {
                return true;
            }
        }
        return false;
    }
   
    constructor(
        address _spAddr
    )
    {
        require(_spAddr != address(0), "SP_ADDR is zero");
        SM_ADDR = msg.sender;
        SP_ADDR = _spAddr;
        doneRegisterParam = false;
    }

    /// #if_succeeds {:msg "Only SM may register param"} msg.sender == SM_ADDR;
    /// #require {:msg "Function can only be called once"} doneRegisterParam == false;
    /// #if_succeeds {:msg "doneRegisterParam flag must be true after call"} doneRegisterParam == true;
    function registerParam(
        string memory paramP,
        bytes memory paramG,
        bytes memory paramU
    ) smOnly() public
    {
        require(!doneRegisterParam, "Do not overwrite registerParam");
        param.P = paramP;
        param.U = paramU;
        param.G = paramG;
        doneRegisterParam = true;
    }

    /// #if_succeeds {:msg "Only SM may enroll"} msg.sender == SM_ADDR;
    /// #if_succeeds {:msg "No duplicate address"} (
    ///     (accountType == 0) ==> !old(_auditorContains(addr))
    /// );
    /// #if_succeeds {:msg "Account type must be valid"} (
    ///     accountType == 0 || accountType == 1
    /// );
    function enrollAccount(
        int accountType,
        address addr,
        bytes calldata pubKey
    ) public smOnly() returns(bool)
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
            userAccountTable[addr] = Account({
                pubKey: pubKey,
                fileList: new bytes32[](0)
            });
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

    /// #if_succeeds {:msg "Only SP may register files"} msg.sender == SP_ADDR;
    /// #if_succeeds {:msg "XXX"} old(fileIndexTable[hashVal].creator) == address(0) ==> owner == fileIndexTable[hashVal].creator;
    /// #if_succeeds {:msg "XXX"} old(fileIndexTable[hashVal].splitNum) == 0 ==> splitNum == fileIndexTable[hashVal].splitNum;
    function registerFile(
        bytes32 hashVal,
        uint32 splitNum,
        address owner
    ) public spOnly() {
        require(splitNum > 0, "invalid split num");
        require(fileIndexTable[hashVal].creator == address(0));

        fileIndexTable[hashVal].splitNum = splitNum;
        fileIndexTable[hashVal].creator = owner;
        userAccountTable[owner].fileList.push(hashVal);
    }

    function searchFile(bytes32 hashVal) public view returns(FileProperty memory) {
        return fileIndexTable[hashVal];
    }

    function getFileList(address owner) public view returns(bytes32[] memory) {
        uint fileListLength = userAccountTable[owner].fileList.length;
        bytes32[] memory fileList = new bytes32[](fileListLength);
        for(uint i = 0; i < userAccountTable[owner].fileList.length; i++) {
            fileList[i] = userAccountTable[owner].fileList[i];
        }
        return fileList;
    }

    /// #if_succeeds {:msg "Only SP may append owners"} msg.sender == SP_ADDR;
    function appendOwner(
        bytes32 hashVal,
        address owner
    ) public spOnly() {
        require(fileIndexTable[hashVal].splitNum > 0, "invalid file");

        userAccountTable[owner].fileList.push(hashVal);
    }

    /// #if_succeeds {:msg "Caller must exist in userAccountTable"} userAccountTable[msg.sender].pubKey.length > 0;
    function setChal(
        bytes32 hashVal,
        bytes calldata chal
    ) public suOnly() {
        uint size = auditingLogTable[hashVal].length;
        if (size > 0) {
            uint pos = size - 1;
            require(auditingLogTable[hashVal][pos].stage == Stages.DoneAuditing, "Not WaitingChal");
        }

        AuditingLog memory log = AuditingLog({
            chal: chal,
            proof: "",
            result: false,
            date: 0,
            stage: Stages.WaitingProof
        });
        auditingLogTable[hashVal].push(log);
    }

    /// #if_succeeds {:msg "Only SP may set proof"} msg.sender == SP_ADDR;
    /// #require {:msg "challenge must be set"} auditingLogTable[hashVal].length > 0;
    /// #require {:msg "Stage must be WaitingProof"} auditingLogTable[hashVal][auditingLogTable[hashVal].length - 1].stage == Stages.WaitingProof;
    function setProof(
        bytes32 hashVal,
        bytes calldata proof
    ) public spOnly() {
        uint size = auditingLogTable[hashVal].length;
        require(size > 0, "Missing challenge");
        uint pos = size - 1;
        require(auditingLogTable[hashVal][pos].stage == Stages.WaitingProof, "Not WaitingProof");

        auditingLogTable[hashVal][pos].proof = proof;
        auditingLogTable[hashVal][pos].stage = Stages.WaitingResult;
    }

    function getLatestAuditingLog(bytes32 hashVal) public view returns(AuditingLog memory) {
        uint size = auditingLogTable[hashVal].length;
        require(size > 0, "No data");
        uint pos = size - 1;
        return auditingLogTable[hashVal][pos];
    }

    /// #if_succeeds {:msg "Only TPA may set auditing result"} isAuditor(msg.sender);
    /// #if_succeeds {:msg "XXX"} auditingLogTable[hashVal].length > 1 ==> auditingLogTable[hashVal][auditingLogTable[hashVal].length - 2].date < block.timestamp;
    function setAuditingResult(
        bytes32 hashVal,
        bool result
    ) public tpaOnly() {
        uint size = auditingLogTable[hashVal].length;
        require(size > 0, "Missing proof");
        uint pos = size - 1;
        require(auditingLogTable[hashVal][pos].stage == Stages.WaitingResult, "Not WaitingResult");

        if (pos > 0) {
            uint tail = pos - 1;
            require(auditingLogTable[hashVal][tail].date < block.timestamp, "timestamp error");
        }

        auditingLogTable[hashVal][pos].result = result;
        auditingLogTable[hashVal][pos].date = block.timestamp;
        auditingLogTable[hashVal][pos].stage = Stages.DoneAuditing;

        emit EventSetAuditingResult(hashVal, result);
    }

    function getAuditingLogs(bytes32 hashVal) public view returns(AuditingLog[] memory) {
        return auditingLogTable[hashVal];
    }

    function _auditorContains(address addr) internal view returns(bool) {
        for (uint i = 0; i < auditorAddrList.length; i++) {
            if (auditorAddrList[i] == addr) {
                return true;
            }
        }
        return false;
    }
}
