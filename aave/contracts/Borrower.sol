// SPDX-License-Identifier: MIT
pragma solidity 0.6.12;

import '@aave/protocol-v2/contracts/protocol/configuration/LendingPoolAddressesProvider.sol';

// this one shoots a 'Stack too deep' compiler error, hence using the interface instead
// import '@aave/protocol-v2/contracts/protocol/lendingpool/LendingPool.sol'; 
import '@aave/protocol-v2/contracts/interfaces/ILendingPool.sol';

import "@aave/protocol-v2/contracts/flashloan/base/FlashLoanReceiverBase.sol";

abstract contract Borrower is FlashLoanReceiverBase {
    
    // Variables
    LendingPoolAddressesProvider public provider;
    address public dai;

    // Constructor
    constructor(
        address _provider, 
        address _dai
        // FlashLoanReceiverBase(_provider)
        // ILendingPoolAddressesProvider provider
    ) public {
        provider = LendingPoolAddressesProvider(_provider);
        dai = _dai;
    }

    // functions 
    function startLoan(uint256 amount, bytes calldata _params) external {
        // address lendingPool = provider.getLendingPool();
        ILendingPool lendingPool = ILendingPool(provider.getLendingPool());

        address[] memory assets     = new address[](0);
        uint256[] memory amounts    = new uint256[](0);
        uint256[] memory modes      = new uint256[](0);

        assets[0]   = dai;
        amounts[0]  = amount;
        modes[0]    = 0;        // modes -> Don't open any debt 

        lendingPool.flashLoan(
            address(this), // receiver -> this
            assets,
            amounts,
            modes, 
            address(this), // onBehalfOf -> debt receiver
            _params,
            0
        );
    }

    // function executeOperation(
    //     address _reserve,
    //     uint256 _amount,
    //     uint256 _fee,
    //     bytes memory _params
    // ) external {
    //     // arbitrage, refinance loan, change collaterall of loan
    //     transferFundsBackToPoolInternal(_reserve, _amount + _fee);
    // }

    function executeOperation(
        address[] calldata assets,
        uint256[] calldata amounts,
        uint256[] calldata premiums,
        address initiator,
        bytes calldata params
    ) external override returns (bool) {
        // arbitrage, refinance loan, change collaterall of loan
    }
}