import 'package:memoria/views/wait_game_page.dart';

import 'create_game_page.dart';
import '../service/websocket_manager.dart';

import 'package:flutter/material.dart';

class LobbyPage extends StatefulWidget {
  const LobbyPage({super.key});

  @override
  State<LobbyPage> createState() => _LobbyPageState();
}

class _LobbyPageState extends State<LobbyPage> {

  List<String> gameNames = [];
  WebSocketManager ws = WebSocketManager();

  TextEditingController nameController = TextEditingController();

  void setName() {
    if (nameController.text.isEmpty) {
      return;
    }

    ws.emit("set_name", nameController.text);
  }

  void onNameSet(dynamic name) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text("Nome $name selecionado"))
    );
  }

  void onNameUsed(dynamic name) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text("Nome $name em uso"))
    );
  }

  void joinGame(String gameName) {
      ws.emit("join_game", gameName);
      Navigator.of(context).push(
        MaterialPageRoute(builder: (c) => const WaitGame(start: true))
      );
  }

  goToWaitGame() {
    Navigator.push(context,
      MaterialPageRoute(
        builder: (context) => const WaitGame(start: false,)
      )
    );
  }

  void onRemoveGame(dynamic game) {
    setState(() {
      gameNames.remove(game);
    });
  }

  createGame() {
    Navigator.of(context).push(
      MaterialPageRoute(builder: (context) => CreateGamePage())
    );
  }

  @override
  void initState() {
    super.initState();
    ws.signCallback("new_game", (game) {
      setState(
        () {
          gameNames.add(game);
        }
      );
    });
    ws.signCallback("remove_game", onRemoveGame);
    ws.signCallback("name_selected", onNameSet);
    ws.signCallback("name_used", onNameUsed);
    ws.signCallback("all_games", (games) {
      gameNames = [];
      for (var game in games) {
        setState(() {
          gameNames.add(game);
        });
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Jogo da Memória"),
      ),
      body: Column(
        children: [
          nameInput(),
          const Column(
            children: [
              Text("Tipo: ")
            ],
          ),
          gameList(),
        ],
      ),
      floatingActionButton: createGameButton(),
    );
  }

  Widget nameInput() {
    return Row(
      children: [
        Expanded(
          child: TextField(
            controller: nameController,
          ),
        ),
        ElevatedButton(onPressed: setName, child: const Text("Ok"))
      ],
    );
  }

  Widget createGameButton() {
    return FloatingActionButton(
      onPressed: createGame,
      child: const Icon(Icons.add),
    );
  }

  Widget gameList() {
    return Column(
      children: gameNames.map(gameListCard).toList(),
    );
  }

  Widget gameListCard(String gameName) {
    return GestureDetector(
      onTap: () {
        joinGame(gameName);
      },
      child: Card(
        child: Text(gameName),
      ),
    );
  }
}