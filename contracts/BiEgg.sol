// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import "@openzeppelin/contracts/access/Ownable.sol";
import "@openzeppelin/contracts/token/ERC20/ERC20.sol";
import "@openzeppelin/contracts/utils/Counters.sol";
import "./BiHero.sol";


contract BiEgg is Ownable {
    using Counters for Counters.Counter;

    mapping(address => uint) public totalEggs;
    Counters.Counter private _tokenIdCount;
    uint256 private _pricePerEgg;
    ERC20 private _payableToken;
    BiHero private _nftToken;

    event BuyEgg(address indexed receiver, ERC20 indexed _payableToken, uint256 indexed price);
    event OpenEgg(address indexed receiver, uint256 indexed _tokenId);

    constructor(address payableToken, address nftToken) {
        _pricePerEgg = 1000 * 10 ** 18; // 1,000 BiToken for one egg
        _payableToken = ERC20(payableToken);
        _nftToken = BiHero(nftToken);
    }

    function setPayableToken(address _newTokenContract) external onlyOwner {
        _payableToken = ERC20(_newTokenContract);
    }

    function setNftToken(address _newTokenContract) external onlyOwner {
        _nftToken = BiHero(_newTokenContract);
    }

    function setPricePerEgg(uint256 _newPrice) external onlyOwner {
        _pricePerEgg = _newPrice;
    }

    function buyEgg() external {
        require(_msgSender() != address(0), "BiEgg: sender is not allowed to be 0");
        require(_payableToken.balanceOf(_msgSender()) >= _pricePerEgg, "BiEgg: sender does not have enough BiToken");
        require(_payableToken.allowance(_msgSender(), address(this)) >= _pricePerEgg, "BiEgg: sender does not have enough allowance");
        require(_payableToken.transferFrom(_msgSender(), owner(), _pricePerEgg), "BiEgg: failed to transfer BiToken");
        totalEggs[_msgSender()] = totalEggs[_msgSender()] + 1;
        emit BuyEgg(_msgSender(), _payableToken, _pricePerEgg);
    }

    function openEgg() external {
        require(_msgSender() != address(0), "BiEgg: sender is not allowed to be 0");
        require(totalEggs[_msgSender()] > 0, "BiEgg: sender does not have any eggs");
        totalEggs[_msgSender()] = totalEggs[_msgSender()] - 1;
        _tokenIdCount.increment();
        _nftToken.mint(_msgSender(), _tokenIdCount.current());
        emit OpenEgg(_msgSender(), _tokenIdCount.current());
    }
    
}