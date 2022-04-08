// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import "@openzeppelin/contracts/access/Ownable.sol";
import "@openzeppelin/contracts/token/ERC721/ERC721.sol";
import "@openzeppelin/contracts/token/ERC721/extensions/ERC721Enumerable.sol";
import "@openzeppelin/contracts/access/AccessControl.sol";

contract BiHero is ERC721, ERC721Enumerable, Ownable, AccessControl {
    
    bytes32 public constant MINTER_ROLE = keccak256("MINTER_ROLE");
    string public _baseTokenURI;
    mapping(uint256 => bool) public lockedTokens;

    constructor() ERC721("BiHero", "BH") {}
    
    function mint(address _to, uint256 _tokenId) public {
        require(
            hasRole(MINTER_ROLE, _msgSender()),
            "BiHero: Must have minter role to mint"
        );
        require(!_exists(_tokenId), "BiHero: Must have unique tokenId");
        _mint(_to, _tokenId);
    }

    function setMintRole(address factory) external onlyOwner {
        _setupRole(MINTER_ROLE, factory);
    }

    function revokeMintRole(address factory) external onlyOwner {
        revokeRole(MINTER_ROLE, factory);
    }

    function lock(uint256 tokenId) external onlyOwner {
        require(_exists(tokenId), "BiHero: Must be valid tokenId");
        require(!lockedTokens[tokenId], "BiHero: Token has already locked");
        lockedTokens[tokenId] = true;
    }

    function unlock(uint256 tokenId) external onlyOwner {
        require(_exists(tokenId), "BiHero: Must be valid tokenId");
        require(lockedTokens[tokenId], "BiHero: Token has already unlocked");
        lockedTokens[tokenId] = false;
    }

    function updateBaseURI(string calldata baseTokenURI) public onlyOwner {
        _baseTokenURI = baseTokenURI;
    }

    function _beforeTokenTransfer(address from, address to, uint256 tokenId) internal virtual override(ERC721, ERC721Enumerable) {
        require(!lockedTokens[tokenId], "BiHero: Can not transfer locked token");
        super._beforeTokenTransfer(from, to, tokenId);
    }

    function supportsInterface(bytes4 interfaceId)
        public
        view
        virtual
        override(ERC721, ERC721Enumerable, AccessControl)
        returns (bool)
    {
        return super.supportsInterface(interfaceId);
    }
}
