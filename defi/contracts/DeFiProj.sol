// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import "@openzeppelin/contracts/token/ERC20/IERC20.sol";
import "@openzeppelin/contracts/token/ERC20/ERC20.sol";

contract DeFiProj{

    // Variables
    ERC20 dai; // implementation of IERC20

    // Constructor
    constructor(address daiAddress){
        dai = ERC20(daiAddress); // by address of an implementation of IERC20
    }

    function foo(address _recipient, uint256 _amount) external {
        dai.transfer(_recipient, _amount);
    }
}