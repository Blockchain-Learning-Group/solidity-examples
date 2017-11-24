pragma solidity ^0.4.15;

contract AttackeeContract {
  mapping (address => uint) public balances;

  event LogPut(address from, uint amount, uint currentBalance);
  event LogGet(address from, uint amount, uint currentBalance);
  event LogGetComplete(address from, uint amount, uint currentBalance);

  /// @dev put funds into contract
  function put() external payable {
    balances[msg.sender] = msg.value;
    LogPut(msg.sender, msg.value, this.balance);
  }

  /// @dev Allow users to withdraw funds securely
  /// Not vulnerable to reentrancy attack
  function get() external {
    uint amount = balances[msg.sender];
    require(amount > 0);

    delete balances[msg.sender];

    LogGet(msg.sender, amount, this.balance);
    msg.sender.transfer(amount);
    LogGetComplete(msg.sender, balances[msg.sender], this.balance);
  }
}
