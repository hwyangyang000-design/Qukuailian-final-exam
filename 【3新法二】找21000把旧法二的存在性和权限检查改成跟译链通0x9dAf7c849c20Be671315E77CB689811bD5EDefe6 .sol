// SPDX-License-Identifier: MIT
pragma solidity ^0.8.20;

contract ERC721WithLicense {

    string public name = "CopyrightToken";
    string public symbol = "CRT";

    mapping(uint256 => address) private _owners;
    mapping(address => uint256) private _balances;

    uint256 private _nextTokenId;
    uint256 public licenseCount;

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
        address licensor;
        address licensee;
        string region;
        string usage;
        bool exclusive;
        uint256 startDate;
        uint256 endDate;
        bool isActive;
    }

    event WorkRegistered(uint256 indexed tokenId, address indexed author, string title, bytes32 contentHash);
    event LicenseGranted(uint256 indexed tokenId, uint256 indexed licenseId, address indexed licensee, bool exclusive);
    event LicenseRevoked(uint256 indexed tokenId, uint256 indexed licenseId);

    mapping(uint256 => WorkMetadata) private _works;
    mapping(uint256 => License) public licenses;
    mapping(uint256 => uint256[]) public workLicenses;

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
            uint256[] storage existingLicenses = workLicenses[tokenId];
            for (uint i = 0; i < existingLicenses.length; i++) {
                License storage lic = licenses[existingLicenses[i]];
                if (lic.isActive && lic.exclusive) {
                    revert("Exclusive license already exists for this work");
                }
            }
        }

        uint256 newLicenseId = licenseCount + 1;
        uint256 endDate = durationDays == 0 ? 0 : block.timestamp + (durationDays * 1 days);

        licenses[newLicenseId] = License({
            tokenId: tokenId,
            licensor: msg.sender,
            licensee: licensee,
            region: region,
            usage: usage,
            exclusive: exclusive,
            startDate: block.timestamp,
            endDate: endDate,
            isActive: true
        });

        workLicenses[tokenId].push(newLicenseId);
        licenseCount = newLicenseId;

        emit LicenseGranted(tokenId, newLicenseId, licensee, exclusive);
        return newLicenseId;
    }

    function revokeLicense(uint256 tokenId, uint256 licenseId) external {
        License storage lic = licenses[licenseId];
        require(lic.licensor == msg.sender, "Only licensor can revoke");
        require(lic.isActive, "License already revoked");
        lic.isActive = false;
        emit LicenseRevoked(tokenId, licenseId);
    }

    function getLicenseCount(uint256 tokenId) external view returns (uint256) {
        return workLicenses[tokenId].length;
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