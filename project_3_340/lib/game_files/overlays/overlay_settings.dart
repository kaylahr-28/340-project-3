import 'package:flutter/material.dart';

import '../game_provider.dart';

import 'package:provider/provider.dart';

///
/// Settings Overlay
/// A centered container with TWO volume sliders (music, sound effects)
/// and a Close button. The sliders themselves are NOT here yet - we'll
/// add them in class to learn the Slider widget API.
///

Widget settingsOverlay(BuildContext context, game) {
  final gameProvider = context.watch<GameProvider>();
  return Center(
    child: Container(
      width: 350,
      height: 400,
      decoration: BoxDecoration(
        color: Color.fromARGB(255, 180, 150, 200), // Purple
        borderRadius: BorderRadius.circular(20),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Text(
            "Settings",
            style: TextStyle(color: Colors.black, fontSize: 48),
          ),
          const SizedBox(height: 20),

          // TODO: Add music volume slider here (Row with music_note Icon + Slider)
          Row(
            children: [
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Icon(Icons.music_note),
              ),
              Expanded(
                child: Slider(
                  value: gameProvider.musicVolume,
                  min: 0,
                  max: 1,
                  divisions: 5,
                  label: gameProvider.musicVolume.toStringAsFixed(1),
                  onChanged: (value) {
                    gameProvider.setMusicVolume(value);
                  },
                ),
              ),
            ],
          ),
          // TODO: Add sound effects volume slider here (Row with volume_up Icon + Slider)
          Row(
            children: [
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Icon(Icons.volume_up),
              ),
              Expanded(
                child: Slider(
                  value: gameProvider.sfxVolume,
                  min: 0,
                  max: 1,
                  divisions: 5,
                  label: gameProvider.sfxVolume.toStringAsFixed(1),
                  onChanged: (value) {
                    gameProvider.setSfxVolume(value);
                  },
                ),
              ),
            ],
          ),
          const SizedBox(height: 20),
          ElevatedButton(
            onPressed: () {
              // TODO: Close (remove settings overlay + unpause)
              game.paused = false;
              game.overlays.remove('settings');
              game.overlays.add('main');
            },
            child: const Text("Close"),
          ),
        ],
      ),
    ),
  );
}
