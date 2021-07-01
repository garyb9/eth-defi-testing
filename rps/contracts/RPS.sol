//SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import "hardhat/console.sol";
import "contracts/stringUtils.sol";

// Factory used to deploy RPS games
// contract RPSFactory{
//     // Objects
//     address[] public deployedRPSgames;
    
//     // Constructor
//     constructor(){
//         address newRPS = address(new RPS(msg.sender)); // deploys a new RPS
//         deployedRPSgames.push(newRPS); // adds it to deployedRPSgames storage
//     }
    
//     // Functions 
//     function getDeployedRPSgames() public view returns(address[] memory){
//         return deployedRPSgames;
//     }
// }

contract RPS{

    // Objects
    address     public manager;
    address[]   public players;
    mapping (address => string) public moves;

    // Modifiers
    modifier restricted(){
        require(msg.sender == manager);
        _;
    }

    // Constructor
    constructor(/*address creator*/){
        // manager = creator; // msg.sender
        manager = msg.sender;
    }

    // Functions
    function checkLegalMove(string memory move) internal pure returns(bool ok){
        if(StringUtils.equal(move, "R") ||
           StringUtils.equal(move, "P") ||
           StringUtils.equal(move, "S")  ){
               ok = true;
           }
        else ok = false;
    }

    function pickWinner() internal view returns(address winner){
        if(StringUtils.equal(moves[players[0]], "R")){
            if(StringUtils.equal(moves[players[1]], "R")) winner = address(0); // nobody won
            if(StringUtils.equal(moves[players[1]], "S")) winner = players[0]; // first player won
            if(StringUtils.equal(moves[players[1]], "P")) winner = players[1]; // second player won     
        }
        if(StringUtils.equal(moves[players[0]], "P")){
            if(StringUtils.equal(moves[players[1]], "P")) winner = address(0); // nobody won
            if(StringUtils.equal(moves[players[1]], "R")) winner = players[0]; // first player won
            if(StringUtils.equal(moves[players[1]], "S")) winner = players[1]; // second player won
        }
        if(StringUtils.equal(moves[players[0]], "S")){
            if(StringUtils.equal(moves[players[1]], "S")) winner = address(0); // nobody won
            if(StringUtils.equal(moves[players[1]], "P")) winner = players[0]; // first player won
            if(StringUtils.equal(moves[players[1]], "R")) winner = players[1]; // second player won  
        }
    }

    function enter(string memory move) public payable {
        require(msg.value > .01 ether, 
            "Insufficient deposit. Please deposit more than .01 ether");
        require(checkLegalMove(move), 
            "Wrong move type. Only {'R', 'S', 'P'} are allowed.");

        if(players.length > 2){
            // don't allow more than two players
            delete players;
        }
        players.push(msg.sender);
        moves[msg.sender] = move;
        if(players.length == 2){
            address winner = pickWinner();
            payable(winner).transfer(address(this).balance);
            moves[players[0]] = "";
            moves[players[1]] = "";
            delete players;
        }
    }

}