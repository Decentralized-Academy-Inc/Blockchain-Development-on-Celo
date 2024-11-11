mapping(address => uint256) public balances;

function setBalance(address _user, uint256 _balance) public {
    balances[_user] = _balance;
}
