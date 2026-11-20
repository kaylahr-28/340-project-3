import 'package:flutter/material.dart';
import 'package:project_3_340/game_files/game.dart';
import 'package:provider/provider.dart';
import 'package:flame/flame.dart';

import 'game_files/game_provider.dart';

import 'minigame_page.dart';
import 'shop.dart';

// void main() async {
//   WidgetsFlutterBinding.ensureInitialized();
//   await Flame.device.fullScreen();

//   runApp(
//     ChangeNotifierProvider(
//       create: (context) => GameProvider(),
//       child: const MinigamePage(),
//     ),
//   );
// }
void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  //await Flame.device.fullScreen();

  runApp(
    ChangeNotifierProvider(create: (_) => GameProvider(), child: MainApp()),
    //MainApp(),
  );
}

class MainApp extends StatefulWidget {
  const MainApp({super.key});

  @override
  State<MainApp> createState() => _MainAppState();
}

//make main pg into widget?
class _MainAppState extends State<MainApp> {
  int _currentNavScreen = 1;
  final List<Widget> _bottomNavScreens = [
    const MinigamePage(),
    const HomePage(),
    const ShopPage(),
  ];

  @override
  Widget build(BuildContext context) {
    // late final gameProvider = context.read<GameProvider>();
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        appBar: AppBar(title: Text('Cool Space Game!!')),
        //body: _bottomNavScreens[_currentNavScreen]
        body: IndexedStack(
          index: _currentNavScreen,
          children: _bottomNavScreens,
        ),
        bottomNavigationBar: BottomNavigationBar(
          items: [
            BottomNavigationBarItem(icon: Icon(Icons.gamepad), label: "Game"),
            BottomNavigationBarItem(icon: Icon(Icons.home), label: "Home"),
            BottomNavigationBarItem(
              icon: Icon(Icons.shopping_bag),
              label: "Shop",
            ),
          ],
          onTap: (value) {
            // final gameProvider = context.read<GameProvider>();
            final gameProvider = context.read<GameProvider>();
            gameProvider.game?.paused = true;
            //only add pause if game has previously been started (ie not on start)
            if (gameProvider.game != null) {
              if (!gameProvider.game!.overlays.isActive('title') &&
                  !gameProvider.game!.overlays.isActive('gameOver')) {
                gameProvider.game?.overlays.add('pause');
              } else {
                gameProvider.game?.overlays.add('title');
                gameProvider.game?.overlays.remove('gameOver');
              }
            }
            setState(() {
              _currentNavScreen = value;
            });
          },
        ),
      ),
    );
  }
}

class HomePage extends StatefulWidget {
  const new({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        children: [
          Text("Main Page Bloot"),
          Image(
            image: AssetImage('assets/images/bloot.png'),
            width: 200,
            height: 200,
          ),
        ],
      ),
    );
  }
}
