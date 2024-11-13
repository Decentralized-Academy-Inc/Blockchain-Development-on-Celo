pragma solidity ^0.5.10;

//send ether from smart contratc to address
contract sendEtherFromSmartContract {

//decalre address payab;e
address payable[] recipients;

//send ether
  function sendEther(address payable recipient) external{ //payab;e receives funds;
    recipient.transfer(1 ether); //transfer 1 ether from this contract to recipient


    //type casting
    address a;
    a = recipient;
    a.transfer(100); //wont work since it aont payable

    msg.sender.transfer(100);  //msg.sender is payable

    recipient.send(1 ether); //
  }

}
