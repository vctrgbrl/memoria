import 'package:flutter/widgets.dart';
import '../views/game_page.dart';

class Routes {
  static String game = "/game";
  static String index = "/";

  static final Map<String, Widget Function(BuildContext)> routes = {
    // Routes.game: (context) => const GamePage() 
  };
}