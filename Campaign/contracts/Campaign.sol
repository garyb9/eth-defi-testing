pragma solidity ^0.4.17;

// Factory used to deploy Campaigns
contract CampaignFactory{
    // Objects
    address[] public deployedCampaigns;
    
    // Constructor
    constructor(uint minimum) public{
        address newCampaign = new Campaign(minimum, msg.sender); // deploys a new Campaign
        deployedCampaigns.push(newCampaign); // adds it to deployedCampaigns storage
    }
    
    // Functions 
    function getDeployedCampaigns() public view returns(address[]){
        return deployedCampaigns;
    }
}


// Main Campaign contract
contract Campaign{
    
    // Structs
    struct Request{
        string description;
        uint value;
        address recipient;
        bool complete;
        uint approvalCount;
        mapping (address => bool) approvals;
    }
    
    // Objects
    Request[] public requests;
    address public manager;
    uint public minimumContribution; 
    mapping (address => bool) public approvers;
    uint public approversCount;
    
    // Modifiers
    modifier restricted(){
        require(msg.sender == manager);
        _;
    }
    
    // Constructor
    constructor(uint minimum, address creator) public{
        manager = creator; // msg.sender
        minimumContribution = minimum;
    }
    
    // Functions
    function contribute() public payable{
        require(msg.value >= minimumContribution, 
        "Value less than minimumContribution");
        
        approvers[msg.sender] = true;
        approversCount++;
    }
    
    function createRequest(string description, uint value, address recipient) 
        public restricted {
        
        require(approvers[msg.sender]); // require this address has contributed
        
        Request memory newRequest = Request({
            description: description,
            value: value,
            recipient: recipient,
            complete: false,
            approvalCount: 0
        });
        
        requests.push(newRequest);
        
    }
    
    function approveRequest(uint index) public {
        Request storage request = requests[index];
        
        require(approvers[msg.sender]);
        require(!request.approvals[msg.sender]);
        
        request.approvals[msg.sender] = true;
        request.approvalCount++;
    }
    
    function finalizeRequest(uint index) public restricted {
        Request storage request = requests[index];
        
        require(request.approvalCount > (approversCount / 2));
        require(!request.complete);
        
        request.recipient.transfer(request.value);
        request.complete = true;
    }
    
}