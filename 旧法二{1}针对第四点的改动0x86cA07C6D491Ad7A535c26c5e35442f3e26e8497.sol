// SPDX-License-Identifier: MIT
pragma solidity ^0.8.20;

contract ERC721WithLicense {

    string public name = "CopyrightToken";
    string public symbol = "CRT";

    mapping(uint256 => address) private _owners;
    mapping(address => uint256) private _balances;

    uint256 private _nextTokenId;

    struct WorkMetadata {
        string title;
        string sourceRef;
        string translationCID;
        bytes32 contentHash;
        string sourceLang;
        string targetLang;
        uint256 parentWorkId;
        uint256 timestamp;
    }

    struct License {
        uint256 tokenId;
        address licensee;
        string region;
        string usage;
        bool exclusive;
        uint256 duration;
        uint256 startTime;
        bool revoked;
    }

    event WorkRegistered(uint256 indexed tokenId, address indexed author, string title, bytes32 contentHash);
    event LicenseGranted(uint256 indexed tokenId, uint256 indexed licenseId, address indexed licensee, bool exclusive);
    event LicenseRevoked(uint256 indexed tokenId, uint256 indexed licenseId);

    mapping(uint256 => WorkMetadata) private _works;
    mapping(uint256 => License[]) private _licenses;

    function mintWithMetadata(
        string memory _title,
        string memory _sourceRef,
        string memory _translationCID,
        bytes32 _contentHash,
        string memory _sourceLang,
        string memory _targetLang,
        uint256 _parentWorkId
    ) external returns (uint256) {
        uint256 tokenId = _nextTokenId++;
        _owners[tokenId] = msg.sender;
        _balances[msg.sender]++;
        _works[tokenId] = WorkMetadata({
            title: _title,
            sourceRef: _sourceRef,
            translationCID: _translationCID,
            contentHash: _contentHash,
            sourceLang: _sourceLang,
            targetLang: _targetLang,
            parentWorkId: _parentWorkId,
            timestamp: block.timestamp
        });
        emit WorkRegistered(tokenId, msg.sender, _title, _contentHash);
        return tokenId;
    }

    function verifyIntegrity(uint256 tokenId, bytes32 hashToVerify) external view returns (bool) {
        require(_owners[tokenId] != address(0), "Token not exist");
        return _works[tokenId].contentHash == hashToVerify;
    }

    function grantLicense(
        uint256 tokenId,
        address licensee,
        string memory region,
        string memory usage,
        bool exclusive,
        uint256 durationDays
    ) external returns (uint256) {
        require(_owners[tokenId] != address(0), "Token not exist");
        require(msg.sender == ownerOf(tokenId), "Not owner");
        require(licensee != address(0), "Invalid licensee address");

        if (exclusive) {
            for (uint i = 0; i < _licenses[tokenId].length; i++) {
                if (!_licenses[tokenId][i].revoked && _licenses[tokenId][i].exclusive) {
                    revert("Exclusive license already exists");
                }
            }
        }

        uint256 licenseId = _licenses[tokenId].length;
        _licenses[tokenId].push(License({
            tokenId: tokenId,
            licensee: licensee,
            region: region,
            usage: usage,
            exclusive: exclusive,
            duration: durationDays,
            startTime: block.timestamp,
            revoked: false
        }));

        emit LicenseGranted(tokenId, licenseId, licensee, exclusive);
        return licenseId;
    }

    function revokeLicense(uint256 tokenId, uint256 licenseId) external {
        require(msg.sender == ownerOf(tokenId), "Not owner");
        require(licenseId < _licenses[tokenId].length, "License not exist");
        require(!_licenses[tokenId][licenseId].revoked, "Already revoked");
        _licenses[tokenId][licenseId].revoked = true;
        emit LicenseRevoked(tokenId, licenseId);
    }

    function getLicenseCount(uint256 tokenId) external view returns (uint256) {
        return _licenses[tokenId].length;
    }

    function ownerOf(uint256 tokenId) public view returns (address) {
        address owner = _owners[tokenId];
        require(owner != address(0), "Token does not exist");
        return owner;
    }

    function balanceOf(address owner) public view returns (uint256) {
        return _balances[owner];
    }
}