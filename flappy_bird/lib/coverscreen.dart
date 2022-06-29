import 'package:flutter/material.dart';

class MyCoverScreen extends StatelessWidget {
  final gameHasStarted;

  MyCoverScreen({this.gameHasStarted});

  @override
  Widget build(BuildContext context) {
    return Container(
        // Tap to play
        alignment: const Alignment(0, -0.5),
        child: Text(
          gameHasStarted ? "" : "T A P T O P L A Y",
          style: const TextStyle(color: Colors.white),
        ));
  }
}
