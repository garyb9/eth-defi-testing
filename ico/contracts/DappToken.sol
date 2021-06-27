// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

// import "@openzeppelin/contracts/token/ERC20/ERC20.sol";

contract DappToken{ /* is ERC20 */

    // Variables
    string  public name      = "Dapp Token";
    string  public symbol    = "DAPP";
    string  public standard  = "Dapp Token v1.0";
    address public minter;
    uint    public totalSupply;
    mapping (address => uint) public balanceOf;
     
    // Events


    // Constructor
    constructor(uint _initialSupply){
        minter = msg.sender;
        balanceOf[msg.sender] = _initialSupply;
        totalSupply = _initialSupply; // 1 Mill supply
    }

    // Functions
    function transfer(address _to, uint _value) public returns(bool success){
        require(_value <= totalSupply, "Error: transfer value is greater than totalSupply!");
        require(_value <= balanceOf[msg.sender], "Error: transfer value is greater than balanceOf sender!");
        success = true;
    }
}