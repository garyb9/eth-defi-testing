// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import "@openzeppelin/contracts/token/ERC20/ERC20.sol";
// import "@openzeppelin/contracts/token/ERC20/ERC20Detailed.sol"; // deprecated

contract Dai is ERC20{

    // Constructor
    constructor() ERC20('Dai Stablecoin', 'DAI'){}

    // Functions
    function faucet(address _recipient, uint256 _amount) external{
        _mint(_recipient, _amount);
    }
}