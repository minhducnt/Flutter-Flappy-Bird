import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../src/models/models.dart';
import '../src/ui/ui.dart';

class FlappyBirdApp extends StatelessWidget {
  const FlappyBirdApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider<Experience>(
          create: (_) => Experience(),
        ),
      ],
      child: const MaterialApp(
        title: 'Crab Game',
        debugShowCheckedModeBanner: false,
        home: GameScreen(),
      ),
    );
  }
}
