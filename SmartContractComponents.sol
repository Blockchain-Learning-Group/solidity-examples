pragma solidity ^0.4.14;

contract ComponentBreakdown {
    // Contract storage
  	string public storageString = 'hello world';

  	// Events
  	event LogAnEvent(uint eventParam);

  	/// @dev Contract constructor
  	function ComponentBreakdown() { }

  	/// @dev Contract fallback
  	function () payable { }

  	// Methods
  	/// @dev Example of an external payable.
    // @return Return the ether balance of this contract.
  	function examplePayable()
  		external // Visibility
      payable // May receive ether
  		returns (uint returnParam) // Return type and parameter name
  	{
      LogAnEvent(this.balance); // Emit an event
  		returnParam = this.balance;
  	}

    /// @dev Example of a private constant.
    // @return Return the current block number
  	function exampleConstant()
      private // Visibility
      constant // May not update state
  		returns (uint) // Return type without parameter name
  	{
  		return block.number;
  	}
}
