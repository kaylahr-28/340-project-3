import 'package:flutter/material.dart';

///
/// Title Overlay
/// A centered container with title text and two buttons (Start Game, Settings).
/// In class we'll refactor this to accept a game reference and wire the buttons.
///

class OverlayTitle extends StatelessWidget {
  final game;
  const OverlayTitle({super.key, required this.game});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
        width: 350,
        height: 350,
        decoration: BoxDecoration(
          color: Color.fromARGB(255, 240, 236, 203),
          borderRadius: BorderRadius.circular(20),
        ),
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Text(
                "Bloot in Space!",
                style: TextStyle(
                  color: Colors.black,
                  fontSize: 48,
                  fontWeight: FontWeight(600),
                ),
              ),
              const SizedBox(height: 20),
              const Text(
                "Drag your Bloot across the universe to collect coins! Watch out for asteroids...",
                textAlign: TextAlign.center,
                style: TextStyle(color: Colors.black, fontSize: 24, height: 1),
              ),
              const SizedBox(height: 20),
              ElevatedButton(
                onPressed: () {
                  // TODO: Start game
                  game.paused = false;
                  game.overlays.remove('title');
                  game.overlays.add('main');
                },
                child: Text("Start Game"),
              ),
              const SizedBox(height: 20),
              ElevatedButton(
                onPressed: () {
                  // TODO: Settings
                  game.overlays.remove('title');
                  game.overlays.add('settings');
                  game.overlays.add('main');
                },
                child: const Text("Settings"),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
