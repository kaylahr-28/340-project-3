import 'package:flame/flame.dart';
import 'package:flame/game.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'game_files/game_provider.dart';

import 'game_files/overlays/overlay_end.dart';
import 'game_files/overlays/overlay_main.dart';
import 'game_files/overlays/overlay_pause.dart';
import 'game_files/overlays/overlay_settings.dart';
import 'game_files/overlays/overlay_title.dart';
//import 'highscores_page.dart';

import 'game_files/game.dart';
import 'shop.dart';
import 'main.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Flame.device.fullScreen();
  //   // runApp(
  //   //   ChangeNotifierProvider(create: (_) => GameProvider(), child: MainApp()),
  // );
}

class MinigamePage extends StatefulWidget {
  const MinigamePage({super.key});

  @override
  State<MinigamePage> createState() => _MinigamePageState();
}

class _MinigamePageState extends State<MinigamePage> {
  @override
  Widget build(BuildContext context) {
    final gameProvider = context.read<GameProvider>();
    final game = BlootMinigame(context)..paused = true;
    gameProvider.game = game;

    return GameWidget(
      game: game,
      errorBuilder: (context, error) {
        debugPrint('here is the error: $error');
        return Center(
          child: Text(
            'Game failed to load: $error',
            style: const TextStyle(color: Colors.red),
          ),
        );
      },
      overlayBuilderMap: {
        "title": (context, game) => OverlayTitle(game: game),
        "main": (context, game) => mainOverlay(context, game),
        'pause': (context, game) => pauseOverlay(context, game),
        'gameOver': (context, game) => GameOverOverlay(game: game),
        'settings': (context, game) => settingsOverlay(context, game),
      },
      initialActiveOverlays: ['title'],
    );
  }
}
