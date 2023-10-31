import 'package:flutter/material.dart';
import 'package:infinite_carousel/infinite_carousel.dart';
import 'package:memoria/service/skin_type.dart';

class SettingsPage extends StatefulWidget {
  const SettingsPage({super.key});

  @override
  State<SettingsPage> createState() => _SettingsPageState();
}

class _SettingsPageState extends State<SettingsPage> {
  
  SkinManager skinManager = SkinManager();
  SkinType skinType = SkinType.numbers;

  late InfiniteScrollController _scrollController;
  int selectedIndex = 0;

  @override
  initState() {
    skinType = skinManager.getSkinType();
    _scrollController= InfiniteScrollController(initialItem: skinType.index);
  }

  onSelect(int index) {
    setState(() {
      skinType = SkinType.values[index];
    });
    skinManager.setSkinType(skinType);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: [],
        title: const Text("Configurações"),
      ),
      body: Column(
        children: [
          const Text("Selectionar Tipo de Cartas", style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold),),
          SizedBox(
            height: 200,
            child: selectSkin()),
        ],
      ),
    );
  }

  Widget selectSkin() {
    return InfiniteCarousel.builder(
      itemCount: SkinType.values.length,
      itemExtent: 200,
      center: true,
      anchor: 0.0,
      velocityFactor: 0.2,
      onIndexChanged: onSelect,
      controller: _scrollController,
      axisDirection: Axis.horizontal,
      loop: true,
      itemBuilder: (context, itemIndex, realIndex) {
        return Padding(
          padding: const EdgeInsets.all(10.0),
          child: GestureDetector(
            onTap: () {
              print("item: $itemIndex, real: $realIndex");
              _scrollController.animateToItem(realIndex);
            },
            child: Container(
              // height: 100,
              // width: 100,
              decoration: BoxDecoration(
                image: DecorationImage(
                  image: NetworkImage(
                    skinManager.getSkinSplashUrl(itemIndex),),
                    fit: BoxFit.fill
                ),
              )
            ),
          ),
        );
      },
    );
  }
}