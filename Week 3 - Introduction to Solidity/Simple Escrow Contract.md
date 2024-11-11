```solidity

// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

contract Escrow {
    address public buyer;
    address public seller;
    address public arbitrator;
    uint256 public amount;
    bool public dispute;
    bool public transactionComplete;

    modifier onlyBuyer() {
        require(msg.sender == buyer, "Only the buyer can perform this action");
        _;
    }

    modifier onlySeller() {
        require(msg.sender == seller, "Only the seller can perform this action");
        _;
    }

    modifier onlyArbitrator() {
        require(msg.sender == arbitrator, "Only the arbitrator can perform this action");
        _;
    }

    modifier notComplete() {
        require(!transactionComplete, "Transaction already completed");
        _;
    }

    constructor(address _seller, address _arbitrator) {
        buyer = msg.sender;
        seller = _seller;
        arbitrator = _arbitrator;
        dispute = false;
        transactionComplete = false;
    }

    function deposit() public payable onlyBuyer notComplete {
        amount = msg.value;
    }

    function confirmReceived() public onlyBuyer notComplete {
        require(amount > 0, "No funds deposited");
        payable(seller).transfer(amount);
        transactionComplete = true;
    }

    function raiseDispute() public onlyBuyer notComplete {
        dispute = true;
    }

    function resolveDispute(bool sellerGetsFunds) public onlyArbitrator notComplete {
        require(dispute, "No dispute to resolve");
        if (sellerGetsFunds) {
            payable(seller).transfer(amount);
        } else {
            payable(buyer).transfer(amount);
        }
        transactionComplete = true;
        dispute = false;
    }
}
