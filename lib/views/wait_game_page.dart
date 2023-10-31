import 'dart:js_interop';

import 'package:flutter/material.dart';
import 'package:memoria/views/game_page.dart';
import '../service/websocket_manager.dart';

class WaitGame extends StatefulWidget {

  final bool start;

  const WaitGame({super.key, required this.start});

  @override
  State<WaitGame> createState() => _WaitGameState();
}

class _WaitGameState extends State<WaitGame> {

  WebSocketManager webSocketManager = WebSocketManager();

  String? otherPlayerName;
  int i = 3;

  setName(dynamic name) async {
    setState(() {
      otherPlayerName = name as String;
    });

    goToGame();
  }

  goToGame() async {
    setState(() {
      otherPlayerName = "";
    });
    for (var j = 0; j < 3; j++) {
      await Future.delayed(const Duration(seconds: 1), () {
        print("asdf $i");
        setState(() {
          i--;
        });
      });
    }
    webSocketManager.removeCallback("new_player", setName);
    // Navigator.of(context).pushReplacementNamed(Routes.game);
    if (!context.mounted) return;
    Navigator.of(context).push(
      MaterialPageRoute(builder: (c) => GamePage(myTurn: !widget.start, gameType: GameType.onlineMulti,))
    );
  }

  @override
  void initState() {
    super.initState();
    webSocketManager.signCallback("new_player", setName);
    if (widget.start) {
      goToGame();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Sala de Espera"),
      ),
      body: otherPlayerName.isNull? const Text("Esperando..."):Text("$i"),
    );
  }
}