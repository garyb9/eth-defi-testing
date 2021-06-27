// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import "@openzeppelin/contracts/token/ERC20/ERC20.sol";

// inherits from openzeppelin
contract Token is ERC20 {
  // Variables
  address public minter; 

  // Events
  event MinterChanged(address indexed minter, address indexed newMinter);

  // Constructor
  constructor() public payable ERC20("dToken", "DTKN") {
    minter = msg.sender;
  }

  // Functions
  function passMinterRole(address dBank) public returns(bool){
    require(msg.sender == minter, "Error: msg.sender is not the minter! only creator can pass minter role of dTokens.");
    minter = dBank;

    emit MinterChanged(msg.sender, dBank);
    return true;
  }

  function mint(address account, uint256 amount) public {
    require(msg.sender == minter, "Error: msg.sender is not the minter! only creator can mint dTokens.");
		_mint(account, amount); // inherited from ERC20
	}
}