// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import "@openzeppelin/contracts/token/ERC20/ERC20.sol";
import "@openzeppelin/contracts/access/Ownable.sol";
import "@openzeppelin/contracts/utils/Address.sol";

contract BiToken is ERC20, Ownable {
    using Address for address;
    uint256 public maxBalanceAmount;

    constructor() ERC20("BiToken", "BT") {
        maxBalanceAmount = 10 ** 6 * 10 ** 18;
        _mint(_msgSender(), 100 * 10**9 * 10**18); // 100B token
        emit Transfer(address(0), _msgSender(), 100 * 10**9 * 10**18);
    }

    function setMaxBalanceAmount(uint256 _maxBalanceAmount) external onlyOwner {
        maxBalanceAmount = _maxBalanceAmount;
    }

    function mint(uint256 _amount) external {
        require(balanceOf(_msgSender()) + _amount <= maxBalanceAmount, "BiToken: Require balance less than maxBalanceAmount");
        _mint(_msgSender(), _amount);
        emit Transfer(address(0), _msgSender(), _amount);
    }


}
