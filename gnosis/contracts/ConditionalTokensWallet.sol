pragma solidity ^0.5.0;

import "./IERC20.sol";
import "./IERC1155.sol";
import "./IERC1155TokenReceiver.sol";
import "./IConditionalTokens.sol";

contract ConditionalTokensWallet is IERC20, IERC1155, IERC1155TokenReceiver {

    // Vatiables
    IERC20 dai;
    IConditionalTokens conditionalTokens;
    address public oracle;
    mapping(bytes32 => mapping(uint256 => uint256)) public tokenBalance;
    address public admin;

    // Modifiers
    modifier restricted(){
        require(msg.sender == admin, 'Reserved: Only admin allowed');
        _;
    }

    // Events 

    event Redeemed(IERC20 collateralToken, 
        bytes32 parentCollectionId, 
        bytes32 conditionId, 
        uint[] indexSets
    );

    // Constructor
    constructor(
        address _dai,
        address _conditionalTokens,
        address _oracle
    ) public {
        dai = IERC20(_dai);
        conditionalTokens = IConditionalTokens(_conditionalTokens);
        oracle = _oracle;
        admin = msg.sender;
    }

    // Functions 
    function redeemTokens(
        bytes32 conditionId,
        uint256[] calldata indexSet
    ) external {
        // a conditional redeem if a condition has been made
        conditionalTokens.redeemPositions(
            dai,
            bytes32(0),
            conditionId,
            indexSet
        );

        emit Redeemed(
            dai,
            bytes32(0),
            conditionId,
            indexSet
        );
    }

    function transferDai(address to, uint256 amount) external restricted {
        dai.transfer(to, amount);

        emit Transfer(
            address(this), 
            to, 
            amount
        );
    }

    /**
        @dev Handles the receipt of a single ERC1155 token type. This function is
        called at the end of a `safeTransferFrom` after the balance has been updated.
        To accept the transfer, this must return
        `bytes4(keccak256("onERC1155Received(address,address,uint256,uint256,bytes)"))`
        (i.e. 0xf23a6e61, or its own function selector).
        @param operator The address which initiated the transfer (i.e. msg.sender)
        @param from The address which previously owned the token
        @param id The ID of the token being transferred
        @param value The amount of tokens being transferred
        @param data Additional data with no specified format
        @return `bytes4(keccak256("onERC1155Received(address,address,uint256,uint256,bytes)"))` if transfer is allowed
    */
    function onERC1155Received(
        address operator,
        address from,
        uint256 id,
        uint256 value,
        bytes calldata data
    )
    external
    returns(bytes4){
        return bytes4(keccak256("onERC1155BatchReceived(address,address,uint256[],uint256[],bytes)"));
    }

    /**
        @dev Handles the receipt of a multiple ERC1155 token types. This function
        is called at the end of a `safeBatchTransferFrom` after the balances have
        been updated. To accept the transfer(s), this must return
        `bytes4(keccak256("onERC1155BatchReceived(address,address,uint256[],uint256[],bytes)"))`
        (i.e. 0xbc197c81, or its own function selector).
        @param operator The address which initiated the batch transfer (i.e. msg.sender)
        @param from The address which previously owned the token
        @param ids An array containing ids of each token being transferred (order and length must match values array)
        @param values An array containing amounts of each token being transferred (order and length must match ids array)
        @param data Additional data with no specified format
        @return `bytes4(keccak256("onERC1155BatchReceived(address,address,uint256[],uint256[],bytes)"))` if transfer is allowed
    */
    function onERC1155BatchReceived(
        address operator,
        address from,
        uint256[] calldata ids,
        uint256[] calldata values,
        bytes calldata data
    )
    external
    returns(bytes4){
        return bytes4(keccak256("onERC1155BatchReceived(address,address,uint256[],uint256[],bytes)"));
    }
}