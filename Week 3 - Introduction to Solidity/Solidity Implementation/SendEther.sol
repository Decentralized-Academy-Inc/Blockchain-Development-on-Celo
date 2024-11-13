pragma solidity ^0.5.10;

//send ether to solidity smart contract
//PAYABLE KEYWORD indicates that a function can accept ether
//the function should be non view
contract SendEther {

  mapping (address => uint) balances;

function invest() external payable {
  if(msg.value < 1000){
    revert(); //cancel the transaction
  }
  balances[msg.sender] += msg.value;  //how much ether was sent by each address
}

function balance() external view returns (uint) {
  returns address(this).balance;  //this => smart contract
}



}
