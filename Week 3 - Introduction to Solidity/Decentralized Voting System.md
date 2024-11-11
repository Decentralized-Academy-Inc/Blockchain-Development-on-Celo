```solidity

// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

contract Voting {
    address public owner;
    mapping(string => uint256) public votesReceived;
    mapping(address => bool) public voters;
    string[] public proposalList;

    event Voted(address indexed voter, string proposal);

    modifier onlyOwner() {
        require(msg.sender == owner, "Only the owner can perform this action");
        _;
    }

    constructor(string[] memory proposals) {
        owner = msg.sender;
        proposalList = proposals;
    }

    function vote(string memory proposal) public {
        require(!voters[msg.sender], "You have already voted");
        bool isValidProposal = false;
        for (uint i = 0; i < proposalList.length; i++) {
            if (keccak256(abi.encodePacked(proposal)) == keccak256(abi.encodePacked(proposalList[i]))) {
                isValidProposal = true;
                break;
            }
        }
        require(isValidProposal, "Invalid proposal");

        votesReceived[proposal] += 1;
        voters[msg.sender] = true;
        emit Voted(msg.sender, proposal);
    }

    function getVotes(string memory proposal) public view returns (uint256) {
        return votesReceived[proposal];
    }

    function getProposals() public view returns (string[] memory) {
        return proposalList;
    }
}
