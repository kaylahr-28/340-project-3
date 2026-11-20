import 'package:flutter/material.dart';
import 'package:project_3_340/globals.dart';

import '../../globals.dart';
import '../game_provider.dart';
import '../game.dart';

///
/// Title Overlay
/// A centered container with title text and two buttons (Start Game, Settings).
/// In class we'll refactor this to accept a game reference and wire the buttons.
///

class GameOverOverlay extends StatefulWidget {
  final game;
  //final ;

  const GameOverOverlay({super.key, required this.game});

  @override
  State<GameOverOverlay> createState() => _GameOverOverlayState();
}

class _GameOverOverlayState extends State<GameOverOverlay> {
  @override
  Widget build(BuildContext context) {
    // final gameProvider;

    return Center(
      child: Container(
        width: 350,
        height: 400,
        decoration: BoxDecoration(
          color: Color.fromARGB(255, 240, 236, 203),
          borderRadius: BorderRadius.circular(20),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              "Game Over!",
              style: TextStyle(
                color: Colors.black,
                fontSize: 48,
                fontWeight: FontWeight(600),
              ),
            ),
            SizedBox(height: 20),
            Text(
              "You gained ${widget.game.gameProvider.score} coins!",
              style: TextStyle(color: Colors.black, fontSize: 36),
            ),
            ElevatedButton(
              onPressed: () {
                // TODO: Start game
                widget.game.paused = false;
                widget.game.overlays.remove('gameOver');
                widget.game.overlays.add('main');
              },
              child: Text("Play Again"),
            ),
            // const SizedBox(height: 20),
            // ElevatedButton(
            //   onPressed: () {
            //     // TODO: Settings
            //     game.overlays.remove('title');
            //     game.overlays.add('settings');
            //     game.overlays.add('main');
            //   },
            //   child: const Text("Settings"),
            //),
          ],
        ),
      ),
    );
  }
}
