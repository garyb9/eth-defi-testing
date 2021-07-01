// SPDX-License-Identifier: MIT
pragma solidity ^0.5.16;

import "./IERC20.sol";
import "./ComptrollerInterface.sol";
import "./CTokenInterfaces.sol";

contract DeFiProjCompound{

    // Variables
    address                 public manager;
    IERC20                  public dai;
    IERC20                  public bat;
    CTokenInterface         public cDai;
    CTokenInterface         public cBat;
    ComptrollerInterface    public Comptroller;

    // Constructor
    constructor() public {
        manager = msg.sender;
    }

    // Modifiers
    modifier restricted(){
        require(msg.sender == manager, 'Reserved: Only manager allowed');
        _;
    }

    // functions

}