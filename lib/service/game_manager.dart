import 'dart:math';

class GameManager {
  List<int>  pieces = [];

  int size = 10;

  int player1Score = 0;
  int player2Score = 0;

  bool isPlayer1 = true;

  int? playerSelectionA;
  int? playerSelectionB;

  GameManager() {
    for (var i = 0; i < 2*size; i++) {
      pieces.add(i%size);
    }
    shuffle();
  }

  shuffle() {
    for (var i = 0; i < pieces.length; i++) {
      int n = Random().nextInt(pieces.length);
      int temp = pieces[i];
      pieces[i] = pieces[n];
      pieces[n] = temp;
    }
  }

  int getPieceAt(int index) {
    return pieces[index]; 
    
  }

  int? selectPieceAt(int index) {
    if (pieces[index] == 0) {
      return null;
    }
    if (playerSelectionA == null) {
      playerSelectionA = index;
      return pieces[index];
    }
    if (playerSelectionB == null) {
      playerSelectionB = index;
      int val = pieces[index];
      _checkMatch();
      updateScore();
      isPlayer1 = !isPlayer1;
      return val;
    }
  }

  void _checkMatch() {
    if (playerSelectionA == null || playerSelectionB == null) {
      return;
    }
    bool match = pieces[playerSelectionA!] == pieces[playerSelectionB!];
    if (match) {
      pieces[playerSelectionA!] = 0;
      pieces[playerSelectionB!] = 0;
    }
    playerSelectionA = null;
    playerSelectionB = null;
  }

  void updateScore() {
    if (isPlayer1) {
      player1Score++;
    } else {
      player2Score++;
    }
  }
}