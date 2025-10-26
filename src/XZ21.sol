// SPDX-License-Identofier: UNLICENSED
pragma solidity 0.8.24;

contract XZ21 {
    Param param;
    bool doneRegisterParam;

    address public immutable smAddr;
    address public immutable spAddr;
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

    event EventRegisterParam();
    event EventEnrollAccount(int accountType, address indexed addr);
    event EventRegisterFile(address indexed owner, bytes32 indexed hashVal, uint32 splitNum);
    event EventAppendOwner(address indexed owner, bytes32 indexed hashVal);
    event EventSetChal(bytes32 indexed hashVal);
    event EventSetProof(bytes32 indexed hashVal);
    event EventSetAuditingResult(bytes32 indexed hashVal, bool result);

    modifier smOnly() {
        _smOnly();
        _;
    }

    function _smOnly() internal view {
        require(smAddr == msg.sender, "Authentication error (Only by SM)");
    }

    modifier spOnly() {
        _spOnly();
        _;
    }

    function _spOnly() internal view {
        require(spAddr == msg.sender, "Authentication error (Only by SP)");
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
        uint256 len = auditorAddrList.length;
        for (uint256 i = 0; i < len; i++) {
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
        require(_spAddr != address(0), "spAddr is zero");
        smAddr = msg.sender;
        spAddr = _spAddr;
        doneRegisterParam = false;
    }

    /// #if_succeeds {:msg "G1: Only SM may register param"} msg.sender == smAddr;
    /// #if_succeeds {:msg "G2: doneRegisterParam can be call only once"} old(doneRegisterParam) == false && doneRegisterParam == true;
    function registerParam(
        string memory paramP,
        bytes memory paramG,
        bytes memory paramU
    ) smOnly() external
    {
        require(!doneRegisterParam, "Do not overwrite registerParam");
        param.P = paramP;
        param.U = paramU;
        param.G = paramG;
        doneRegisterParam = true;

        emit EventRegisterParam();
    }

    /// #if_succeeds {:msg "G1: Only SM may enroll account"} msg.sender == smAddr;
    /// #if_succeeds {:msg "G3: No duplicate address"} (
    ///     (accountType == 0) ==> !old(_auditorContains(addr))
    /// );
    function enrollAccount(
        int accountType,
        address addr,
        bytes calldata pubKey
    ) external smOnly() returns(bool)
    {
        require(accountType == 0 || accountType == 1, "Invalid account type");

        if (accountType == 0) {
            require(!_auditorContains(addr), "Duplicate TPA address");
            auditorAddrList.push(addr);
        } else {
            require(userAccountTable[addr].pubKey.length == 0, "Duplicate SU account");
            userAccountTable[addr] = Account({
                pubKey: pubKey,
                fileList: new bytes32[](0)
            });
        }

        emit EventEnrollAccount(accountType, addr);

        return true;
    }

    function getUserAccount(
        address addr
    ) external view returns(Account memory) {
        return userAccountTable[addr];
    }

    function getAuditorAddrList() external view returns(address[] memory) {
        return auditorAddrList;
    }

    function getParam() external view returns(Param memory) {
        return param;
    }

    /// #if_succeeds {:msg "G1: Only SP may register files"} msg.sender == spAddr;
    /// #if_succeeds {:msg "G3: XXX"} old(fileIndexTable[hashVal].creator) == address(0) ==> owner == fileIndexTable[hashVal].creator;
    /// #if_succeeds {:msg "G3: XXX"} old(fileIndexTable[hashVal].splitNum) == 0 ==> splitNum == fileIndexTable[hashVal].splitNum;
    function registerFile(
        bytes32 hashVal,
        uint32 splitNum,
        address owner
    ) external spOnly() {
        require(splitNum > 0, "invalid split num");
        require(fileIndexTable[hashVal].creator == address(0), "Duplicate registration");

        fileIndexTable[hashVal].splitNum = splitNum;
        fileIndexTable[hashVal].creator = owner;
        userAccountTable[owner].fileList.push(hashVal);

        emit EventRegisterFile(owner, hashVal, splitNum);
    }

    function searchFile(bytes32 hashVal) external view returns(FileProperty memory) {
        return fileIndexTable[hashVal];
    }

    function getFileList(address owner) external view returns(bytes32[] memory) {
        uint256 fileListLength = userAccountTable[owner].fileList.length;
        bytes32[] memory fileList = new bytes32[](fileListLength);
        for(uint256 i = 0; i < userAccountTable[owner].fileList.length; i++) {
            fileList[i] = userAccountTable[owner].fileList[i];
        }
        return fileList;
    }

    /// #if_succeeds {:msg "G1: Only SP may append owners"} msg.sender == spAddr;
    function appendOwner(
        bytes32 hashVal,
        address owner
    ) external spOnly() {
        require(fileIndexTable[hashVal].splitNum > 0, "invalid file");

        userAccountTable[owner].fileList.push(hashVal);

        emit EventAppendOwner(owner, hashVal);
    }

    /// #if_succeeds {:msg "G1: Caller must exist in userAccountTable"} userAccountTable[msg.sender].pubKey.length > 0;
    /// #if_succeeds {:msg "G5: Stage must be WaitingProof"} auditingLogTable[hashVal][auditingLogTable[hashVal].length - 1].stage == Stages.WaitingProof;
    function setChal(
        bytes32 hashVal,
        bytes calldata chal
    ) external suOnly() {
        uint256 size = auditingLogTable[hashVal].length;
        if (size > 0) {
            uint256 pos = size - 1;
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

        emit EventSetChal(hashVal);
    }

    /// #if_succeeds {:msg "G1: Only SP may set proof"} msg.sender == spAddr;
    /// #if_succeeds {:msg "G5: Stage must have been WaitingProof"} old(auditingLogTable[hashVal][auditingLogTable[hashVal].length - 1].stage) == Stages.WaitingProof;
    /// #if_succeeds {:msg "G5: Stage must be WaitingResult"} auditingLogTable[hashVal][auditingLogTable[hashVal].length - 1].stage == Stages.WaitingResult;
    function setProof(
        bytes32 hashVal,
        bytes calldata proof
    ) external spOnly() {
        uint256 size = auditingLogTable[hashVal].length;
        require(size > 0, "Missing challenge");
        uint256 pos = size - 1;
        require(auditingLogTable[hashVal][pos].stage == Stages.WaitingProof, "Not WaitingProof");

        auditingLogTable[hashVal][pos].proof = proof;
        auditingLogTable[hashVal][pos].stage = Stages.WaitingResult;

        emit EventSetProof(hashVal);
    }

    function getLatestAuditingLog(bytes32 hashVal) external view returns(AuditingLog memory) {
        uint256 size = auditingLogTable[hashVal].length;
        require(size > 0, "No data");
        uint256 pos = size - 1;
        return auditingLogTable[hashVal][pos];
    }

    /// #if_succeeds {:msg "G1: Only TPA may set auditing result"} isAuditor(msg.sender);
    /// #if_succeeds {:msg "G4: XXX"} auditingLogTable[hashVal].length > 1 ==> auditingLogTable[hashVal][auditingLogTable[hashVal].length - 2].date < block.timestamp;
    /// #if_succeeds {:msg "G5: Stage must have been WaitingResult"} old(auditingLogTable[hashVal][auditingLogTable[hashVal].length - 1].stage) == Stages.WaitingResult;
    /// #if_succeeds {:msg "G5: Stage must be DoneAuditing now"} auditingLogTable[hashVal][auditingLogTable[hashVal].length - 1].stage == Stages.DoneAuditing;
    function setAuditingResult(
        bytes32 hashVal,
        bool result
    ) external tpaOnly() {
        uint256 size = auditingLogTable[hashVal].length;
        require(size > 0, "Missing proof");
        uint256 pos = size - 1;
        require(auditingLogTable[hashVal][pos].stage == Stages.WaitingResult, "Not WaitingResult");

        if (pos > 0) {
            uint256 tail = pos - 1;
            require(auditingLogTable[hashVal][tail].date < block.timestamp, "timestamp error");
        }

        auditingLogTable[hashVal][pos].result = result;
        auditingLogTable[hashVal][pos].date = block.timestamp;
        auditingLogTable[hashVal][pos].stage = Stages.DoneAuditing;

        emit EventSetAuditingResult(hashVal, result);
    }

    function getAuditingLogs(bytes32 hashVal) external view returns(AuditingLog[] memory) {
        return auditingLogTable[hashVal];
    }

    function _auditorContains(address addr) internal view returns(bool) {
        uint256 len = auditorAddrList.length;
        for (uint256 i = 0; i < len; i++) {
            if (auditorAddrList[i] == addr) {
                return true;
            }
        }
        return false;
    }
}
