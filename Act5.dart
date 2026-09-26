import "dart:io";

/// gets the players name and it will use default name if the user input is null 
List<String> getPlayerNames() {
  stdout.write("Enter Player 1 name: ");
  String? enterPlayerOne = stdin.readLineSync();
  String playerOneName = (enterPlayerOne == null || enterPlayerOne.trim().isEmpty) ? "Player 1" : enterPlayerOne.trim();

  stdout.write("Enter Player 2 name: ");
  String? enterPlayerTwo = stdin.readLineSync();
  String playerTwoName;

  if (enterPlayerTwo == null || enterPlayerTwo.trim().isEmpty) {
    print("No name entered. Using \"Player 2\".");
    playerTwoName = "Player 2";
  } else {
    playerTwoName = enterPlayerTwo.trim();
  }

  return [playerOneName, playerTwoName];
}

/// gets a move from each player and return
List<String> getPlayerMoves(String playerOneName, String playerTwoName) {

  String? playerOneEntryMove;
  String? playerOneMove;

  do {
    stdout.write("$playerOneName, enter your move (rock, paper, scissors): ");
    playerOneEntryMove = stdin.readLineSync();
    playerOneMove = validateMove(playerOneEntryMove);
  } while (playerOneMove == null);

  String? playerTwoEntry;
  String? playerTwoMove;

  do {
    stdout.write("$playerTwoName, enter your move (rock, paper, scissors): ");
    playerTwoEntry = stdin.readLineSync();
    playerTwoMove = validateMove(playerTwoEntry);
  } while (playerTwoMove == null);

  return [playerOneMove, playerTwoMove];
}

/// it validates moves of the player and it returns invalid if the move is null 
String? validateMove(String? move) {
  List<String> validMoves = ["rock", "paper", "scissors"];

  if (move == null || !validMoves.contains(move.trim().toLowerCase())) {
    print("Invalid move. Please enter rock, paper, or scissors.");
    return null;
  }

  return move.trim().toLowerCase();
}


/// Runs the rounds and keeps track of each player's score.
List<int> playGame(String playerOneName, String playerTwoName) {
  int pOneScore = 0;
  int pTwoScore  = 0;
  int roundNumber = 1;
  bool playAgain;

  do {
    print("");
    print("--- Round $roundNumber ---");

    List<String> playerMoves = getPlayerMoves(playerOneName, playerTwoName);
    print("");
    print("$playerOneName chose ${playerMoves[0]}. "
        "$playerTwoName chose ${playerMoves[1]}.");

    String? winner;
    
    if (playerMoves[0] == playerMoves[1]) {
      winner = null;
    } else if ((playerMoves[0] == "rock" && playerMoves[1] == "scissors") ||
        (playerMoves[0] == "paper" && playerMoves[1] == "rock") ||
        (playerMoves[0] == "scissors" && playerMoves[1] == "paper")) {
      winner = "$playerOneName wins the round!";
      pOneScore++;
    } else {
      winner = "$playerTwoName wins the round!";
      pTwoScore++;
    }

    print("Result: ${winner ?? "It's a draw!"}");

    print("Score -> $playerOneName: $pOneScore | "
        "$playerTwoName: $pTwoScore");

    String? replayInput;
    String replayChoice;

    do {
      stdout.write("Play again? (y/n): ");
      replayInput = stdin.readLineSync();
      replayChoice = (replayInput ?? "n").trim().toLowerCase();

      if (replayChoice != "y" && replayChoice != "n") {
        print("Please enter y or n.");
      }
    } while (replayChoice != "y" && replayChoice != "n");

    playAgain = replayChoice == "y";
    roundNumber++;
  } while (playAgain);

  return [pOneScore, pTwoScore];
}



/// the main method where the functions are used
void main() {
  print("==== ROCK, PAPER, SCISSORS ====");
  List<String> playerNames = getPlayerNames();

  
  List<int> finalScores = playGame(playerNames[0], playerNames[1]);

  int pOneScore = finalScores[0];
  int pTwoScore = finalScores[1];

  
  print("");
  print("==== FINAL SCORE ====");
  print("${playerNames[0]}: $pOneScore | "
      "${playerNames[1]}: $pTwoScore");

  if (pOneScore > pTwoScore) {
    print("Overall winner: ${playerNames[0]}");
  } else if (pTwoScore > pOneScore) {
    print("Overall winner: ${playerNames[1]}");
  } else {
    print("Overall result: Tie!");
  }
}