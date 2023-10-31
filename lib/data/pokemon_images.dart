import 'dart:math';

List<String> selectNPokemon(int n) {
  List<String> ns = [];
  for (var i = 0; i < n;) {
    String n = "${Random().nextInt(1010) + 1}".padLeft(3, '0');
    String url = "https://assets.pokemon.com/assets/cms2/img/pokedex/detail/$n.png";
    if (!ns.contains(url))  {
      ns.add(url);
      i++;
    }
  }
  return ns;
}