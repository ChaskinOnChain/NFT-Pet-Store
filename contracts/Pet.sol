// contracts/Pet.sol
//SPDX-License-Identifier: MIT
pragma solidity ^0.8.4;

import "hardhat/console.sol";
import "@openzeppelin/contracts/token/ERC721/ERC721.sol";
import "@openzeppelin/contracts/access/Ownable.sol";
import "@openzeppelin/contracts/token/ERC721/extensions/ERC721URIStorage.sol";
import "@openzeppelin/contracts/token/ERC721/extensions/ERC721Enumerable.sol";
import "@openzeppelin/contracts/utils/Counters.sol";

contract Pet is ERC721URIStorage, ERC721Enumerable, Ownable {
    using Counters for Counters.Counter;
    Counters.Counter private _tokenIds;

    // Keep record of token value
    mapping(uint256 => uint256) public tokenIdToValue;

    // TODO: declare the event of minting the NFTs including the ID, price, and string token URI.
    event NFTMinted(uint256 ID, uint256 price, string tokenURI);

    constructor() ERC721("Pet", "PET") {}

    function exists(uint256 tokenId) public view returns (bool) {
        return _exists(tokenId);
    }

    // TODO: Implement currentTokenId() to return the id of the last created token.
    // Note that _tokenIds.current() will return the id of the token that will be created next.
    // Use require or revert to throw an error if no tokens have been created yet.
    function currentTokenId() public view returns (uint256) {
        require(_tokenIds.current() > 0, "No tokens have been minted yet");
        return _tokenIds.current() - 1;
    }

    // TODO: Implement setTokenURI() to link the tokenID to a string URI.
    function setTokenURI(uint256 tokenId, string memory _tokenURI)
        public
        returns (bool)
    {
        // TODO: Require that the account connected to the contract isn't the zero address.
        require(msg.sender != address(0), "Address zero connected");
        // TODO: Require that the tokenId exists.
        require(_exists(tokenId), "token doesn't exist");
        // TODO: Call _setTokenURI to link the URI to the token.  See ERC721URIStorage.sol.
        _setTokenURI(tokenId, _tokenURI);
        return true;
    }

    // TODO: Write your minting function:
    function mintTo(
        address recipient,
        string memory _tokenURI,
        uint256 _nftPrice
    ) public returns (uint256) {
        // TODO: Require that the account connected to the contract isn't the zero address.
        require(msg.sender != address(0), "Address zero connected");
        require(recipient != address(0), "recipient is zero address");
        // TODO: Get the id of the token that will be created next.
        uint256 currentID = _tokenIds.current();
        // TODO: Set the NFT Price in the record.
        setTokenPrice(currentID, _nftPrice);
        // TODO: Use _mint() to create a token and send it to the recipient.  See ERC721.sol.
        _mint(recipient, currentID);
        // TODO: Use _setTokenURI() to link the token's id with the proper token URI.
        _setTokenURI(currentID, _tokenURI);
        // TODO: Increment _tokenIds.
        _tokenIds.increment();
        // TODO: Emit a Minted event with the NFT's id, price, and URI.
        emit NFTMinted(currentID, _nftPrice, _tokenURI);
        // TODO: Return the NFT's id.
        return currentID;
    }

    function tokenPrice(uint256 _tokenId) public view returns (uint256) {
        return tokenIdToValue[_tokenId];
    }

    function setTokenPrice(uint256 _tokenId, uint256 price) public {
        tokenIdToValue[_tokenId] = price;
    }

    // TODO: Use the super keyword to call inherited versions of these functions from parent contracts.
    function supportsInterface(bytes4 interfaceId)
        public
        view
        override(ERC721, ERC721Enumerable)
        returns (bool)
    {
        return super.supportsInterface(interfaceId);
    }

    function _burn(uint256 tokenId)
        internal
        virtual
        override(ERC721, ERC721URIStorage)
    {
        super._burn(tokenId);
    }

    function _beforeTokenTransfer(
        address from,
        address to,
        uint256 tokenId
    ) internal virtual override(ERC721, ERC721Enumerable) {
        super._beforeTokenTransfer(from, to, tokenId);
    }

    function tokenURI(uint256 tokenId)
        public
        view
        override(ERC721, ERC721URIStorage)
        returns (string memory)
    {
        return super.tokenURI(tokenId);
    }

    // If an error in VSCode saying "Function needs to specify overridden contracts...", ignore it.
    function transferFrom(
        address from,
        address to,
        uint256 tokenId
    ) public virtual override {
        // TODO: Call _beforeTokenTransfer() before using super.transferFrom().
        _beforeTokenTransfer(from, to, tokenId);
        super.transferFrom(from, to, tokenId);
    }
}
