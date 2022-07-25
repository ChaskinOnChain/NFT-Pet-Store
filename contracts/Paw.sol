/// SPDX-License-Identifier: MIT
pragma solidity ^0.8.4;

import "@openzeppelin/contracts/token/ERC20/ERC20.sol";
import "@openzeppelin/contracts/access/Ownable.sol";

// TODO: Create a contract named "Paw" that inherits from ERC20 and Ownable.
// See Pet.sol for syntax.
contract Paw is ERC20, Ownable {
    // TODO: Set the private air drop amount at any number.
    uint256 private privateAirdropAmount = 1000;

    // TODO: Write the constructor for the PAW token and _mint() to msg.sender any number of tokens.
    constructor() ERC20("Paw", "PAW") {
        _mint(msg.sender, 333);
    }

    // TODO: Write a public function requestAirdrop() that calls airdropTo()
    // and transfer the air drop amount of tokens to the account connected to the contract.
    function requestAirdrop(uint256 amount) public {
        airdropTo(msg.sender, amount);
    }

    // TODO: Write a private function airdropTo() that takes in a recipient address and an amount
    // and _transfer() that amount of tokens from the contract owner (see owner()) to the recipient.
    function airdropTo(address recipient, uint256 amount) private {
        _transfer(owner(), recipient, amount);
    }
}
