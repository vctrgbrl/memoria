import 'package:flutter/material.dart';
import 'package:memoria/data/league_of_legends_images.dart';
import 'package:memoria/data/pokemon_images.dart';

class SkinCard {
  int index;
  // List<Image> _imageUrls = [];
  late Image image;

  SkinCard({required this.index,required String image}) {
    // _imageUrls = images.map((e) => Image.network(e)).toList();
    this.image = Image.network(image,  
      filterQuality: FilterQuality.high,
      fit: BoxFit.fill,
      );
  }

  Widget getWidget() {
    SkinManager skinType = SkinManager();
    bool s = skinType.getSkinType() == SkinType.numbers;
    if (s) {
      return Container(
        color: Colors.purpleAccent,
        child: Text("$index"), 
      );
    }
    return image;//_imageUrls[skinType.skinType.index - 1];
  }
}

enum SkinType {
  numbers,
  leagueOfLegends,
  pokemon
}

class SkinManager {

  static final _instance = SkinManager._internal();

  SkinType _skinType = SkinType.pokemon;
  List<SkinCard> skins = [];

  List<Widget> skinSplash = [
    Image.network("https://education.casio.co.uk/images/width=1400,height=500,crop=/2022/08/fav-num-1.png",
      fit: BoxFit.fill,
    ),
    Image.network("https://education.casio.co.uk/images/width=1400,height=500,crop=/2022/08/fav-num-1.png",
      fit: BoxFit.fill,
    ),
    Image.network("https://education.casio.co.uk/images/width=1400,height=500,crop=/2022/08/fav-num-1.png",
      fit: BoxFit.fill,
    ),
  ];

  String getSkinSplashUrl(int i) {
    return [
      "https://education.casio.co.uk/images/width=1400,height=500,crop=/2022/08/fav-num-1.png",
      "https://yt3.googleusercontent.com/OhawLJ6JWAnGt_s05yxGT-MJ6kUGZYzY6wwWPDchqZwejsNlcJkaIz9DTgs9TTg0ONtYNZEN=s900-c-k-c0x00ffffff-no-rj",
      "https://assets.pokemon.com/static2/_ui/img/og-default-image.jpeg",
    ][i];
  }
  
  setSkinType(SkinType skinType) {
    _skinType = skinType;
    refreshImages();
  }

  SkinType getSkinType() {
    return _skinType;
  }

  Widget getWidget(int value) {
    return skins[value].getWidget();
  }

  factory SkinManager() {
    return _instance;
  }

  SkinManager._internal() {
    refreshImages();
  }

  List<String> selectNUrl(int n) {
    switch (_skinType) {
      case SkinType.leagueOfLegends:
        return selectNUrlLoL(n);
      case SkinType.pokemon:
        return selectNPokemon(n);
      default:
        return [];
    }
  }

  refreshImages() {
    bool isNumber = SkinType.numbers == _skinType;
    List<String> s = [];
    if (!isNumber) {
      s = selectNUrl(10);
      skins = [];
    }

    for (var i = 0; i < 10; i++) {
      skins.add(
        SkinCard(index: i, image:isNumber ?"": s[i])
      );
    }
  }
}