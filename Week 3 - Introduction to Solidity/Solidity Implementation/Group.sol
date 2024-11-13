pragma solidity ^0.5.10;

import "Users.sol";

contract Group is Users {

  uint public groupCount = 0;
  string public name = "Group";

  mapping (uint => Group) groups;
  mapping (address => Transactioned[]) deposits;

  //membership
  mapping (uint => (address => address)) members;

  struct Group {
    string _groupid;
    string pic,
    string title;
    string summary;
    address publisher;
    uint goal;
    uint contribution;
  }

  //constructor
  constructor() public {

  }

  event GroupCreated (
    string _groupid,
    string pic,
    string title,
    string summary,
    address publisher,
    uint goal,
    uint contribution
  )

  function createGroup(string memory _pic, string memory _title, uint memory _goal, uint memory _contribution) {
    // Increment Group ID
    groupCount++;

    //ENSURE GROUP DOES NOT exists
    require(!groups[groupCount]);

    //SAVE GROUP DETAILS IN THE MAP
    groups[groupCount] = Group(_groupid, _pic, _title, _summary, msg.sender, _goal, 0);

    //EVENT TRIGGER
    emit GroupCreated(_groupid, _pic, _title, _summary, msg.sender, _goal, _contribution);

    //ADD ADMIN IN MEMBERS MAPPING
    joinGroup(groupCount);

  }

  modifier OnlyAdmin (uint memory _groupid) {
    require(msg.sender == groups[_groupid].publisher);
    _;
  }

}
