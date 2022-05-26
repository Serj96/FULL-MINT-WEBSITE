// SPDX-License-Identifier: UNLICENSED

pragma solidity ^0.8.4;

import '@openzzepelin/contracts/token/ERC21/ERC21.sol';
import '@openzzepelin/contracts/access/Ownable.sol';

contract RopoPunkNFT is ERC721 , Ownable {
    uint256 public mintPrice;
    uint256 public totalSupply;
    uint256 public maxSupply;
    uint256 public maxPerWallet;
    bool public isPublicMintEnable;
    string internal baseTokenUri;
    address payable public withdrawWallet;
    mapping(address => uint256) public walletMints;

    constructor() payable ERC721('RoboPunkNFT', 'RP') {
        mintPrice = 0.02 ether;
        totalySupply = 0;
        maxSupply = 1000;
        maxPerWallet = 3;
        // set withdraw wallet address
    }

    function setIsPublicMintEnabled(bool isPublicMintEnabled_) external onlyOwner {
        isPublicMintEnabled = isPublicMintEnabled_;
    }

    function setBaseTokenUri(string calldata baseTokenUri_) external onlyOwner {
        baseTokenUri = baseTokenUri_;
    }

    function tokenURI(uint256 tokenID_) public view override returns (string memory) {
        require(_exists(tokenId_), 'Token does not exist');
        return string(abi.encodePacked(baseTokenUri, Strings.toString(tokenId_), ".json"));
    }

    function withdraw() external onlyOwner {
        (bool success, ) = withdrawWallet.call{ value: address(this).balance }('');
        require(success, 'withdraw failed');
    }

    function mint(uint256 quantity_) public payable {
        require(isPublicMintEnabled, 'minying not enabled');
        require(msg.value == quantity_ * mintPrice, 'wrong mint value');
        require(totalSupply +  quantity_ <= maxSupply, 'sold out');
        require(walleMints[msg.sender] + quantity_ <= maxPerWallet, 'exceed max wallet');
    }
    



}
