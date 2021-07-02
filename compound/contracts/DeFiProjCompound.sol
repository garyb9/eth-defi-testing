// SPDX-License-Identifier: MIT
pragma solidity ^0.5.16;

import "./IERC20.sol";
import "./compound-protocol/ComptrollerInterface.sol";
import "./compound-protocol/CErc20.sol";

contract DeFiProjCompound{

    // Variables
    address                 public manager;
    uint256                 public defaultCollaterallDiv;
    IERC20                  public dai;
    CErc20                  public cDai;
    IERC20                  public bat;
    CErc20                  public cBat;
    ComptrollerInterface    public comptroller;

    // Constructor
    constructor(
        uint256 _defaultCollaterallDiv,
        address _dai,
        address _cDai,
        address _bat, 
        address _cBat,
        address _comptroller
    ) public {
        require(defaultCollaterallDiv >= 1);
        manager = msg.sender;
        defaultCollaterallDiv = _defaultCollaterallDiv;
        dai = IERC20(_dai);
        cDai = CErc20(_cDai);
        bat = IERC20(_bat);
        cBat = CErc20(_cBat);
        comptroller = ComptrollerInterface(_comptroller);
    }

    // Modifiers
    modifier restricted(){
        require(msg.sender == manager, 'Reserved: Only manager allowed');
        _;
    }

    // functions
    function invest(uint256 investAmount) external {
        dai.approve(address(cDai), investAmount);
        cDai.mint(investAmount);
    }

    function cashout() external {
        uint256 redeemTokens = cDai.balanceOf(address(this));
        cDai.redeem(redeemTokens);
    }

    function borrow(uint256 borrowAmount) external {
        dai.approve(address(cDai), borrowAmount);
        cDai.mint(borrowAmount);

        address[] memory markets = new address[](1);
        markets[0] = address(cDai);
        comptroller.enterMarkets(markets);

        cBat.borrow(borrowAmount / defaultCollaterallDiv); // borrow amount should be less than collaterall 
    }

    function payback(uint256 borrowAmount) external {
        bat.approve(address(cBat), borrowAmount);
        cBat.repayBorrow(borrowAmount / defaultCollaterallDiv);

        // Optional 
        uint256 redeemTokens = cDai.balanceOf(address(this));
        cDai.redeem(redeemTokens);
    }
}