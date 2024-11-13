pragma solidity ^0.5.10;

contract InterfaceB {
  function helloWorld() external pure returns (string memory);

}
contract B {

function helloWorld() external pure returns (string memory) {
  return 'Hello World';
}
