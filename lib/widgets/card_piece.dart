import 'dart:math';

import 'package:flutter/material.dart';

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

  // bool isRotated = true;

  @override
  Widget build(BuildContext context) {

    double size = min(MediaQuery.of(context).size.width, MediaQuery.of(context).size.height);
    bool isRotated = !widget.isRotated;
    bool isMatched = widget.matched;

    return GestureDetector(
      onTap: () => widget.rotatePiece(widget.index),
      child: AnimatedContainer(
        margin: const EdgeInsets.all(10),
        height: size/5 - 20,
        width:  size/5 - 20,
        duration: const Duration(milliseconds: 300),
        curve: Curves.ease,
        transform: Matrix4.rotationY( isRotated ? 3.14:0),
        transformAlignment: Alignment.center,
        // padding: const EdgeInsets.all(30.0),
        decoration: BoxDecoration(
          border: Border.all(color: Colors.grey, width: 4.0),
          color: isMatched?Colors.transparent: Colors.grey,
          borderRadius: BorderRadius.circular(10),
        ),
        child: isRotated || isMatched ?const SizedBox.shrink() :
        Center(
          child: Container(
            color: Colors.purpleAccent,
            child: Text("${widget.value}"), 
          )
        ),
      ),
    );
  }
}