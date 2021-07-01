// SPDX-License-Identifier: MIT
pragma solidity ^0.5.16;

import '@uniswap/v2-core/contracts/UniswapV2Factory.sol';
import '@uniswap/v2-core/contracts/UniswapV2Pair.sol';

contract DeFiProjUniswapV2{

    // Structs
    struct UniPairSt{
        bool pairStatus;
        string pairName;
        address pairAddress;
        address tokenA;
        address tokenB;
        uint112 reserveA;
        uint112 reserveB;
    }
    // Variables
    address public manager;
    UniswapV2Factory private uniswapFactory;
    mapping (string => address) public uniPairNames;
    mapping (address => UniPairSt) public uniPairStructs;
    uint32 public timestampLastChecked;

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

    // Functions
    function createPair(string calldata name, address tokenA, address tokenB) 
        external returns(address addressPair) {
        // super
        addressPair = uniswapFactory.createPair(tokenA, tokenB); // returns address pair
        // record
        uniPairNames[name] = addressPair;
        (uint112 res0, uint112 res1, uint32 timestampLast) = IUniswapV2Pair(addressPair).getReserves();
        timestampLastChecked = timestampLast;
        UniPairSt memory uniPairSt = UniPairSt({
            pairStatus: true,
            pairName: name,
            pairAddress: addressPair,
            tokenA: tokenA,
            tokenB: tokenB,
            reserveA: res0,
            reserveB: res1
        });
        uniPairStructs[addressPair] = uniPairSt;

        // return addressPair;W
    }

    function buy(address tokenAddress, uint256 tokenAmount) external payable {
        // IUniswapV2Pair uniswapPair = IUniswapV2Pair(uniswapFactory.getExchange(tokenAddress));
    }

}