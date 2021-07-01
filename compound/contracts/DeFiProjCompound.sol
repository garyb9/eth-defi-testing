// SPDX-License-Identifier: MIT
pragma solidity ^0.5.16;

contract DeFiProjCompound{

    // Structs
    // Variables
    address public manager;

    // Constructor
    constructor(address uniswapFactoryAddress) public {
        // setting up Uniswap V2 Factory
        manager = msg.sender;
        uniswapFactory = UniswapV2Factory(uniswapFactoryAddress);
    }

    // Modifiers
    modifier restricted(){
        require(msg.sender == manager, 'Reserved: Only manager allowed');
        _;
    }

    // functions

}