pragma solidity ^0.5.10;


//use event to push data from smart contratc to front end
contract Event {

  event newTrade(
    uint indexed date,
    address indexed from,
    address indexed to,
    uint amount
  );


  function trade(address to, uint amount) external {
    emit NewTrade(now, msg.sender, to, amount);
  }


  //events cant be read from smart contract
  //events gas is lower


}
