import 'dart:async';

import 'package:flappy_bird/bird.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

import 'barrier.dart';
import 'coverscreen.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  // Bird variables
  static double birdY = 0;
  double initialPos = birdY;
  double height = 0;
  double time = 0;
  double gravity = -4.9; // How strong the gravity is
  double velocity = 3.5; // How strong the jump is
  double birdWidth = 0.1;
  double birdHeight = 0.1;

  // Game settings
  bool gameHasStarted = false;

  // Barrier settings
  static List<double> barrierX = [2, 2 + 1.5];
  static double barrierWidth = 0.5;
  List<List<double>> barrierHeight = [
    [0.6, 0.4],
    [0.4, 0.6]
  ];

  void startGame() {
    gameHasStarted = true;
    Timer.periodic(const Duration(milliseconds: 10), (timer) {
      height = gravity * time * time + velocity * time;

      setState(() {
        birdY = initialPos - height;
      });

      // Check if the bird is dead
      if (birdIsDead()) {
        timer.cancel();
        _showDialog();
        resetGame();
      }

      // Keep the map moving (move barriers)
      moveMap();

      // Keep the time going
      time += 0.01;
    });
  }

  void moveMap() {
    for (int i = 0; i < barrierX.length; i++) {
      setState(() {
        barrierX[i] -= 0.005;
      });

      // If barrier exits the left part of the screen, keep it looping
      if (barrierX[i] < -1.5) {
        barrierX[i] += 3;
      }
    }
  }

  void jump() {
    setState(() {
      time = 0;
      initialPos = birdY;
    });
  }

  void resetGame() {
    Navigator.pop(context);
    setState(() {
      gameHasStarted = false;
      time = 0;
      initialPos = birdY;
    });
  }

  // Check if the bird is dead
  bool birdIsDead() {
    // Check if the bird is hitting at the top or the bottom of the screen
    if (birdY < -1 || birdY > 1) {
      return true;
    }

    // Hit barriers
    // Check if the bird is within x coordinates and y coordinates of the barriers
    for (int i = 0; i < barrierX.length; i++) {
      if (barrierX[i] <= birdWidth &&
          barrierX[i] + barrierWidth >= -birdWidth &&
          (birdY <= -1 + barrierHeight[i][0] ||
              birdY >= 1 - barrierHeight[i][1])) {
        return true;
      }
    }

    return false;
  }

  void _showDialog() {
    showDialog(
        context: context,
        barrierDismissible: false,
        builder: (BuildContext context) {
          return AlertDialog(
            backgroundColor: Colors.brown,
            title: const Center(
              child: Text(
                "G A M E O V E R",
                style: TextStyle(color: Colors.white),
              ),
            ),
            actions: [
              GestureDetector(
                  onTap: resetGame,
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(5),
                    child: Container(
                      padding: const EdgeInsets.all(7),
                      color: Colors.white,
                      child: const Text(
                        "P L A Y A G A I N",
                        style: TextStyle(color: Colors.brown),
                      ),
                    ),
                  ))
            ],
          );
        });
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: gameHasStarted ? jump : startGame,
      child: Scaffold(
          body: Column(children: [
        Expanded(
          flex: 3,
          child: Container(
              color: Colors.blue,
              child: Center(
                  child: Stack(
                children: [
                  MyBird(
                    birdY: birdY,
                    birdWidth: birdWidth,
                    birdHeight: birdHeight,
                  ),

                  // Tap to play
                  MyCoverScreen(gameHasStarted: gameHasStarted),

                  // Top barrier0
                  MyBarrier(
                    barrierX: barrierX[0],
                    barrierWidth: barrierWidth,
                    barrierHeight: barrierHeight[0][0],
                    isThisBottomBarrier: false,
                  ), // MyBarrier

                  // Bottom barrier0
                  MyBarrier(
                    barrierX: barrierX[0],
                    barrierWidth: barrierWidth,
                    barrierHeight: barrierHeight[0][1],
                    isThisBottomBarrier: true,
                  ),

                  // Top barrier1
                  MyBarrier(
                    barrierX: barrierX[1],
                    barrierWidth: barrierWidth,
                    barrierHeight: barrierHeight[1][0],
                    isThisBottomBarrier: false,
                  ), // MyBarrier

                  // Bottom barrier1
                  MyBarrier(
                    barrierX: barrierX[1],
                    barrierWidth: barrierWidth,
                    barrierHeight: barrierHeight[1][1],
                    isThisBottomBarrier: true,
                  ), // MyBarrier // MyBarrier
                ],
              ))),
        ),
        Expanded(
            child: Container(
          color: Colors.brown,
        ))
      ])),
    );
  }
}
