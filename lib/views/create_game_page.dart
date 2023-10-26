import 'package:flutter/material.dart';
import 'package:memoria/views/wait_game_page.dart';
import '../service/websocket_manager.dart';

class CreateGamePage extends StatefulWidget {
  const CreateGamePage({super.key});

  @override
  State<CreateGamePage> createState() => _CreateGamePageState();
}

class _CreateGamePageState extends State<CreateGamePage> {
  
  String? gameName;
  TextEditingController textEditingController = TextEditingController();

  WebSocketManager ws = WebSocketManager();

  createGame() {
    ws.emit("create_game", textEditingController.text);
  }

  onGameCreated(dynamic message) {
    bool created = message['created'];
    String name = message['game'];
    if (!created) {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text("Nome: $name em uso")));
      return;
    }
    Navigator.of(context).push(
      MaterialPageRoute(builder: (c) => const WaitGame(start: false))
    );
  }

  @override
  void initState() {
    super.initState();
    ws.signCallback("game_created", onGameCreated);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Criar Jogo"),
      ),
      body: Column(
        children: [
          TextField(
            controller: textEditingController,
          ),
          ElevatedButton(
            onPressed: createGame, 
            child: const Text("Criar Jogo")
          ),
        ],
      ),
    );
  }
}