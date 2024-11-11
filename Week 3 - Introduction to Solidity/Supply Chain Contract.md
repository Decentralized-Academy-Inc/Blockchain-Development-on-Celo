```solidity

// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

contract SupplyChain {
    enum State { Manufactured, Shipped, Delivered }

    struct Product {
        uint256 id;
        string name;
        State state;
        address manufacturer;
        address currentOwner;
    }

    mapping(uint256 => Product) public products;

    event ProductStateChanged(uint256 productId, State state, address currentOwner);

    modifier onlyManufacturer(uint256 productId) {
        require(msg.sender == products[productId].manufacturer, "Only manufacturer can perform this action");
        _;
    }

    modifier onlyOwner(uint256 productId) {
        require(msg.sender == products[productId].currentOwner, "Only the current owner can perform this action");
        _;
    }

    function manufactureProduct(uint256 productId, string memory productName) public {
        products[productId] = Product(productId, productName, State.Manufactured, msg.sender, msg.sender);
        emit ProductStateChanged(productId, State.Manufactured, msg.sender);
    }

    function shipProduct(uint256 productId) public onlyManufacturer(productId) {
        products[productId].state = State.Shipped;
        emit ProductStateChanged(productId, State.Shipped, msg.sender);
    }

    function deliverProduct(uint256 productId) public onlyOwner(productId) {
        products[productId].state = State.Delivered;
        emit ProductStateChanged(productId, State.Delivered, msg.sender);
    }
}
