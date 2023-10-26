import 'package:flutter/material.dart';
import 'package:memoria/service/websocket_manager.dart';
import '../service/game_manager.dart';
import '../widgets/card_piece.dart';
import '../widgets/player_score.dart';

class GamePage extends StatefulWidget {
  final bool myTurn;
  const GamePage({super.key, required this.myTurn});

  @override
  State<GamePage> createState() => _GamePageState();
}

class _GamePageState extends State<GamePage> {

  GameManager gameManager = GameManager();
  WebSocketManager webSocketManager = WebSocketManager();

  int? rotatedPieceA;
  int? rotatedPieceAValue;
  int? rotatedPieceB;
  int? rotatedPieceBValue;

  int player1Score = 0;
  int player2Score = 0;

  bool myTurn = true;

  Set matches = Set();

  List<bool> matchedList = [
    false, false, false, false,
    false, false, false, false,
    false, false, false, false,
    false, false, false, false,
    false, false, false, false,
  ];

  @override
  void initState() {
    myTurn = widget.myTurn;
    super.initState();

    // webSocketManager.signCallback("my_selection", onMySelection);
    webSocketManager.signCallback("player_selection", onMySelection);
  }

  void onMySelection(dynamic values) {
    int index = values['index'], value = values['value'];
    if (rotatedPieceA == null) {
      setState(() {
        rotatedPieceA = index;
        rotatedPieceAValue = value;
      });
      return;
    }
    if (rotatedPieceB == null) {
      setState(() {
        rotatedPieceB = index;
        rotatedPieceBValue = value;
      });
      Future.delayed(const Duration(milliseconds: 1000), () {
        checkMatch();
        setState(() {
          rotatedPieceA = null;
          rotatedPieceAValue = null;
          rotatedPieceB = null;
          rotatedPieceBValue = null;
        });
      });
    }
  }

  int? getValue(int index) {
    if (index == rotatedPieceA) {
      return rotatedPieceAValue;
    }
    if (index == rotatedPieceB) {
      return rotatedPieceBValue;
    }
    return null;
  }

  rotatePiece(int index) {
    // if not my turn return
    // emit select piece
    if (!myTurn) {
      return;
    }
    if (index == rotatedPieceA || index == rotatedPieceB) {
      return;
    }
    webSocketManager.emit("selection", index);
  }

  checkMatch() {
    if (rotatedPieceAValue == rotatedPieceBValue) {

      setState(() {
        matchedList[rotatedPieceA!] = true;
        matchedList[rotatedPieceB!] = true;
        if (myTurn) {
          player1Score++;
        } else {
          player2Score++;
        }
      });
    }
    myTurn = !myTurn;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          PlayerScore(isTop: true, score: player1Score,),
          Center(child: gameGrid()),
          PlayerScore(isTop: false, score: player2Score),
        ],
      ),
    );
  }

  Widget gameGrid() {
    List<Widget> rowList = []; 
    for (var i = 0; i < 5; i++) {
      List<Widget> cardList = [];
      for (var j = 0; j < 4; j++) {
        int index = i*4+j;
        int? value = getValue(index);
        bool isRotated = index == rotatedPieceA || index == rotatedPieceB;
        cardList.add(
          CardPiece(
            index: index,
            value: value, 
            isRotated: isRotated, 
            rotatePiece: rotatePiece,
            matched: matchedList[index],
          )
        );
      }
      rowList.add(
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: cardList,
        )
      );
    }
    return Column(
      children: rowList,
    );
  }
}