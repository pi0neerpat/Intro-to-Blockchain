pragma solidity ^0.4.21;

import './strings.sol';

contract GameFactory {
//TO-DO: Checks equal number questions answers
address[] public deployedGames;
address public owner = msg.sender;

  function createGame(
    uint fee,
    string info,
    string questions,
    string answers
    )
    public
    {
    address newGame = new Game(
      msg.sender,
      fee,
      info,
      questions,
      answers
      );
    deployedGames.push(newGame);
  }

  function getDeployedGames() public view returns (address[]) {
      return deployedGames;
  }
}

contract Game {
    using strings for *; //Arachnid library declaration

    struct Player {
        string name;
        bool isRegistered;
        uint8 score;
        uint winnings;
        uint guessedThisRound;
    }

    struct Round {
        string question;
        string answer;
        bool started;
        bool complete;
    }

    // Game properties
    address public manager;
    uint public entryFee; // Wei
    string public description;
    mapping(address => Player) public players;
    Round[] public rounds;

    // Game logic
    uint public numPlayers;
    uint public numRounds;
    uint public highScore;
    address[] public winners;
    bool public hasStarted;
    bool public hasEnded;

    // Question/Answer logic
    string public currentQuestion;
    uint public currentRound;

    modifier onlyManager() {
        require(msg.sender == manager);  _; }

    constructor(address creator, uint fee, string info, string questions, string answers) public {
      manager = creator;
      entryFee = fee;
      description = info;

      var delim = ";".toSlice();
      numRounds = (questions.toSlice().count(delim) + 1);
      var q=questions.toSlice();
      var a=answers.toSlice();
      for(uint i = 0; i < numRounds; i++) {
          Round memory newRound = Round({
          question: q.split(delim).toString(),
          answer: a.split(delim).toString(),
          started: false,
          complete: false
          });
          rounds.push(newRound);
      }
    }

    /// Register using your name and pay the entry fee
    function register(string name) payable public {
        assert(msg.value >= entryFee);
        assert(!rounds[0].started);
        assert(!players[msg.sender].isRegistered);
        players[msg.sender].name = name;
        players[msg.sender].isRegistered = true;
        numPlayers++;

        // Return funds if the player overpayed
        uint overPaid = msg.value - entryFee;
        if (overPaid > 0) { msg.sender.transfer(overPaid); }
    }

    function startRound() onlyManager public {
      hasStarted = true;
        rounds[currentRound].started = true;
        currentQuestion = rounds[currentRound].question;
    }

    function guess(string thesis) public {
        // Ensure the player is registered and has not guessed this round
        assert(players[msg.sender].isRegistered);
        assert(players[msg.sender].guessedThisRound < currentRound+1);
        // Ensure the round is not over
        assert(rounds[currentRound].started == true);
        assert(rounds[currentRound].complete == false);

        players[msg.sender].guessedThisRound = currentRound +1;

        // Check guess & assign points
        if (keccak256(thesis) == keccak256(rounds[currentRound].answer)) {
            players[msg.sender].score++;
        }
        if (players[msg.sender].score > highScore) {
          delete winners;
          winners.push(msg.sender);
          highScore = players[msg.sender].score;
        } else if (players[msg.sender].score == highScore) { winners.push(msg.sender);}
    }

    function endRound() public onlyManager {
        rounds[currentRound].complete = true;
        currentRound++;
        if (currentRound >= numRounds) {
          endGame();
          }else{
            startRound();
          }
    }
    // Calculates the winner and assigns the grand prize
    //note: redundant with endRound()
    function endGame() onlyManager public {
        // error if winners.length is zero?
        hasEnded = true;
        uint prize = address(this).balance / winners.length;
        for (uint y = 0; y < winners.length; y++) {
          players[winners[y]].winnings = prize;
        }

    }
    // Requires the winner to withdraw their prize.
    // https://blog.ethereum.org/2016/06/10/smart-contract-security/
    function withdrawPrize() public {
        uint prize = players[msg.sender].winnings;
        assert(prize > 0); //throws exceptions for non-winners
        players[msg.sender].winnings = 0; // Set prize to 0, THEN transfer the winnings
        msg.sender.transfer(prize);
    }
    // Allows manager to steal all funds
    function reset() public onlyManager {
        manager.transfer(address(this).balance);
    }



    function getSummary() public view returns(address, string, uint, uint, uint, uint, bool, bool, uint, address[], uint, string) {
        return(
          manager,
          description,
          entryFee,
          address(this).balance,
          numPlayers,
          numRounds,
          hasStarted,
          hasEnded,
          highScore,
          winners,
          currentRound,
          currentQuestion
          );

    }

    function getPlayer(address player) public view returns(string, bool, uint8, uint, uint) {
        return(
          players[player].name,
          players[player].isRegistered,
          players[player].score,
          players[player].winnings,
          players[player].guessedThisRound
          );
    }

}
