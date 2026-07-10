// SPDX-License-Identifier: MIT
pragma solidity ^0.8.20;

/**
 * @title TranslationCopyright
 * @notice 翻译作品版权登记与授权许可智能合约
 * @dev 部署在以太坊Sepolia测试网，Gas免费
 *
 * 核心功能：
 * 1. 登记翻译作品（含翻译专属元数据：语言对、版本链、原作引用）
 * 2. 授予翻译许可（指定语言对、地域、用途、是否独家）
 * 3. 撤销许可
 * 4. 验证版权归属与文件完整性
 * 5. 翻译版本链溯源
 * 6. 版权转让
 */

contract TranslationCopyright {

    // ============ 数据结构 ============

    /// @notice 翻译作品版权记录
    struct TranslationWork {
        string title;           // 译作标题
        string sourceRef;       // 原作引用（IPFS CID 或 URL）
        string translationCID;  // 译文文件 IPFS CID
        bytes32 contentHash;    // 译文 SHA-256 哈希
        string sourceLang;      // 源语言代码，如 "EN"
        string targetLang;      // 目标语言代码，如 "ZH"
        uint256 parentWorkId;   // 上一版本ID（0表示初版）
        address author;         // 译者钱包地址
        uint256 timestamp;      // 存证时间戳
        bool exists;            // 是否存在
    }

    /// @notice 翻译许可记录
    struct License {
        uint256 workId;         // 关联作品ID
        address licensor;       // 授权人（版权持有者）
        address licensee;       // 被授权人
        string territory;       // 授权地域，如 "CN", "WORLDWIDE"
        string usageType;       // 用途类型："commercial" / "non-commercial" / "educational"
        bool isExclusive;       // 是否独家授权
        uint256 startDate;      // 授权开始时间
        uint256 endDate;        // 授权结束时间（0表示永久）
        bool isActive;          // 许可是否生效
    }

    // ============ 状态变量 ============

    uint256 public workCount;       // 作品总数
    uint256 public licenseCount;    // 许可总数

    mapping(uint256 => TranslationWork) public works;           // workId => 作品
    mapping(uint256 => License) public licenses;                // licenseId => 许可
    mapping(uint256 => uint256[]) public workVersions;          // workId => 版本链
    mapping(address => uint256[]) public authorWorks;           // author => 作品列表
    mapping(uint256 => uint256[]) public workLicenses;          // workId => 许可列表

    // ============ 事件 ============

    event WorkRegistered(uint256 indexed workId, address indexed author, string title, string sourceLang, string targetLang);
    event LicenseGranted(uint256 indexed licenseId, uint256 indexed workId, address licensee, bool isExclusive);
    event LicenseRevoked(uint256 indexed licenseId, uint256 indexed workId);
    event OwnershipTransferred(uint256 indexed workId, address indexed from, address indexed to);

    // ============ 核心功能 ============

    /**
     * @notice 登记翻译作品
     * @param _title 译作标题
     * @param _sourceRef 原作引用（IPFS CID 或 URL）
     * @param _translationCID 译文 IPFS CID
     * @param _contentHash 译文 SHA-256 哈希（bytes32）
     * @param _sourceLang 源语言代码
     * @param _targetLang 目标语言代码
     * @param _parentWorkId 上一版本ID，初版传0
     */
    function registerWork(
        string memory _title,
        string memory _sourceRef,
        string memory _translationCID,
        bytes32 _contentHash,
        string memory _sourceLang,
        string memory _targetLang,
        uint256 _parentWorkId
    ) external returns (uint256) {
        // 如果是衍生版本，验证父作品存在
        if (_parentWorkId != 0) {
            require(works[_parentWorkId].exists, "Parent work does not exist");
        }

        uint256 newWorkId = workCount + 1;

        works[newWorkId] = TranslationWork({
            title: _title,
            sourceRef: _sourceRef,
            translationCID: _translationCID,
            contentHash: _contentHash,
            sourceLang: _sourceLang,
            targetLang: _targetLang,
            parentWorkId: _parentWorkId,
            author: msg.sender,
            timestamp: block.timestamp,
            exists: true
        });

        // 维护版本链
        if (_parentWorkId != 0) {
            workVersions[_parentWorkId].push(newWorkId);
        }

        // 维护作者作品列表
        authorWorks[msg.sender].push(newWorkId);

        workCount = newWorkId;

        emit WorkRegistered(newWorkId, msg.sender, _title, _sourceLang, _targetLang);

        return newWorkId;
    }

    /**
     * @notice 授予翻译许可
     * @param _workId 作品ID
     * @param _licensee 被授权人地址
     * @param _territory 授权地域
     * @param _usageType 用途类型
     * @param _isExclusive 是否独家
     * @param _durationDays 授权天数（0表示永久）
     */
    function grantLicense(
        uint256 _workId,
        address _licensee,
        string memory _territory,
        string memory _usageType,
        bool _isExclusive,
        uint256 _durationDays
    ) external returns (uint256) {
        require(works[_workId].exists, "Work does not exist");
        require(works[_workId].author == msg.sender, "Only copyright holder can grant license");
        require(_licensee != address(0), "Invalid licensee address");

        // 如果是独家授权，检查是否已有生效的独家许可
        if (_isExclusive) {
            uint256[] storage existingLicenses = workLicenses[_workId];
            for (uint i = 0; i < existingLicenses.length; i++) {
                License storage lic = licenses[existingLicenses[i]];
                if (lic.isActive && lic.isExclusive) {
                    revert("Exclusive license already exists for this work");
                }
            }
        }

        uint256 newLicenseId = licenseCount + 1;
        uint256 endDate = _durationDays == 0 ? 0 : block.timestamp + (_durationDays * 1 days);

        licenses[newLicenseId] = License({
            workId: _workId,
            licensor: msg.sender,
            licensee: _licensee,
            territory: _territory,
            usageType: _usageType,
            isExclusive: _isExclusive,
            startDate: block.timestamp,
            endDate: endDate,
            isActive: true
        });

        workLicenses[_workId].push(newLicenseId);

        licenseCount = newLicenseId;

        emit LicenseGranted(newLicenseId, _workId, _licensee, _isExclusive);

        return newLicenseId;
    }

    /**
     * @notice 撤销许可
     * @param _licenseId 许可ID
     */
    function revokeLicense(uint256 _licenseId) external {
        License storage lic = licenses[_licenseId];
        require(lic.licensor == msg.sender, "Only licensor can revoke");
        require(lic.isActive, "License already revoked");

        lic.isActive = false;

        emit LicenseRevoked(_licenseId, lic.workId);
    }

    /**
     * @notice 验证版权归属与文件完整性
     * @param _workId 作品ID
     * @param _contentHash 待验证文件的SHA-256哈希
     * @return isOwner 调用者是否为版权持有者
     * @return hashMatch 文件哈希是否匹配
     * @return author 版权持有者地址
     * @return timestamp 存证时间
     */
    function verifyCopyright(uint256 _workId, bytes32 _contentHash)
        external view returns (bool isOwner, bool hashMatch, address author, uint256 timestamp)
    {
        TranslationWork storage work = works[_workId];
        require(work.exists, "Work does not exist");

        return (
            work.author == msg.sender,
            work.contentHash == _contentHash,
            work.author,
            work.timestamp
        );
    }

    /**
     * @notice 获取翻译版本链
     * @param _workId 作品ID
     * @return 版本ID数组
     */
    function getVersionChain(uint256 _workId) external view returns (uint256[] memory) {
        require(works[_workId].exists, "Work does not exist");
        return workVersions[_workId];
    }

    /**
     * @notice 转让版权
     * @param _workId 作品ID
     * @param _newOwner 新版权持有者地址
     */
    function transferOwnership(uint256 _workId, address _newOwner) external {
        require(works[_workId].exists, "Work does not exist");
        require(works[_workId].author == msg.sender, "Only current owner can transfer");
        require(_newOwner != address(0), "Invalid new owner address");

        address oldOwner = works[_workId].author;
        works[_workId].author = _newOwner;

        emit OwnershipTransferred(_workId, oldOwner, _newOwner);
    }

    // ============ 查询功能 ============

    /**
     * @notice 获取作品完整信息
     */
    function getWork(uint256 _workId) external view returns (
        string memory title,
        string memory sourceRef,
        string memory translationCID,
        bytes32 contentHash,
        string memory sourceLang,
        string memory targetLang,
        uint256 parentWorkId,
        address author,
        uint256 timestamp
    ) {
        TranslationWork storage work = works[_workId];
        require(work.exists, "Work does not exist");

        return (
            work.title,
            work.sourceRef,
            work.translationCID,
            work.contentHash,
            work.sourceLang,
            work.targetLang,
            work.parentWorkId,
            work.author,
            work.timestamp
        );
    }

    /**
     * @notice 获取许可完整信息
     */
    function getLicense(uint256 _licenseId) external view returns (
        uint256 workId,
        address licensor,
        address licensee,
        string memory territory,
        string memory usageType,
        bool isExclusive,
        uint256 startDate,
        uint256 endDate,
        bool isActive
    ) {
        License storage lic = licenses[_licenseId];
        require(lic.licensor != address(0), "License does not exist");

        return (
            lic.workId,
            lic.licensor,
            lic.licensee,
            lic.territory,
            lic.usageType,
            lic.isExclusive,
            lic.startDate,
            lic.endDate,
            lic.isActive
        );
    }

    /**
     * @notice 获取作者的所有作品ID
     */
    function getAuthorWorks(address _author) external view returns (uint256[] memory) {
        return authorWorks[_author];
    }

    /**
     * @notice 获取作品的所有许可ID
     */
    function getWorkLicenses(uint256 _workId) external view returns (uint256[] memory) {
        return workLicenses[_workId];
    }
}
