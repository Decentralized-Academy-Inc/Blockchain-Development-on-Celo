```solidity

// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

contract Insurance {
    address public insurer;
    address public policyholder;
    uint public premium;
    uint public coverageAmount;
    bool public isClaimed;

    modifier onlyInsurer() {
        require(msg.sender == insurer, "Only the insurer can perform this action");
        _;
    }

    modifier onlyPolicyholder() {
        require(msg.sender == policyholder, "Only the policyholder can perform this action");
        _;
    }

    event InsurancePurchased(address indexed policyholder, uint premium, uint coverage);
    event ClaimMade(address indexed policyholder, uint amount);
    event Payout(address indexed policyholder, uint amount);

    constructor(address _policyholder, uint _premium, uint _coverageAmount) {
        insurer = msg.sender;
        policyholder = _policyholder;
        premium = _premium;
        coverageAmount = _coverageAmount;
        isClaimed = false;
    }

    function purchaseInsurance() public payable onlyPolicyholder {
        require(msg.value == premium, "Incorrect premium amount");
        emit InsurancePurchased(msg.sender, premium, coverageAmount);
    }

    function makeClaim() public onlyPolicyholder {
        require(!isClaimed, "Claim already made");

        isClaimed = true;
        emit ClaimMade(msg.sender, coverageAmount);
    }

    function payout() public onlyInsurer {
        require(isClaimed, "No claim has been made");
        payable(policyholder).transfer(coverageAmount);
        emit Payout(policyholder, coverageAmount);
    }
}
