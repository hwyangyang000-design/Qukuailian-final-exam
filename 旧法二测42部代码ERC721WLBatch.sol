// SPDX-License-Identifier: MIT
pragma solidity ^0.8.20;

interface IERC721WL {
    function mintWithMetadata(string memory,string memory,string memory,bytes32,string memory,string memory,uint256) external returns (uint256);
}

contract ERC721WLBatchA {
    IERC721WL public nft;
    constructor(address _nft) { nft = IERC721WL(_nft); }

    function wl1() external {
        nft.mintWithMetadata(unicode"傲慢与偏见（王科一译）","9787532751211","bafybeifwvx6xxfstbxyeef27ri2cdjzthzn5xdyfi4ffdua2dnkbowkr74",0x68e512c77f9c732a16e235e4f794c0f100b4e526148f044534c69332f5dcd763,"EN","ZH",0);
        nft.mintWithMetadata(unicode"简·爱（祝庆英译）","9787532751136","bafybeihbdweo2zgkxmgn3d2cvgxax7r3llh5t635lmceorublqn4tmibnu",0xebb5a0f1801b50988d8e0dd14cca188876d845d350ed560f9c0586d344703f22,"EN","ZH",0);
        nft.mintWithMetadata(unicode"呼啸山庄（祝庆英译）","9787532751198","bafybeihtnuqd72k64zy66efuir7fbfuxguamsuewyrsigmdvtlwlsnbrye",0x4ac0871453fd0c5ebc08ecca63e89e0965c02738fa755d36aad8652e7d2b19a0,"EN","ZH",0);
        nft.mintWithMetadata(unicode"鲁滨孙历险记（黄杲炘译）","9787532778263","bafybeibjw34f6kvwna5js6tnlypsncgezavxjx24vmavug7ucagy7stm3e",0x11f931baff40f4611628378207bea21dbd91befb94bcfb64ee9d868a1a4405ea,"EN","ZH",0);
        nft.mintWithMetadata(unicode"格列佛游记（张健译）","9787532752553","bafybeihyvcnv3tx3gaa27ll2ru7xqk4kqj7cp46dlzu4mjvh56lyak3gjy",0x8576f58ebebd218cd1db8773bfcc79bae16e5e5698f5d814170362e80fc05e12,"EN","ZH",0);
        nft.mintWithMetadata(unicode"金银岛·化身博士（荣如德译）","9787532778225","bafybeifpzd43xf3734pltve5si3atgk5ioszmv3psmqddu2gchoqywoxsi",0x7fd3f755dc545678e5f9390e4482672cba44dc6f66be1fdae629a4f29b400d0d,"EN","ZH",0);
        nft.mintWithMetadata(unicode"福尔摩斯探案精选（荣如德译）","9787532778270","bafybeidbmb54vz7akycrfwvcb2hzbsy4rymy4ccne5u5eadmx2pueumx54",0x69296bf317781ced7cea96a500fc7a093756ea81698cf504e3b31770caa277e7,"EN","ZH",0);
        nft.mintWithMetadata(unicode"动物农场（荣如德译）","9787532778324","bafkreicdj7u2ws5y52xlrakjku2kdmklki6af3cbu7bi3d5hhlmzbdeiae",0x434fe9ab4bb8eeaeb881495534a1b14b523c02ec41a7c28d8fa73ad9908c8801,"EN","ZH",0);
        nft.mintWithMetadata(unicode"一九八四（董乐山译）","9787532778034","bafybeihdjxqnbrqvzalyraxenwhec7c64c55uf5layp6gbkqkfgprh62nm",0x3a98f77a1656eda34a7025aef5571f5722a2d8bcad18ee5304b37a7c062c23b4,"EN","ZH",0);
        nft.mintWithMetadata(unicode"月亮与六便士（傅惟慈译）","9787532753741","bafybeidgc4yj4zpvsgswlexugjyfn47sdxinns6oz45e6oc4je3odfq5qu",0x086edbf7c7375e46a88354d6661cee19afbd92e258361eec512e4a6fed9f15c6,"EN","ZH",0);
        nft.mintWithMetadata(unicode"红与黑（郝运译）","9787532751228","bafybeiatchn2vbu7aflt35dq5isk3lsv34cgzmzu37ijzh7vo3wvaln4pa",0x168c015c5ea96abd8a11a739f93a98ce47a3779e7bf043faf24b4a6f1c820ea7,"FR","ZH",0);
        nft.mintWithMetadata(unicode"巴黎圣母院（管震湖译）","9787532778133","bafybeiga4zqgqgaen2teojfvti7u6sandyt64gzusguwyyr5zx35fflznq",0x708ad31e0a7d9894a90956c5ebc53ec0f406adc0a663e6edc3ea6b6377d3ba29,"FR","ZH",0);
    }
}

contract ERC721WLBatchB {
    IERC721WL public nft;
    constructor(address _nft) { nft = IERC721WL(_nft); }

    function wl2() external {
        nft.mintWithMetadata(unicode"茶花女（王振孙译）","9787532777990","bafybeif5tl4sstn6x4rh6jg5d4oub6feu4sl6lgwg4zyx5yytl7rdn4pri",0x95c7d969f19f47cb433beaf5cc09b0293cdd0f605ddf1cbe94c45a3bcbf1ccdd,"FR","ZH",0);
        nft.mintWithMetadata(unicode"海底两万里（沈国华译）","9787532778171","bafybeicg37gitty6cjjsxetxok2wz4mqh5apmxb3bll3i5fsydmzjbh4lq",0xdd2b212fb79a5174aadb7cf555007b0080a85b9dbc7000bb83d793cacdf8efea,"FR","ZH",0);
        nft.mintWithMetadata(unicode"局外人（柳鸣九译）","9787532778072","bafkreidsyld5lm55ygqlp32twdc7p5mpken7wqq6t5gijgp3pcnsmbpbqe",0x72c2c7d5b3bdc1a0b7ef53b0c5f7f58f511bfb421e9f4c8499fb789b2605e181,"FR","ZH",0);
        nft.mintWithMetadata(unicode"包法利夫人（周克希译）","9787532784721","bafybeige5rjbqgcm7tvbu4e55huffy2tr5lqtufsy47lvk75eaywtcaase",0x9209d81a5c88d2379fbf8435b622f372f734ef748627ead65888258f00439258,"FR","ZH",0);
        nft.mintWithMetadata(unicode"基督山伯爵（韩沪麟、周克希译）","9787532751242","bafybeidl6npz27ferekfx6gzpos77wdrourkoohvkjkxt6w5w5vjztd4dq",0xd7bdc73179d6bb96fc56b49d1d22472e96233c0deacc4a0066f11847511a8c7f,"FR","ZH",0);
        nft.mintWithMetadata(unicode"乱世佳人（陈良廷译）","9787532778287","bafybeiaohn4u7sefjxchmwdkwjkab5eqgcxvwup5djzv43scuv4exkbqqy",0xbd3e6feee2fc871e33e5d81caa206a9d063f911728a74ddc209116a7ee96193d,"FR","ZH",0);
        nft.mintWithMetadata(unicode"安娜·卡列尼娜（高莽译）","9787532785469","bafybeife67uomnzje54a5pqojqev5yjf7gfi6owrx52m2fbdzvu2px2sxa",0xf20511ab5b3bf7b5a08e4dbb07d8ce10d495820bd143e948c1fb20d61ab90cdb,"RU","ZH",0);
        nft.mintWithMetadata(unicode"罪与罚（岳麟译）","9787532778188","bafybeihzlvd5vxnyjfwbgx5p6onhmj56ichjli6xjcwfyfrk5xqzdzvbqm",0xa4ef41b22a5a5c684dad9cca28aa3df850f2a0f0f6ea1ce57945822709ba0b00,"RU","ZH",0);
        nft.mintWithMetadata(unicode"猎人笔记（冯春译）","9787532753529","bafybeihpvlgpzlm4fecwvizkbif3vbgpdniz5roravgwxp3i6sb4oktm3m",0xa8be620bc37a36781dfda5264d350f48807e068eaee11c29ef0cb4a2dac0cfd3,"RU","ZH",0);
        nft.mintWithMetadata(unicode"少年维特的烦恼（侯浚吉译）","9787532778164","bafkreif5o64mkh5ybihd5rd5hagmz36j2mgukp2v6x4n4t53sbagocbpzi",0xbd77c8b51fb80a0e3ec47d380cccefc9d30d453f55f5f8de4fbb904067082fca,"DE","ZH",0);
        nft.mintWithMetadata(unicode"老人与海（吴劳译）","9787532751167","bafkreiabkvlbjozpggt7mla6jvw764k2xdxdu5hsblmkwmzirecgr3jnj4",0x72c2c7d5b3bdc1a0b7ef53b0c5f7f58f511bfb421e9f4c8499fb789b2605e181,"EN","ZH",0);
        nft.mintWithMetadata(unicode"瓦尔登湖（徐迟译）","9787532778027","bafybeic566jtrtfrblhypacz2tnkbhjkwfndqtck7rj54x2jlbvfctuswy",0x1ab74aed5b12062a3233219d7f03500297d01e48a958f9cf51a1bb558c3aadc0,"EN","ZH",0);
    }

    function wl3() external {
        nft.mintWithMetadata(unicode"浮士德（钱春绮译）","9787532778249","bafybeicksqqblwiooemp46likb3ewq33ygxrmwewhaerxef5kbxklzm33a",0x27b4a99721e86c2fcdc64ccfbb3607455b96efdc93cfa762a8d663463ebea5a0,"DE","ZH",0);
        nft.mintWithMetadata(unicode"变形记（张荣昌译）","9787532778010","bafybeih3nmxjniu6ado3s7tsktaskafsfyrnvqygbzatfrkotyjo7tojaq",0x95c7d969f19f47cb433beaf5cc09b0293cdd0f605ddf1cbe94c45a3bcbf1ccdd,"DE","ZH",0);
        nft.mintWithMetadata(unicode"罗生门（林少华译）","9787532751495","bafkreiajajjbrybmsh3cbnrfugh3k2smtsmedjsddwkuw6u5vmvak2ai44",0x09025218e02c91f620b625a18fb56a4c9c9841a6431d954b7a9dab2a056808e7,"JA","ZH",0);
        nft.mintWithMetadata(unicode"我是猫（刘振泉译）","9787532778003","bafybeiapuntipyzfqjuqgvrib4licwuwhtli4aar6t4jzeqfkvz3e3lw3u",0xa038de76f1a475b652c07d359a8375a7b60c1c20a5dd63af480648b6adab2453,"JA","ZH",0);
        nft.mintWithMetadata(unicode"爱的教育（徐调孚、王独清译）","9787532749027","bafybeihzq4a7a4h4ggjbbuuispuqy27sovfowd5utwsaraycngwme76zvi",0x02eff22752bdbf7f0ad63517b5c077ee37dffb26f414d7b9b4fd483b6e2324c1,"IT","ZH",0);
        nft.mintWithMetadata(unicode"荷马史诗（陈中梅译）","9787532778331","bafybeief4vkz4vb6brpazu54wyg3cztcrszplvk66cfadz3wgaikae5mqi",0xfc76c864941871f21434b24773e705d182da3c110157a129d75c39afaf1728ad,"EL","ZH",0);
        nft.mintWithMetadata(unicode"泰戈尔诗选（吴岩译）","9787532758272","bafybeigottmyenuk3z5vz2ain7wuz3d5zf2m44435goesuch2zd3c56iaa",0xc333e60e26cf9a011167adaffab29e6336e83936e56b768413065cbf4eb14d0d,"HI","ZH",0);
        nft.mintWithMetadata(unicode"小王子（周克希译）","9787532778232","bafkreiahzs3bae3syfpx4qgm4ohh463r4nhmyocqpvuozw7q5ghy5zezy4",0x07ccb6101372c15f7e40cce38e7e7b71e34ecc38507d68ecdbf0e98f8ee499c7,"FR","ZH",0);
        nft.mintWithMetadata(unicode"雾都孤儿（荣如德译）","9787532778126","bafybeicn2qlakisde5cmjthyu7jxhnazhezonwbx4wljqqq4xbfu45otum",0xce48053bee01a504455c67a50e0fdcbfadba0b9754d7489b98b719432135bc95,"EN","ZH",0);
        nft.mintWithMetadata(unicode"牛虻（蔡慧译）","9787532778317","bafybeihhyzfsufybumhbws3itk3gpmtd7ghtjylspiccfjobjurf7t3idi",0xa4df4a7fdcc17966e9d6ef4d060628924ce953d4807eb72b19d7701ffef799c6,"EN","ZH",0);
        nft.mintWithMetadata(unicode"蝇王（龚志成译）","9787532778096","bafybeicidjvkgf743foow6gefm3anhwcuv7xww45vbns7wcelziqjfyxzu",0x4821885f2c62e82a241fd3de87864cd99467d2d6460c79dd471b06a4fd022d2c,"EN","ZH",0);
        nft.mintWithMetadata(unicode"悉达多（张佩芬译）","9787532778256","bafkreihu2rvowanv3qmuigydlkfxnn3duxa3jzfieaifyesghxwcvvh3ni",0xf4d46aeb01b5dc19441b035a8b76b763a5c1b4e4a820105c12463dec2ad4fb6a,"DE","ZH",0);
    }

    function wl4() external {
        nft.mintWithMetadata(unicode"了不起的盖茨比（巫宁坤译）","9787532753598","bafybeigzdqdvcapmi3mwjzdxzcyzgze4cg5gpoxs7iy5b6icrvnhb5ug6m",0xbcad857cca4a1f1cf301a78afebb9ded6ec3a4c4e04e95bc70cf14e9899e4a20,"EN","ZH",0);
        nft.mintWithMetadata(unicode"情人（王道乾译）","9787532778065","bafkreiatgqwtbwbne3uwps7da2l77co527b426jcagi5rbpl2uyphbwyra",0x13342d30d82d26e967cbe30697ff89ddd7c3cd79220191d885ebd530f386d888,"FR","ZH",0);
        nft.mintWithMetadata(unicode"莎士比亚四大悲剧（方平译）","9787532784646","bafybeidc6crjsfxmxawjw3y54jevxkabynuv3k5yhw3w7s2oslq322ek7u",0x6ce2f0c27afa5793228c08c8a0aceac6ea6e6df81fee085d6454e912bf325b8c,"EN","ZH",0);
        nft.mintWithMetadata(unicode"最后一片叶子（黄源深译）","9787532752379","bafybeidgc4yj4zpvsgswlexugjyfn47sdxinns6oz45e6oc4je3odfq5qu",0x6a4447f4490164f16d8d80c432c543c58d17521dfc0cd8429a92ad8a1357b5ff,"EN","ZH",0);
        nft.mintWithMetadata(unicode"周作人译文全集第一卷","9787208151352","bafybeia2geoang7lj7fkdqve2uhdd55w7pccxnynfdutn6zykthpxxyzzm",0x622dad218b90e42982f92abc1890554026785138efd7c053894fe7ba77e25c8b,"JA","ZH",0);
        nft.mintWithMetadata(unicode"莎士比亚合集（朱生豪译）","9787514907070","bafybeibo5n5sexi5gja2sj3x64zd7arr3iqlidk4dekhzhplrpz5kzegoy",0x4b4cf44e6aa3b1630adc506f2760402689d0e088ba8afcd6bcdd033d3ac420d4,"EN","ZH",0);
    }
}