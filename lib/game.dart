import 'dart:math';
import 'package:flutter/material.dart';
import 'package:tic_tac_toe/main.dart';

class GamePage extends StatefulWidget {
  final bool isSinglePlayer;
  final String player1Name;
  final String player2Name;

  GamePage({
    required this.isSinglePlayer,
    required this.player1Name,
    required this.player2Name,
  });

  @override
  _GamePageState createState() => _GamePageState();
}

class _GamePageState extends State<GamePage> {
  List<List<String>> gameBoard = List.generate(3, (_) => List.filled(3, ''));
  bool isPlayer1Turn = true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color.fromARGB(255, 241, 236, 236),
      body: Center(
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                padding: EdgeInsets.symmetric(vertical: 7.0, horizontal: 10),
                height: 50,
                width: 230,
                decoration: BoxDecoration(
                  color: Color.fromARGB(255, 71, 160, 233),
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Center(
                  child: Text(
                    widget.isSinglePlayer
                        ? 'Single Player Mode'
                        : 'Two Player Mode',
                    style: TextStyle(
                        color: Colors.white,
                        fontSize: 20,
                        fontWeight: FontWeight.bold),
                  ),
                ),
              ),
              SizedBox(height: 20),
              Text(
                'CURRENT TURN: ${isPlayer1Turn ? widget.player1Name : widget.player2Name}',
                style: TextStyle(fontSize: 16),
              ),
              SizedBox(height: 20),
              Container(
                padding:
                    EdgeInsets.only(top: 8, bottom: 8, right: 30, left: 30),
                child: GridView.builder(
                  shrinkWrap: true,
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 3,
                    mainAxisSpacing: 3.0,
                    crossAxisSpacing: 3.0,
                  ),
                  itemCount: 9,
                  itemBuilder: (context, index) {
                    int row = index ~/ 3;
                    int col = index % 3;
                    return GestureDetector(
                      onTap: () {
                        if (gameBoard[row][col].isEmpty) {
                          setState(() {
                            if (isPlayer1Turn) {
                              gameBoard[row][col] = 'X';
                            } else {
                              gameBoard[row][col] = 'O';
                            }
                            isPlayer1Turn = !isPlayer1Turn;
                          });
                          checkGameStatus();

                          if (widget.isSinglePlayer && !isPlayer1Turn) {
                            makeAiMove();
                          }
                        }
                      },
                      child: Container(
                        decoration: BoxDecoration(
                          border: Border.all(color: Colors.grey),
                        ),
                        child: Center(
                          child: Text(
                            gameBoard[row][col],
                            style: TextStyle(
                                fontSize: 40,
                                color: Color.fromARGB(255, 71, 160, 233)),
                          ),
                        ),
                      ),
                    );
                  },
                ),
              ),
              SizedBox(height: 20),
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                  primary: Color.fromARGB(255, 71, 160, 233),
                  onPrimary: Colors.white,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10.0),
                  ),
                ),
                onPressed: () {
                  setState(() {
                    gameBoard = List.generate(3, (_) => List.filled(3, ''));
                    isPlayer1Turn = true;
                  });
                },
                child: Text('Restart Game'),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void checkGameStatus() {
    for (int i = 0; i < 3; i++) {
      if (gameBoard[i][0] == gameBoard[i][1] &&
          gameBoard[i][0] == gameBoard[i][2] &&
          gameBoard[i][0].isNotEmpty) {
        showWinDialog(gameBoard[i][0]);
        return;
      }
    }

    // Check columns
    for (int i = 0; i < 3; i++) {
      if (gameBoard[0][i] == gameBoard[1][i] &&
          gameBoard[0][i] == gameBoard[2][i] &&
          gameBoard[0][i].isNotEmpty) {
        showWinDialog(gameBoard[0][i]);
        return;
      }
    }

    // Check diagonals
    if (gameBoard[0][0] == gameBoard[1][1] &&
        gameBoard[0][0] == gameBoard[2][2] &&
        gameBoard[0][0].isNotEmpty) {
      showWinDialog(gameBoard[0][0]);
      return;
    }
    if (gameBoard[0][2] == gameBoard[1][1] &&
        gameBoard[0][2] == gameBoard[2][0] &&
        gameBoard[0][2].isNotEmpty) {
      showWinDialog(gameBoard[0][2]);
      return;
    }

    // Check for draw
    bool isBoardFull = true;
    for (int i = 0; i < 3; i++) {
      for (int j = 0; j < 3; j++) {
        if (gameBoard[i][j].isEmpty) {
          isBoardFull = false;
          break;
        }
      }
    }
    if (isBoardFull) {
      showDrawDialog();
    }
  }

  void showWinDialog(String winner) {
    showDialog(
        context: context,
        builder: (context) => AlertDialog(
              backgroundColor: Color.fromARGB(255, 71, 160, 233),
              title: Text(
                '$winner wins!',
                style: TextStyle(
                  color: Colors.white,
                ),
              ),
              content: Text(
                'Congratulations!',
                style: TextStyle(
                  color: Colors.white,
                ),
              ),
              actions: [
                TextButton(
                  onPressed: () {
                    Navigator.of(context).pushAndRemoveUntil(
                      MaterialPageRoute(builder: (context) => FrontPage()),
                      (Route<dynamic> route) => false,
                    );
                  },
                  child: Text(
                    'Exit',
                    style: TextStyle(
                      color: Colors.white,
                    ),
                  ),
                ),
              ],
            ));
  }

  void showDrawDialog() {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        backgroundColor: Color.fromARGB(255, 71, 160, 233),
        title: Text('It\'s a draw!',
            style: TextStyle(
              color: Colors.white,
            )),
        content: Text('Play again?',
            style: TextStyle(
              color: Colors.white,
            )),
        actions: [
          TextButton(
            onPressed: () {
              Navigator.of(context).pop();
              setState(() {
                gameBoard = List.generate(3, (_) => List.filled(3, ''));
                isPlayer1Turn = true;
              });
            },
            child: Text(
              'Play Again',
              style: TextStyle(
                color: Colors.white,
              ),
            ),
          ),
        ],
      ),
    );
  }

  void makeAiMove() {
    int bestScore = -1000;
    late List<int> bestMove;

    for (int i = 0; i < 3; i++) {
      for (int j = 0; j < 3; j++) {
        if (gameBoard[i][j].isEmpty) {
          gameBoard[i][j] = 'O';
          int score = minimax(gameBoard, 0, false);
          gameBoard[i][j] = '';

          if (score > bestScore) {
            bestScore = score;
            bestMove = [i, j];
          }
        }
      }
    }

    setState(() {
      gameBoard[bestMove[0]][bestMove[1]] = 'O';
      isPlayer1Turn = true;
    });
    checkGameStatus();
  }

  int minimax(List<List<String>> board, int depth, bool isMaximizing) {
    int score = evaluate(board);

    if (score == 10 || score == -10) {
      return score;
    }

    if (!isMovesLeft(board)) {
      return 0;
    }

    if (isMaximizing) {
      int best = -1000;

      for (int i = 0; i < 3; i++) {
        for (int j = 0; j < 3; j++) {
          if (board[i][j].isEmpty) {
            board[i][j] = 'O';
            best = max(best, minimax(board, depth + 1, !isMaximizing));
            board[i][j] = ''; // Undo move
          }
        }
      }

      return best;
    } else {
      int best = 1000;

      for (int i = 0; i < 3; i++) {
        for (int j = 0; j < 3; j++) {
          if (board[i][j].isEmpty) {
            board[i][j] = 'X';
            best = min(best, minimax(board, depth + 1, !isMaximizing));
            board[i][j] = ''; // Undo move
          }
        }
      }

      return best;
    }
  }

  int evaluate(List<List<String>> board) {
    // Check rows
    for (int row = 0; row < 3; row++) {
      if (board[row][0] == board[row][1] && board[row][1] == board[row][2]) {
        if (board[row][0] == 'O') {
          return 10;
        } else if (board[row][0] == 'X') {
          return -10;
        }
      }
    }

    // Check columns
    for (int col = 0; col < 3; col++) {
      if (board[0][col] == board[1][col] && board[1][col] == board[2][col]) {
        if (board[0][col] == 'O') {
          return 10;
        } else if (board[0][col] == 'X') {
          return -10;
        }
      }
    }

    // Check diagonals
    if (board[0][0] == board[1][1] && board[1][1] == board[2][2]) {
      if (board[0][0] == 'O') {
        return 10;
      } else if (board[0][0] == 'X') {
        return -10;
      }
    }
    if (board[0][2] == board[1][1] && board[1][1] == board[2][0]) {
      if (board[0][2] == 'O') {
        return 10;
      } else if (board[0][2] == 'X') {
        return -10;
      }
    }
    return 0;
  }

  bool isMovesLeft(List<List<String>> board) {
    for (int i = 0; i < 3; i++) {
      for (int j = 0; j < 3; j++) {
        if (board[i][j].isEmpty) {
          return true;
        }
      }
    }
    return false;
  }
}
