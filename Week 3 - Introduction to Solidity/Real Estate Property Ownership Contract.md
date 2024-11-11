```solidity

// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

contract RealEstateOwnership {
    struct Property {
        string name;
        address owner;
        uint price;
    }

    mapping(uint => Property) public properties;

    event PropertyRegistered(uint propertyId, string name, uint price);
    event PropertyTransferred(uint propertyId, address newOwner);

    modifier onlyOwner(uint propertyId) {
        require(msg.sender == properties[propertyId].owner, "Only the owner can perform this action");
        _;
    }

    function registerProperty(uint propertyId, string memory name, uint price) public {
        properties[propertyId] = Property(name, msg.sender, price);
        emit PropertyRegistered(propertyId, name, price);
    }

    function transferOwnership(uint propertyId, address newOwner) public onlyOwner(propertyId) {
        properties[propertyId].owner = newOwner;
        emit PropertyTransferred(propertyId, newOwner);
    }

    function buyProperty(uint propertyId) public payable {
        Property memory property = properties[propertyId];
        require(msg.value == property.price, "Incorrect price");
        require(property.owner != msg.sender, "You already own this property");

        // Transfer funds to the previous owner
        payable(property.owner).transfer(msg.value);

        // Transfer ownership
        properties[propertyId].owner = msg.sender;
        emit PropertyTransferred(propertyId, msg.sender);
    }

    function getPropertyDetails(uint propertyId) public view returns (string memory, address, uint) {
        Property memory property = properties[propertyId];
        return (property.name, property.owner, property.price);
    }
}
