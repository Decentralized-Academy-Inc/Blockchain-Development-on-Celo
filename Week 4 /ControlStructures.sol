pragma solidity ^0.5.11;

contract ControlStructures {

  bool boolValue

  function foo() external {
    if(msg.value >= 100 && block.timestamp > 1234567){

    }else{

    }
  }

  function forLoop() external {
    for(uint i = 0; i < 10; i++){

    }
  }

  function whileLoop() external {
    bool isOk = true;
    while(isOk==true){
      if(){
        isOk = false;
        continue;

        or

        break;
      }
    }
  }

}
