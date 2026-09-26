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


/// the main method where the functions are used
void main() {
  print("==== ROCK, PAPER, SCISSORS ====");
  List<String> playerNames = getPlayerNames();
}