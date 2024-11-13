pragma solidity ^0.5.10;

import "ContractB.sol"

contract callFunctionOrSmart {


  //call function of another smart contratc

  address addressB; 

  function setAddressB(address _addressB) external {
    addressB = _addressB;
  }

  function callHelloWorld()  view returns (string memory) {
    B b = B(addressB);
    return b.helloWorld();
  }



}


}
