pragma solidity ^0.4.17;

contract Lottery{
    address     public manager;
    address[]   public players;

    function Lottery() public {
        manager = msg.sender;
    }

    function enter() public payable {
        require(msg.value > .01 ether);
        players.push(msg.sender);
    }

    function random() private view returns(uint){
        return uint(keccak256(
            block.difficulty, 
            now, 
            players
        ));
    }

    function pickWinner() public restricted {
        uint index = random() % players.length;
        players[index].transfer(this.balance);
        players = new address[](0); // create a new dynamic array with an initial zero value
    }

    modifier restricted() {
        require(
            msg.sender == manager, 
            "Only the manager can pick a winner."
        );
        _;
    }

    function getPlayer() public view return (address[]){
        return players;
    }
}