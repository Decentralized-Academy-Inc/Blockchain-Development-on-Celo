pragma solidity ^0.5.11;

contract MyContract {

  //1. storage arrays
uint[] users; //dynamic size Memory array
uint[8] clients; //fixed size array

//CRUD

//add element to arrays
function addItem() external {
  users.push(2);

  //read element via index
  users[0];

  //updating an element
  users[0] = 20;

  //delete operation
  delete users[0];


  //iterate values of an arrays
  for(uint i = 0;i< users.length: i++){
    users[i];
  }
}

  //2. Memory arrays (Temporary)
  function bar() external {
    uint[] memory newArray = new uint[](10);

    //CRUD

    //add value
    newArray[0] = 7;

    //read value
    newArray[0];

    //update
    newArray[0] = 200;

    delete.newArray[0];
  }


  //3 array arguments and return array from function
  function fooBar(uint[] memory myArg) external returns (uint[] memory) {

  }

}
