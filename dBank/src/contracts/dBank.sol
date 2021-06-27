// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import "./dToken.sol";

contract dBank {
  // Variables
  dToken private dtoken;
  mapping (address => uint) public etherBalanceOf;
  mapping (address => uint) public depositStart;
  mapping (address => bool) public isDeposited; 

  // Events
  event Deposit(address indexed user, uint etherAmount, uint timeStart);
  event Withdraw(address indexed user, uint etherAmount, uint depositTime, uint interest);

  // Constructor
  constructor(dToken _dtoken) {
    dtoken = _dtoken; // setting dtoken
  }

  function deposit() payable public {
    require(isDeposited[msg.sender] == false, "Error: deposit already active!");
    require(msg.value >= .01 ether, "Error: Value is less than .01 ETH!");

    etherBalanceOf[msg.sender] += msg.value;
    depositStart[msg.sender] += block.timestamp;
    isDeposited[msg.sender] = true;
    emit Deposit(msg.sender, msg.value, block.timestamp);
  }

  function withdraw() public {
    require(isDeposited[msg.sender] == true, "Error: no previous deposit");
    uint userBalance = etherBalanceOf[msg.sender]; // for event

    //check user's hodl time, and calculate the accured interest
    uint depositTime = block.timestamp - depositStart[msg.sender];
    uint interestperSecond = 31668017 * (etherBalanceOf[msg.sender] / 1e16);
    uint interest = interestperSecond * depositTime;

    //send users eth balance back
    payable(msg.sender).transfer(userBalance); 

    //send interest in dtokens to user
    dtoken.mint(msg.sender, interest);

    //reset depositer data and emit event
    depositStart[msg.sender] = 0;
    etherBalanceOf[msg.sender] = 0; 
    isDeposited[msg.sender] = false;
    emit Withdraw(msg.sender, userBalance, depositTime, interest);
  }

  function borrow() payable public {
    //check if collateral is >= than 0.01 ETH
    //check if user doesn't have active loan

    //add msg.value to ether collateral

    //calc tokens amount to mint, 50% of msg.value

    //mint&send tokens to user

    //activate borrower's loan status

    //emit event
  }

  function payOff() public {
    //check if loan is active
    //transfer tokens from user back to the contract

    //calc fee

    //send user's collateral minus fee

    //reset borrower's data

    //emit event
  }
}