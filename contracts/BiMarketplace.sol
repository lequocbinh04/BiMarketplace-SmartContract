// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import "@openzeppelin/contracts/access/Ownable.sol";
import "@openzeppelin/contracts/utils/Counters.sol";
import "@openzeppelin/contracts/token/ERC721/ERC721.sol";
import "@openzeppelin/contracts/token/ERC20/ERC20.sol";

contract BiMarketplace is Ownable {
    using Counters for Counters.Counter;    
    Counters.Counter private _orderIdCount;
    struct Order {
        address seller;
        address buyer;
        uint256 price;
        uint256 tokenId;
        ERC20 paymentToken;
    }

    ERC721 nftContract;
    address feeRecipient;
    ERC20 paymentToken;
    uint256 public fee;
    uint256 public feePremium;

    mapping(uint256 => Order) orders;

    constructor(){
        nftContract = ERC721(0x4779794D08d60F73F80EAEaC8A4891033b979342);
        paymentToken = ERC20(0xcE40aBB392db6ab6D058ecceE2203FAA1Db8a8B8);
        _orderIdCount.increment();
        feeRecipient = _msgSender();
        fee = 7; // 7% / transaction
        feePremium = 5; // 5% / transaction (if hold > 1000BT)
    }
    function setNftContract(address _nftAddress) external onlyOwner {
        nftContract = ERC721(_nftAddress);
    }
    function setFeeRecipient(address _feeRecipient) external onlyOwner {
        feeRecipient = _feeRecipient;
    }
    function setFee(uint256 _fee) external onlyOwner {
        fee = _fee;
    }
    function setFeePremium(uint256 _feePremium) external onlyOwner {
        feePremium = _feePremium;
    }
    function setPaymentToken(address _paymentToken) external onlyOwner {
        paymentToken = ERC20(_paymentToken);
    }

    function addOrder(uint256 _tokenId, uint256 _price) external {
        require(nftContract.ownerOf(_tokenId) == _msgSender(), "BiMarketplace: Require token owner is msg.sender");
        require(
            nftContract.getApproved(_tokenId) == address(this) ||
            nftContract.isApprovedForAll(_msgSender(), address(this)),
            "BiMarketplace: The contract not have permission to manage this token"
        );
        require(_price > 0, "BiMarketplace: Require price > 0");
        uint256 _orderId = _orderIdCount.current();
        Order storage _order = orders[_orderId];
        _order.seller = _msgSender();
        _order.buyer = address(0);
        _order.tokenId = _tokenId;
        _order.paymentToken = paymentToken;
        _order.price = _price;
        _orderIdCount.increment();
        nftContract.transferFrom(_msgSender(), address(this), _tokenId);
    }




}