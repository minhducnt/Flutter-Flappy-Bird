import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../src/data/models/models.dart';
import '../src/ui/ui.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(const CrabGameApp());
}

class CrabGameApp extends StatelessWidget {
  const CrabGameApp({Key? key}) : super(key: key);

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
