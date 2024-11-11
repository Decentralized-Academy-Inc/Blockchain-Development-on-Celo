```solidity

// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

contract Auction {
    address public owner;
    uint public highestBid;
    address public highestBidder;
    uint public endAt;
    bool public ended;

    mapping(address => uint) public bids;

    modifier onlyOwner() {
        require(msg.sender == owner, "Only owner can call this");
        _;
    }

    modifier onlyAfterEnd() {
        require(block.timestamp >= endAt, "Auction not ended yet");
        _;
    }

    modifier onlyNotEnded() {
        require(!ended, "Auction already ended");
        _;
    }

    event NewBid(address indexed bidder, uint bid);
    event AuctionEnded(address indexed winner, uint amount);

    constructor(uint _biddingTime) {
        owner = msg.sender;
        endAt = block.timestamp + _biddingTime;
    }

    function placeBid() public payable onlyNotEnded {
        require(msg.value > highestBid, "Bid must be higher than the current highest bid");

        // Refund the previous highest bidder
        if (highestBid > 0) {
            payable(highestBidder).transfer(highestBid);
        }

        highestBid = msg.value;
        highestBidder = msg.sender;

        emit NewBid(msg.sender, msg.value);
    }

    function endAuction() public onlyOwner onlyAfterEnd {
        require(!ended, "Auction already ended");

        ended = true;
        emit AuctionEnded(highestBidder, highestBid);

        // Transfer the highest bid to the owner
        payable(owner).transfer(highestBid);
    }
}
