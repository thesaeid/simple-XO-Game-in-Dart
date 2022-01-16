import 'dart:io';

// Print the Frame in the console
void PrintFrame(array, scores, round) {
  stdout.writeln(
      "Scores Are: X: ${scores['X']} , O: ${scores['O']}\n------------------------");
  stdout.writeln("\n=== Round: $round === ");
  stdout.write("\n-------------\n");
  for (var i = 0; i < array.length; i++) {
    if (i % 3 == 0 && i != 0) {
      stdout.writeln("|");
      stdout.write("-------------\n");
    }

    stdout.write("| ${array[i]} ");
  }
  stdout.write("|\n");
  stdout.write("-------------\n\n");
}

// Change Players Turn
String ChangeTurn(turn) {
  if (turn == "X") {
    return "O";
  } else {
    return "X";
  }
}

// Get inputs from user and checks if it's valid
int GetInput() {
  var valid_choices = ['1', '2', '3', '4', '5', '6', '7', '8', '9'];

  stdout.write("\nChoose from (1-9): ");
  var input = stdin.readLineSync();

  while (!valid_choices.contains(input)) {
    stdout.write("\n    Enter a valid number in range of (1 to 9): ");
    input = stdin.readLineSync();
  }

  var index = int.tryParse(input ?? '0');
  if (index == null || index < 1 || index > 9) {
    stdout.writeln("\n Invalid input");
  }
  return index ?? 1;
}

// cha=eck if an index is empty or not
bool CheckIndex(array, index) {
  if (array[index - 1] != "\$") {
    return false;
  } else {
    return true;
  }
}

// Control the Game Flow
void GameManager(array, turn, scores, round, playerRounds) {
  var index;
  while (true) {
    if (WinOrTie(array) == "Tie") {
      stdout.writeln("\nGame is Tie");
      array = new List.filled(9, '\$');

      if (scores['X'] + scores['O'] == playerRounds) {
        stdout.writeln("\nGame is Over\n");
        if (scores['X'] == scores['O']) {
          stdout.writeln("\nGame is Tie.\n");
        }
        break;
      }
    } else if (WinOrTie(array) == "X" || WinOrTie(array) == "O") {
      scores[WinOrTie(array)]++;
      round++;
      stdout.writeln("\nPlayer ${WinOrTie(array)} won this round.\n");

      array = new List.filled(9, '\$');
      if (scores['X'] + scores['O'] == playerRounds) {
        stdout.writeln("\nGame is Over\n");
        if (scores['X'] > scores['O']) {
          stdout.writeln("\nPlayer X won the game\n");
        } else {
          stdout.writeln("\nPlayer O won the game\n");
        }
        break;
      }
    } else {
      index = GetInput();
      if (CheckIndex(array, index)) {
        array[index - 1] = turn;

        print(Process.runSync("clear", [], runInShell: true)
            .stdout); // clear screen

        PrintFrame(array, scores, round);
        turn = ChangeTurn(turn);
        stdout.writeln("Player ${turn}'s turn");
      }
    }
  }
}

// Checks if the game is over
String WinOrTie(array) {
  if (array[0] == array[1] && array[1] == array[2] && array[0] != "\$") {
    return array[0];
  } else if (array[3] == array[4] && array[4] == array[5] && array[3] != "\$") {
    return array[3];
  } else if (array[6] == array[7] && array[7] == array[8] && array[6] != "\$") {
    return array[6];
  } else if (array[0] == array[3] && array[3] == array[6] && array[0] != "\$") {
    return array[0];
  } else if (array[1] == array[4] && array[4] == array[7] && array[1] != "\$") {
    return array[1];
  } else if (array[2] == array[5] && array[5] == array[8] && array[2] != "\$") {
    return array[2];
  } else if (array[0] == array[4] && array[4] == array[8] && array[0] != "\$") {
    return array[0];
  } else if (array[2] == array[4] && array[4] == array[6] && array[2] != "\$") {
    return array[2];
  } else if (array.contains("\$") == false) {
    return "Tie";
  }
  return '';
}

void main() {
  while (true) {
    print(
        Process.runSync("clear", [], runInShell: true).stdout); // clear screen
    var array = new List.filled(9, '\$');
    var turn = "X";
    var scores = {'X': 0, 'O': 0};
    var answer;
    var round = 1;
    var playerRounds;
    stdout.write("How many rounds do you want to play? ");
    playerRounds = stdin.readLineSync();
    playerRounds = int.parse(playerRounds);
    print(
        Process.runSync("clear", [], runInShell: true).stdout); // clear screen
    PrintFrame(array, scores, round);
    stdout.writeln("Player $turn's turn");
    GameManager(array, turn, scores, round, playerRounds);
    stdout.write("\n Do you want to play again? (Y/N): ");
    answer = stdin.readLineSync();
    if (answer == "N" || answer == "n") {
      break;
    }
  }
}
