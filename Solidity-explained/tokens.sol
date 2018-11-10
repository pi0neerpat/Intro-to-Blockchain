pragma solidity ^0.4.19;


contract Exampletoken{

address owner; //who should get our tokens to begin with?
mapping (address => uint256) public balances;

    constructor () public {
    owner = msg.sender; //msg.sender is special
    //here, msg.sender is the account that deployed the contract
    balances[owner] = 50000;
    }

    function transfer(uint amount, address recipient) public {

    require(balances[msg.sender] >= amount);
    require(balances[msg.sender] - amount <= balances[msg.sender]);
    require(balances[recipient] + amount >= balances[recipient]);

    balances[msg.sender] -= amount;
    balances[recipient] += amount;

    //Once this has been deployed, it can never be updated.
    //but the transfer function can
    }

}
