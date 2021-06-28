// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import "./DappToken.sol";

contract DappTokenSale{

    // Variables
    address     admin; // secret admin
    DappToken   public tokenContract;
    uint256     public tokenPrice;
    uint256     public tokensSold;

    // Events
    event Sell(address indexed _buyer, uint256 _amount);

    // Constructor
    constructor(DappToken _tokenContract, uint256 _tokenPrice){
        admin = msg.sender;
        tokenContract = _tokenContract;
        tokenPrice = _tokenPrice;
    }

    // Functions
    function multiply(uint256 x, uint256 y) internal pure returns(uint256 z){   
        require(y == 0 || ((z = x*y) / y) == x); // safe multiply
    }

    function buyTokens(uint256 _numOfTokens) public payable{
        require(msg.value == multiply(_numOfTokens, tokenPrice)); // checks value is a multiple of the numOfTOkens provided and the current price
        require(tokenContract.balanceOf(address(this)) >= _numOfTokens); // checks token balance of this contract
        require(tokenContract.transfer(msg.sender, _numOfTokens)); // transfer to sender the requested amount of tokens
        tokensSold += _numOfTokens;
        emit Sell(msg.sender, _numOfTokens);
    }
}