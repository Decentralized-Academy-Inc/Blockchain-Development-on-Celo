pragma solidity ^0.5.11;

contract Mapping {

  //declare Mapping
mapping (address => uint) balances;
mapping (address => mapping (address => bool)) approved;
mapping (address => uint[]) scores;

function foo(address spender) external {
  //add element to Mapping
  balances[msg.sender] = 100;

  //read Mapping
  balances[msg.sender];

  //update
  balances[msg.sender] = 200;

  //delete
  delete balances[msg.sender];

  //default Values
  balances[someAddressThatDoesNotExist] => 0/false if value is bool

  //exotic mapping

  //add Values
  approved[msg.sender][spender] = true;

  //read Values
  approved[msg.sender][spender];

  //update value
  approved[msg.sender][spender] = false;

  //delete Values
  delete approved[msg.sender][spender];



//array inside Mapping CRUD
scores[msg.sender].push(1);

scores[msg.sender][0];

scores[msg.sender][0] = 10;

delete scores[msg.sender][0];

}

}
