```solidity

// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

contract LoyaltyPoints {
    mapping(address => uint256) public pointsBalance;
    address public owner;

    event PointsIssued(address indexed customer, uint256 points);
    event PointsRedeemed(address indexed customer, uint256 points);

    modifier onlyOwner() {
        require(msg.sender == owner, "Only owner can perform this action");
        _;
    }

    constructor() {
        owner = msg.sender;
    }

    function issuePoints(address customer, uint256 points) public onlyOwner {
        pointsBalance[customer] += points;
        emit PointsIssued(customer, points);
    }

    function redeemPoints(uint256 points) public {
        require(pointsBalance[msg.sender] >= points, "Insufficient points");
        pointsBalance[msg.sender] -= points;
        emit PointsRedeemed(msg.sender, points);
    }

    function checkPoints() public view returns (uint256) {
        return pointsBalance[msg.sender];
    }
}
