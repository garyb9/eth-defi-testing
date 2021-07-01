// SPDX-License-Identifier: MIT
pragma solidity ^0.5.16;

import '@uniswap/v2-core/contracts/UniswapV2Factory.sol';
import '@uniswap/v2-core/contracts/UniswapV2Pair.sol';

contract DeFiProjUniswapV2{

    // Variables
    UniswapV2Factory uniswapFactory;

    address[] public addressPairs;

    // Constructor
    constructor() public {
        
    }

    // Functions 

    // function setup(address uniswapFactoryAddress) external {
    //     uniswapFactory = IUniswapV2Factory(uniswapFactoryAddress);
    // }

    // function createPair(address tokenA, address tokenB) external {
    //     address addressPair = uniswapFactory.createPair(tokenA, tokenB); // returns address pair
    //     addressPairs.push(addressPair);
    // }

    // function buy(address tokenAddress, uint256 tokenAmount) external payable {
    //     // IUniswapV2Pair uniswapPair = IUniswapV2Pair(uniswapFactory.getExchange(tokenAddress));s
        
    // }

}