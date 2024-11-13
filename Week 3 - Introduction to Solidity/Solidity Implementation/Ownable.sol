pragma solidity ^0.5.10;

abstract contract Ownable {

  modifier onlyAdmin(address userid) {
    require(msg.sender == admin, "Only Admin can manage Group");
    _;
  }

  modifier onlyMembers(address _userid) {
    require(msg.sender == _userid, "Only Members can participate");
    _;
  }

}
