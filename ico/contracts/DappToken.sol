// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

// import "@openzeppelin/contracts/token/ERC20/ERC20.sol";

contract DappToken{ /* is ERC20 */

    // Variables
    string  public name      = "Dapp Token";
    string  public symbol    = "DAPP";
    string  public standard  = "Dapp Token v1.0";
    address public minter;
    uint256 public totalSupply;
    mapping (address => uint256) public balanceOf;
    mapping (address => mapping(address => uint256)) public allowance;

    // Events
    event Transfer(
        address indexed _from, 
        address indexed _to, 
        uint256 value
    );

    event Approve(
        address indexed _owner, 
        address indexed _spender,
        uint256 _value
    );

    // Constructor
    constructor(uint _initialSupply){
        minter = msg.sender;
        balanceOf[msg.sender] = _initialSupply;
        totalSupply = _initialSupply; // 1 Mill supply
    }

    // Functions
    function transfer(address _to, uint256 _value) public returns(bool success){
        require(_value <= totalSupply, "Error: transfer value is greater than totalSupply!");
        require(_value <= balanceOf[msg.sender], "Error: transfer value is greater than balanceOf sender!");

        balanceOf[msg.sender] -= _value;
        balanceOf[_to] += _value;
        emit Transfer(msg.sender, _to, _value);
        return success = true;
    }

    function approve(address _spender, uint256 _value) public returns (bool success){
        allowance[msg.sender][_spender] = _value;
        emit Approve(msg.sender, _spender, _value);
        return success = true;
    }

    function transferFrom(address _from, address _to, uint256 _value) public returns(bool success){
        require(_value <= totalSupply, "Error: transfer value is greater than totalSupply!");
        require(_value <= balanceOf[_from], "Error: transfer value is greater than balanceOf _from!");
        require(_value <= allowance[_from][msg.sender], "Error: transfer value is greater than allowance of _from!");

        balanceOf[_from] -= _value;
        balanceOf[_to] += _value;
        allowance[_from][msg.sender] -= _value;
        emit Transfer(_from, _to, _value);
        return success = true;
    }
}