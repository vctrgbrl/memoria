import 'package:flutter/material.dart';
import 'package:memoria/views/game_page.dart';
import 'package:memoria/views/lobby_page.dart';
import 'package:memoria/views/settings_page.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Jogo da Memória"),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          customButton("Jogar Sozinho", const GamePage(gameType: GameType.single,)),
          customButton("Multijogador local", const GamePage(gameType: GameType.localMulti,)),
          customButton("Multijogador online", const LobbyPage()),
          customButton("Configurações", const SettingsPage()),
        ],
      ),
    );
  }

  Widget customButton(String text, Widget page) {
    return Container(
      width: double.infinity,
      child: ElevatedButton(
        onPressed: () {
          Navigator.of(context).push(
            MaterialPageRoute(builder: (c) => page)
          );
        }, child: Text(text)),
    );
  }
}