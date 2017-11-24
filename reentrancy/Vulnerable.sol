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

  /// @dev Allow users to withdraw funds
  /// Insecure method to be attacked
  function get() external {
    LogGet(msg.sender, balances[msg.sender], this.balance);
    msg.sender.call.value(balances[msg.sender])();
    LogGetComplete(msg.sender, balances[msg.sender], this.balance);

    // Balance is zerod only after the funds have been set
    delete balances[msg.sender];
  }
}
