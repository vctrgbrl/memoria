import 'package:flutter/material.dart';

class PlayerScore extends StatefulWidget {

  final bool isTop;
  final int score;

  const PlayerScore({super.key, required this.isTop, required this.score});

  @override
  State<PlayerScore> createState() => _PlayerScoreState();
}

class _PlayerScoreState extends State<PlayerScore> {

  @override
  Widget build(BuildContext context) {

    BorderRadius borderRadius = const BorderRadius.only(bottomRight: Radius.circular(20));
    Color color = Colors.redAccent;
    MainAxisAlignment mainAxisAlignment = MainAxisAlignment.start;

    if (!widget.isTop) {
      borderRadius = const BorderRadius.only(topLeft: Radius.circular(30));
      color = Colors.blueAccent;
      mainAxisAlignment = MainAxisAlignment.end;
    }

    List<Widget> rowList = [
      const CircleAvatar(
        backgroundColor: Colors.transparent,
        child: Text("V"),
      ),
      Text("Pontuação: ${widget.score}")
    ];
    return Container(
      decoration: ShapeDecoration(
        color: color,
        shape: RoundedRectangleBorder(
          borderRadius: borderRadius,
        )
      ),
      child: Row(
        mainAxisAlignment: mainAxisAlignment,
        children: widget.isTop? rowList :rowList.reversed.toList()
      ),
    );
  }
}