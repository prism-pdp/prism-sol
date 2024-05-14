// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.13;

contract Registry {
    address public sp;
    address public tpa;
    Para public para;
    mapping(string => FileIndex) private fileIndexTable;

    struct Para {
        string pairing;
        bytes u;
        bytes g;
    }

    struct FileIndex {
        address[] owners; // Owner list
    }

    constructor(
        string memory _pairing,
        bytes memory _g,
        bytes memory _u,
        address _sp,
        address _tpa
    )
    {
        para.pairing = _pairing;
        para.u = _u;
        para.g = _g;
        sp = _sp;
        tpa = _tpa;
    }

    function getPara() public view returns(Para memory) {
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
}