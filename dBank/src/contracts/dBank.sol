// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import "./dToken.sol";

contract dBank {
  // Variables
  dToken private dtoken;

  // Events
  // event MinterChanged(address indexed from, address indexed to);

  

  //add mappings

  //add events

  // Constructor
  constructor(dToken _dtoken) {
    dtoken = _dtoken; // setting dtoken
  }

  function deposit() payable public {
    //check if msg.sender didn't already deposited funds
    require(msg.value >= .01 ether, "Error: Value is less than .01 ETH");

    //increase msg.sender ether deposit balance
    //start msg.sender hodling time

    //set msg.sender deposit status to true
    //emit Deposit event
  }

  function withdraw() public {
    //check if msg.sender deposit status is true
    //assign msg.sender ether deposit balance to variable for event

    //check user's hodl time

    //calc interest per second
    //calc accrued interest

    //send eth to user
    //send interest in tokens to user

    //reset depositer data

    //emit event
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