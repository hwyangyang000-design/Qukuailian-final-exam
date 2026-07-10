// SPDX-License-Identifier: MIT
pragma solidity ^0.8.20;

/**
 * @title ERC721Compare
 * @notice 标准ERC-721 NFT合约，用于与TranslationCopyright做Gas对比
 * 
 * 对比目的：证明针对翻译版权场景优化的数据结构，
 * 比通用ERC-721 NFT方案在存储效率和Gas成本上更优
 */

// 最小化ERC-721实现（仅mint + tokenURI + 存储元数据）
contract ERC721Compare {

    string public name = "TranslationNFT";
    string public symbol = "TNFT";

    mapping(uint256 => address) private _owners;
    mapping(address => uint256) private _balances;
    mapping(uint256 => string) private _tokenURIs;
    
    // ERC-721标准：每个token单独存储metadata URI
    // 而TranslationCopyright将结构化数据直接上链
    mapping(uint256 => TokenMetadata) private _metadata;
    
    struct TokenMetadata {
        string title;
        string sourceRef;
        string translationCID;
        bytes32 contentHash;
        string sourceLang;
        string targetLang;
        uint256 parentWorkId;
        uint256 timestamp;
    }

    uint256 private _nextTokenId = 1;

    function mint(
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

        _tokenURIs[tokenId] = _translationCID;
        
        _metadata[tokenId] = TokenMetadata({
            title: _title,
            sourceRef: _sourceRef,
            translationCID: _translationCID,
            contentHash: _contentHash,
            sourceLang: _sourceLang,
            targetLang: _targetLang,
            parentWorkId: _parentWorkId,
            timestamp: block.timestamp
        });

        return tokenId;
    }

    function ownerOf(uint256 tokenId) public view returns (address) {
        address owner = _owners[tokenId];
        require(owner != address(0), "Token does not exist");
        return owner;
    }

    function balanceOf(address owner) public view returns (uint256) {
        return _balances[owner];
    }

    function tokenURI(uint256 tokenId) public view returns (string memory) {
        require(_owners[tokenId] != address(0), "Token does not exist");
        return _tokenURIs[tokenId];
    }

    function getMetadata(uint256 tokenId) public view returns (
        string memory title,
        string memory sourceRef,
        string memory translationCID,
        bytes32 contentHash,
        string memory sourceLang,
        string memory targetLang,
        uint256 parentWorkId,
        uint256 timestamp
    ) {
        require(_owners[tokenId] != address(0), "Token does not exist");
        TokenMetadata memory m = _metadata[tokenId];
        return (m.title, m.sourceRef, m.translationCID, m.contentHash, m.sourceLang, m.targetLang, m.parentWorkId, m.timestamp);
    }

    function totalSupply() public view returns (uint256) {
        return _nextTokenId - 1;
    }
}
