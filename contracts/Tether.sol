// SPDX-License-Identifier: MIT
// Compatible with OpenZeppelin Contracts ^5.0.0
pragma solidity ^0.8.0;

import "@openzeppelin/contracts/token/ERC20/ERC20.sol";
import "@openzeppelin/contracts/token/ERC20/extensions/ERC20Burnable.sol";
import "@openzeppelin/contracts/access/Ownable.sol";

contract Tether is ERC20, ERC20Burnable, Ownable {
    uint256 private cap = 50_000_000_000 *10 **uint256(18);
    constructor(address initialOwner)
        ERC20("Tether", "USDT")
        Ownable(initialOwner)
    {
        _mint(msg.sender, cap);
        transferOwnership(msg.sender);
    }

    function mint(address to, uint256 amount) public onlyOwner {
        require(
            ERC20.totalSupply() + amount <= cap,
            "Tether: cap exceeded"
        );
        _mint(to, amount);
    }
}