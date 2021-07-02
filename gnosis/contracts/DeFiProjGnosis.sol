pragma solidity ^0.5.0;

import "./IERC20.sol";
import "./IERC1155.sol";
import "./IERC1155TokenReceiver.sol";
import "./IConditionalTokens.sol";

contract DeFiProjGnosis is IERC1155TokenReceiver {
    
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
    function createBet(bytes32 questionId, uint256 amount) external {
        // setting up 3 outcome slots
        conditionalTokens.prepareCondition(
            oracle, 
            questionId, 
            3
        );

        bytes32 conditionId = conditionalTokens.getConditionId(
            oracle, 
            questionId, 
            3
        );

        uint256[] memory partition = new uint[](2);

        dai.approve(address(conditionalTokens), amount);
        conditionalTokens.splitPosition(
            dai, 
            bytes32(0), 
            conditionId, 
            partition, 
            amount
        );

        tokenBalance[questionId][0] = amount;
        tokenBalance[questionId][1] = amount;
    }


    function transferTokens(
        bytes32 questionsId, 
        uint256 indexSet,
        address to, 
        uint256 amount
    ) external restricted {
        require(tokenBalance[questionsId][indexSet] >= amount, 'Error: Not enough tokens.');

        // setting up transfer parameters
        bytes32 conditionId = conditionalTokens.getConditionId(
            oracle, 
            questionId, 
            3
        );

        bytes32 collectionId = conditionalTokens.getCollectionId(
            bytes32(0), 
            conditionId, 
            indexSet
        );

        uint256 positionId = conditionalTokens.getPositionId(
            dai, 
            collectionId
        );

        conditionalTokens.safeTransferFrom(
            address(this), 
            to, // Needs to implement ERC1155TokenReceiver
            positionId, 
            amount, 
            ""
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