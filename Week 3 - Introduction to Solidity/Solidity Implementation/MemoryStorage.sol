pragma solidity ^0.5.10;

contract MemoryStorage {

  //storage :store variable inside the blockchain

  uint a;

  struct User {
    string name;
  }
  User[] users;

  function foo() external {
    User memory user = users[0];
    user.name = "Allan";
    bar(user)
  }

  function bar(User memory users) internal {

  }

  //STACK MEMORY LOCATION
  function stackFoo() external {
    uint b;
  }

  //calldata : available for function that are exither external or
  function fooCall(uint[] calldata _users) external {
    uint b;
  }

}
