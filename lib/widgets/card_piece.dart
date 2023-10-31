import 'dart:math';

import 'package:flutter/material.dart';
import 'package:memoria/service/skin_type.dart';

class CardPiece extends StatefulWidget {

  final int? value;
  final bool isRotated;
  final bool matched;
  final int index;
  final void Function(int) rotatePiece;

  const CardPiece({
    super.key, 
    required this.index,
    required this.value, 
    required this.isRotated, 
    required this.rotatePiece,
    required this.matched,
  });

  @override
  State<CardPiece> createState() => _CardPieceState();
}

class _CardPieceState extends State<CardPiece> {

  SkinManager skinType = SkinManager();

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {

    double size = min(MediaQuery.of(context).size.width, MediaQuery.of(context).size.height);
    bool isMatched = widget.matched;
    bool isRotated = widget.isRotated || isMatched;
    int n = size==MediaQuery.of(context).size.width?5:6;

    return GestureDetector(
      onTap: () => widget.rotatePiece(widget.index),
      child: AnimatedContainer(
        margin: const EdgeInsets.all(10),
        height: size/n - (n==5?5:15),
        width:  size/n - (n==5?5:15),
        duration: const Duration(milliseconds: 300),
        curve: Curves.ease,
        transform: Matrix4.rotationY( !isRotated ? 3.14:0),
        transformAlignment: Alignment.center,
        // padding: const EdgeInsets.all(30.0),
        decoration: BoxDecoration(
          border: Border.all(color: Colors.grey, width: 4.0),
          color: Colors.grey,
          borderRadius: BorderRadius.circular(10),
        ),
        child: !isRotated ?const SizedBox.shrink() :
        Center(
          child: skinType.getWidget(widget.value!)
        ),
      ),
    );
  }
}