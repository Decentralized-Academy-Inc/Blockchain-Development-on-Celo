pragma solidity ^0.5.10;

import "Group.sol";

//CONTRACT
contract User is Group {

//CONTRACT NAME
  string public name = "Users";

//USERS MODEL
  struct User {
    address userid;
    string name;
    string pic;
    string phone;
  }

//STORE USERS
  mapping (address => User) users;

//GROUPS RESPECTIVE USERS BELONG IN
  mapping (address => (uint => uint)) membership;

//RESPECTIVE USER DEPOSITS PER GROUP
  mapping (address => (uint => uint)) deposits;

//RESPECTIVE GROUP CONTRIBUTIONS PER USERS
  mapping (uint => (address => uint)) contributions;

//CREATE EVENT
  event userCreated(
    address userid,
    string name;
    string pic,
    string phone,
  )

//constructor
  constructor() public {

  }

//CREATE NEW USER
  function createUser(string memory _name, string memory _pic, string memory _phone) public {
    //ENSURE USER DOESNT exists
    require(!users[msg.sender]);

    // Make sure the _pic exists
    require(bytes(_pic).length > 0);

    // Make sure  _phone exists
    require(bytes(_phone).length > 0);

    // Make sure  _name exists
    require(bytes(_name).length > 0);

    // Make sure uploader address exists
    require(msg.sender!=address(0));

    //adding new user to USER
    users[msg.sender] = User(msg.sender, _name, _pic, _phone);

    //event emit
    emit userCreated(msg.sender, _name, _pic, _phone);

  }

//JOIN SAVINGS GROUP
  function joinGroup(uint memory _groupid) public {
    //ENSURE USER ISNT A MEMBER ALREADY
    require(!members[msg.sender][_groupid]);
    //require details are not empty

    membership[msg.sender][_groupid] = _groupid;

    members[_groupid][msg.sender] =  msg.sender;

  }

//FETCH USER DETAILS
  function fetchUserDetails (address memory userid) returns (address memory _userid, string memory _name, string memory _pic, string memory _phone) {
    _userid = users[userid].id;
    _name = users[userid].name;
    _pic = users[userid].pic;
    _phone = users[userid].phone;
  }

  modifier UserIsMember(uint memory __groupid) {
    require(msg.sender)
  }

  modifier OnlyAdmin (uint memory _groupid) {
    require(msg.sender == groups[_groupid].publisher);
    _;
  }

//DEPOSIT MONEY IN GROUP
  function deposit(uint memory _groupid) {

    //CHECK IF USER IS AMONG GROUP MEMBERS
    require(members[msg.sender][_groupid]);

    groups[_groupid].contributions = groups[_groupid].contributions + msg.value;

    deposits[msg.sender][_groupid] = deposits[msg.sender][_groupid] + msg.value;

    contributions[_groupid][msg.sender] = contributions[_groupid][msg.sender] + msg.value;

  }
}
