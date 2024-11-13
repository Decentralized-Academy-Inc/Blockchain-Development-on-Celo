pragma solidity ^0.5.11;

contract Struct {

//declare struct
  struct User {
    address addr;
    uint score;
    string name;
  }

  User[] users;
  mapping (address => User) userList2;

  function foo(string calldata _name) external {
    //add
    User memory user1 = User(msg.sender, 0, _name);
    User memory user2 = User(msg.sender, 0, _name);
    User memory user3 = User(name: _name, score: 0, addr: msg.sender);

    //read address of user 3
    user3.addr;

    //update
    user3.score - 20;

    //delete
    delete user1;


//mapping struct

//add new struct to mapping
    users.push(new User((msg.sender,0, _name)));
    users.push(user1);

//update
    userList2[msg.sender] = user2;
    userList2[msg.sender] = new User(msg.sender,0, _name);


  }

}
