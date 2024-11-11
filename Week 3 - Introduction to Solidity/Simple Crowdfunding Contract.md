```solidity

pragma solidity ^0.8.0;

contract Crowdfunding {
    address public owner;
    uint256 public goal;
    uint256 public raisedAmount;
    bool public goalReached;

    mapping(address => uint256) public contributions;

    event ContributionReceived(address contributor, uint256 amount);
    event GoalReached(address owner, uint256 raisedAmount);

    modifier onlyOwner() {
        require(msg.sender == owner, "Only the owner can perform this action");
        _;
    }

    modifier goalNotReached() {
        require(!goalReached, "Goal already reached");
        _;
    }

    constructor(uint256 _goal) {
        owner = msg.sender;
        goal = _goal;
        raisedAmount = 0;
        goalReached = false;
    }

    function contribute() public payable goalNotReached {
        require(msg.value > 0, "Contribution must be greater than zero");
        contributions[msg.sender] += msg.value;
        raisedAmount += msg.value;

        emit ContributionReceived(msg.sender, msg.value);

        if (raisedAmount >= goal) {
            goalReached = true;
            emit GoalReached(owner, raisedAmount);
        }
    }

    function withdrawFunds() public onlyOwner {
        require(goalReached, "Goal not reached yet");
        payable(owner).transfer(address(this).balance);
    }

    function getBalance() public view returns (uint256) {
        return address(this).balance;
    }
}
