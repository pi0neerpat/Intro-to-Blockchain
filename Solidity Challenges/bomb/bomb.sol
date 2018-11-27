pragma solidity ^0.4.25;

contract bomb {
    // -------------------------------------------------------------------------
    // Setup
    // -------------------------------------------------------------------------
    uint8 private answerToPuzzle9;
    address[] public players;
    uint public numberOfPlayers;
    bool public bombDefused = false;

    mapping (address => bool) public isPlaying;
    mapping (address => string) public playersName;
    mapping (address => uint256) public playersScores;
    mapping (address => mapping (uint256 => bool)) public completedPuzzles;
    mapping (address => bool) private isRedLightFlashing;

    string secretCode = "boop";

    // -------------------------------------------------------------------------
    // Constructor
    // -------------------------------------------------------------------------
    constructor() public {
        // 🤔
        answerToPuzzle9 = uint8(keccak256(block.blockhash(block.number - 1), now));
    }

    // -------------------------------------------------------------------------
    // Modifers
    // -------------------------------------------------------------------------
    modifier onlyPlayers() {
        require(isPlaying[msg.sender]);
        _;
    }

    modifier onlyNewPlayers() {
        require(!isPlaying[msg.sender]);
        _;
    }

    modifier solvedAllPuzzles() {
        require(playersScores[msg.sender] >= 11000);
        _;
    }


    // -------------------------------------------------------------------------
    // Winning Condition
    // -------------------------------------------------------------------------
    function defuseBomb() onlyPlayers solvedAllPuzzles public {
        require(bombDefused == false);
        playersScores[msg.sender] += 15000;
        bombDefused = true;
    }


    // -------------------------------------------------------------------------
    // Puzzles
    // -------------------------------------------------------------------------
    function puzzle01() onlyPlayers public {
        require(hasCompletedPuzzle(1) == false);
        setPuzzleAsCompleted(msg.sender, 1);
    }

    function puzzle02() onlyPlayers payable public {
        require(hasCompletedPuzzle(2) == false);
        require(msg.value == 1 ether);
        msg.sender.transfer(address(this).balance); // transfer ALL ether in contract to the msg.sender
        setPuzzleAsCompleted(msg.sender, 2);
    }

    function puzzle03() onlyPlayers payable public {
        require(hasCompletedPuzzle(3) == false);
        require(msg.value == 1 finney);
        msg.sender.transfer(address(this).balance); // transfer ALL ether in contract to the msg.sender
        setPuzzleAsCompleted(msg.sender, 3);
    }

    function puzzle04() onlyPlayers public {
        require(hasCompletedPuzzle(4) == false);
        require(isRedLightFlashing[msg.sender]);
        setPuzzleAsCompleted(msg.sender, 4);
    }

    function puzzle05() onlyPlayers public  {
        require(hasCompletedPuzzle(5) == false);
        // setPuzzleAsCompleted(msg.sender, 5);   ????
    }


    function puzzle06(uint256 n) onlyPlayers public {
        require(hasCompletedPuzzle(6) == false);
        require(n != 1);
        if(uint8(n) + 1 ==  2) {
            setPuzzleAsCompleted(msg.sender, 6);
        }
    }


    function puzzle07(string _passphrase) onlyPlayers public {
        require(hasCompletedPuzzle(7) == false);
        require(keccak256(secretCode) == keccak256(_passphrase));
        setPuzzleAsCompleted(msg.sender, 7);
    }

    function puzzle08(uint8 n) onlyPlayers public {
        require(hasCompletedPuzzle(8) == false);
        bytes32 secretNumberHash = 0x1dcc4de8dec75d7aab85b567b6ccd41ad312451b948a7413f0a142fd40d49347;
        require(keccak256(n) == secretNumberHash);
        setPuzzleAsCompleted(msg.sender, 8);
    }

    function puzzle09(uint8 n) onlyPlayers public {
        require(hasCompletedPuzzle(9) == false);
        require(n == answerToPuzzle9);
        setPuzzleAsCompleted(msg.sender, 9);
    }

    function puzzle10(address _addressToReward) public {
        require(completedPuzzles[_addressToReward][10] == false);
        require(checkForSomething(msg.sender));
        setPuzzleAsCompleted(_addressToReward, 10);
    }

    function puzzle11() onlyPlayers public payable {
        require(hasCompletedPuzzle(11) == false);
        require(address(this).balance > 0);
        msg.sender.transfer(address(this).balance);
        setPuzzleAsCompleted(msg.sender, 11);
    }

    // -------------------------------------------------------------------------
    // Helpers & Hints
    // -------------------------------------------------------------------------
    function _register(string _userName) onlyNewPlayers public {
        bytes memory userName = bytes(_userName);
        require(userName.length > 0);
        numberOfPlayers++;
        isPlaying[msg.sender] = true;
        playersName[msg.sender] = _userName;
        players.push(msg.sender);
    }

    function _cutTheRedWire() onlyPlayers public {
        require(playersScores[msg.sender] > 0);
    }

    // This is used to check if the address is --REDACTED--
    function checkForSomething(address _addr) internal returns (bool){
        uint32 size;
        assembly { size := extcodesize(_addr) }
        return (size > 0);
    }

    // Game helper functions - returns the player score of the caller
    function getScore() onlyPlayers public view returns (uint256) {
        return playersScores[msg.sender];
    }

    function _cutTheBlueWire(bool choice) onlyPlayers public {
        isRedLightFlashing[msg.sender] = choice;
    }

    // Game helper functions - returns the contracts ETH balance
    function getBalance() public view returns (uint256) {
        return address(this).balance;
    }

    // Game helper functions - for the provided puzzle, returns if its been COMPLETED by the caller address
    function hasCompletedPuzzle(uint256 puzzleNumber) internal returns (bool) {
        return completedPuzzles[msg.sender][puzzleNumber];
    }

    function _cutTheGreenWire() onlyPlayers public {
        if (completedPuzzles[msg.sender][5] == false && completedPuzzles[msg.sender][6] == true) {
            setPuzzleAsCompleted(msg.sender, 5);
        }
    }

    // Game helper functions - sets the provided puzzle as COMPLETED for the provided address
    function setPuzzleAsCompleted(address _addressToReward, uint256 puzzleNumber) internal {
        completedPuzzles[_addressToReward][puzzleNumber] = true;
        playersScores[_addressToReward] += 1000;
    }

    // HINT: This would have allowed money to be -easily- sent to this contract
    // function () external payable { }
}
