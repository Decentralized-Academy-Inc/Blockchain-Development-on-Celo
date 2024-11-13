pragma solidity ^0.5.10;

contract Enum {

  enum STATE {
    INACTIVE,
    ACTIVE,
    PRO,
    CANCELLED
  }

  STATE state;
  struct User {
    STATE state;
  }

  function setToActive() external {
    state = STATE.ACTIVE;
  }

  function foo() external {
    if(state == STATE.ACTIVE){

    }
  }

  function bar(STATE _state) {

  }


}
