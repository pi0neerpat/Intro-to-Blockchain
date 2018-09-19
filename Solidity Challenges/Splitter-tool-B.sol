pragma solidity ^0.4.6;

/// @title ETH-Splitter-Tool
/// @author Patrick Gallagher
///  This contract is used to send funds from the contract owner to many recipients
///  First, a list of addresses are sent to the contract. Next ETH is sent, which
///  will be divided evenly and sent to the recipients. In case of error, the
///  list of recipients can be reset, and funds returned to the owner.

contract Splitter {
   //address public recipientAddress;
   address public owner = msg.sender;
   address[] public recipientAddress;
   uint public numberRecipients;

   modifier onlyOwner() {
       require(msg.sender == owner);
       _;
   }

   function changeOwner(address _newOwner) onlyOwner {
       owner = _newOwner;
   }

   // Challenge Part A
   // Function should take an array of addresses and return true if successful
   function setRecipients(address[] a) onlyOwner returns (bool){
       // Add the address array to storage
       recipientAddress = a;

       // Add the number of recipient to storage
       numberRecipients = recipientAddress.length;
       return true;
   }

   // Challenge Part B
   function distributeFunds() payable onlyOwner returns (bool) {
        // First, make sure that some ETH is being sent.


       // Compute the amount to send to each recipient


       // Send the amount to each person.


       // (optional) Return any unspent funds
      

       return true;
   }

   // Fallback function allows payment to the contract
   // without distributing funds. Unsure if necessary...
   function() private payable onlyOwner { }

   // A view-only function to check recipientAddresses
   // Does not cost gas since contract storage is not modified
   function viewRecipients() view returns (address[]) {
       return (recipientAddress);
   }

   // Returns the contract balance to the owner, and deleted the recipient list
   function reset() onlyOwner {
       owner.transfer(this.balance);
       delete recipientAddress;
   }

   // kills this contract and sends remaining funds back to creator
   function kill() onlyOwner {
       selfdestruct(owner);
   }

}
