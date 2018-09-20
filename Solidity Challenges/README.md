## Challenges

1.  Make your own [personal token](https://github.com/jschiarizzi/solidity-simple-examples) (Exampletoken.sol)
2.  Splitter tool: Quickly split Ethereum among multiple addresses.
3.  More coming soon...

#### 1. Make your own personal Token

Deploy and use Exampletoken.sol from [this repo](https://github.com/jschiarizzi/solidity-simple-examples)

#### 2. Splitter Tool

**Writing**

1.  Copy the code from either `Splitter-tool-A.sol` (easy) or `Splitter-tool-B.sol` (harder)
2. Navigate to our browser IDE [Remix](http://remix.ethereum.org)
3. Create a new file named `splitter.sol`
4. Paste in the contract code
5. Complete the missing code in the function for Challenge A or B
6. Compile to ensure there are no errors. _note: you will always get some warnings, please ignore_

> Need help? Check out the Solidity [cheat sheet](https://github.com/manojpramesh/solidity-cheatsheet) or the docs for [Solidity](https://solidity.readthedocs.io/en/latest/) and [Remix](https://remix.readthedocs.io/en/latest/)

**Testing**
1.  Switch to the 'Run' tab, and set the Environment to `Javascrtipt VM`
2. Deploy the contract
3. Under deployed contracts, open your contract to view the functions and variables.
4. Copy the addresses from a few other accounts listed

![alt-text](https://github.com/blockchainbuddha/Intro-to-Blockchain/blob/master/Solidity%20Challenges/assets/example.png)

5. Paste at least 2 different addresses into `setRecipients()`. The function expects `address[]` so use the following formatting:
`["0xabc1234","0xcdba4321"]`.
6. Submit, but be sure you are using the account which was used to deploy the contract. The `onlyOwner` modifier prevents other accounts from using this function. [modifiers explained](https://solidity.readthedocs.io/en/develop/miscellaneous.html?highlight=pure#modifiers)
7. Set value to 1 Ether, and run `distributeFunds()`.
8. Check balances of the recipient accounts to see if you were successful. If so, great job!

**Solution**

See the final solution in the Solutions folder, or
see the [Github repo](https://github.com/blockchainbuddha/Eth-Splitter-Tool)
