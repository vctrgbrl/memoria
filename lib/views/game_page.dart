import 'package:flutter/material.dart';
import 'package:memoria/service/skin_type.dart';
import 'package:memoria/service/websocket_manager.dart';
import '../service/game_manager.dart';
import '../widgets/card_piece.dart';
import '../widgets/player_score.dart';

enum GameType {
  single,
  localMulti,
  onlineMulti
}

class GamePage extends StatefulWidget {
  final bool? myTurn;
  final GameType gameType;
  const GamePage({super.key, this.myTurn, required this.gameType});

  @override
  State<GamePage> createState() => _GamePageState();
}

class _GamePageState extends State<GamePage> {

  GameManager gameManager = GameManager();
  WebSocketManager webSocketManager = WebSocketManager();
  SkinManager skinManager = SkinManager();

  int? rotatedPieceA;
  int? rotatedPieceAValue;
  int? rotatedPieceB;
  int? rotatedPieceBValue;

  int player1Score = 0;
  int player2Score = 0;

  int nTurnos = 0;
  int nMatches = 0;

  bool myTurn = true;

  Set matches = Set();

  List<int> matchedList = [
    -1, -1, -1, -1,
    -1, -1, -1, -1,
    -1, -1, -1, -1,
    -1, -1, -1, -1,
    -1, -1, -1, -1,
  ];

  @override
  void initState() {
    myTurn = widget.myTurn ?? true;
    super.initState();
    skinManager.refreshImages();

    // webSocketManager.signCallback("my_selection", onMySelection);
    if (widget.gameType == GameType.onlineMulti) {
      webSocketManager.signCallback("player_selection", onPlayerSelection);
    }
  }

  void onPlayerSelection(dynamic values) {
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
    if (matchedList[index] >= 0) {
      return matchedList[index];
    }
    return null;
  }

  rotatePiece(int index) {
    if (matchedList[index] >= 0) {
      return;
    }
    // if not my turn return
    // emit select piece
    if (widget.gameType == GameType.onlineMulti && !myTurn) {
      return;
    }
    if (index == rotatedPieceA || index == rotatedPieceB) {
      return;
    }

    switch (widget.gameType) {
      case GameType.onlineMulti:
        webSocketManager.emit("selection", index);
        break;
      case GameType.localMulti:
      case GameType.single:
        onPlayerSelection({"index": index, "value": gameManager.getPieceAt(index)});
        break;
      default:
        break;
    }
  }

  checkMatch() {
    if (rotatedPieceAValue == rotatedPieceBValue && rotatedPieceA != rotatedPieceB) {
      setState(() {
        matchedList[rotatedPieceA!] = rotatedPieceAValue ?? -1;
        matchedList[rotatedPieceB!] = rotatedPieceBValue ?? -1;
        if (myTurn) {
          player1Score++;
        } else {
          player2Score++;
        }
        nMatches++;
      });
    }
    if (widget.gameType != GameType.single) {
      myTurn = !myTurn;
    }
    setState(() {
      nTurnos++;
    });
    if (nMatches == matchedList.length/2) {
      gameOver();
    }
  }

  gameOver() {
    String winner = "Jogador Azul";
    int points = player2Score;
    if (player1Score > player2Score) {
      winner = "Jogador Vermelho";
      points = player1Score;
    }
    String endText = "$winner venceu com $points pontos!";
    if (player1Score == player2Score) {
      endText = "Houve um Empate!";
    }
    if (widget.gameType == GameType.single) {
      endText = "Você completou o jogo com ${nTurnos - player1Score} jogadas";
    }
    showDialog(
      context: context,
      builder: (c) {
        return AlertDialog(
          title: const Text("Fim de Jogo"),
          content: Text(endText),
          actions: [
            ElevatedButton(
              onPressed: () {
                Navigator.of(context).pop();
                Navigator.of(context).pop();
              }, 
              child: const Text("Voltar ao Menu")
            )
          ],
        );
      }
    );
  }

  @override
  Widget build(BuildContext context) {

    bool isSinglePlayer = widget.gameType == GameType.single;
    String text = isSinglePlayer ? "Número de Jogadas" :"Pontuação";
    int score = isSinglePlayer ? nTurnos - player1Score:player1Score;
    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          PlayerScore(isTop: true, score: score, text: text),
          Center(child: gameGrid()),
          isSinglePlayer? const SizedBox.shrink(): PlayerScore(isTop: false, score: player2Score, text: "Pontuação",),
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
            matched: matchedList[index] >= 0,
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
      mainAxisAlignment: MainAxisAlignment.center,
      children: rowList,
    );
  }
}