## Challenges

1.  Make your own [personal token](https://github.com/jschiarizzi/solidity-simple-examples) (Exampletoken.sol)
2.  Splitter tool: Quickly split Ethereum among multiple addresses.
3.  More coming soon...

#### 1. Make your own personal Token

Deploy and use Exampletoken.sol from [this repo](https://github.com/jschiarizzi/solidity-simple-examples)

#### 2. Splitter Tool

**Writing**

1.  Copy the code from either `Splitter-tool-A.sol` (easy) or `Splitter-tool-B.sol` (harder)
- Navigate to our browser IDE [Remix](http://remix.ethereum.org)
- Create a new file named `splitter.sol`
- Paste in the contract code
- Complete the missing code in the function for Challenge A or B
- Compile to ensure there are no errors. _note: you will always get some warnings, please ignore_

> Need help? Check out the Solidity [cheat sheet](https://github.com/manojpramesh/solidity-cheatsheet) or the docs for [Solidity](https://solidity.readthedocs.io/en/latest/) and [Remix](https://remix.readthedocs.io/en/latest/)

**Testing**
1.  Switch to the 'Run' tab, and set the Environment to `Javascrtipt VM`
* Deploy the contract
* Under deployed contracts, open your contract to view the functions and variables.
* Copy the addresses from a few other accounts listed

![alt-text](https://github.com/blockchainbuddha/Intro-to-Blockchain/blob/master/Solidity%20Challenges/assets/example.png)

* Paste addresses into `setRecipients()` and submit. Be sure you use quotes on each individual address, and separate each address with a comma.
* Run `distributeFunds()`. Don't forget to set a value!

**Solution**

See the final solution in the Solutions folder, or
see the [Github repo](https://github.com/blockchainbuddha/Eth-Splitter-Tool)
