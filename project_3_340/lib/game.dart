import 'dart:async';

import 'package:flame/events.dart';
import 'package:flame/game.dart';
import 'package:flutter/material.dart';

import 'asteroid.dart';

import 'package:flame_audio/flame_audio.dart';
import 'package:provider/provider.dart';

import 'game_provider.dart';

///
/// The Game!
/// This is just a simple demo FlameGame to allow us to see how
/// we can use Overlays to enhance this game and see how we can
/// control the flow of the game.
///
/// Things to note:
/// - the background color of the game is changed to a ARGB color.
/// - assets are preloaded into cache.
/// - the game spawns 10 asteroids that are unmanaged.
/// - the game uses TapCallbacks to handle tap events. Nothing happens yet.
///

class OverlayTutorial extends FlameGame
    with TapCallbacks, HasCollisionDetection, WidgetsBindingObserver {
  final BuildContext context;
  //late: gets val after constructor loads (in onLoad)
  //final: cant change after that
  late final GameProvider gameProvider;

  OverlayTutorial(this.context);

  @override
  Color backgroundColor() => const Color.fromARGB(249, 120, 86, 233);

  //for life cycle
  @override
  void onAttach() {
    super.onAttach();
    WidgetsBinding.instance.addObserver(this);
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    // TODO: implement didChangeAppLifecycleState
    super.didChangeAppLifecycleState(state);
    switch (state) {
      case AppLifecycleState.resumed:
        print('resumed');
        //resume game engine, resume music player
        break;
      case AppLifecycleState.paused:
      case AppLifecycleState.detached:
      case AppLifecycleState.inactive:
      case AppLifecycleState.hidden:
        print('paused');
      //pause game engine, pause music player
    }
  }

  @override
  Future<void> onLoad() async {
    //grab provider- use read() bc game itself doesnt rebuild
    gameProvider = context.read<GameProvider>();

    //preload audio so the first tap doesn't hitch, then start music
    await FlameAudio.audioCache.loadAll(['retro_bgm.wav', 'shot.wav']);
    gameProvider.playBgm('retro_bgm.wav');

    await images.loadAll(["asteroid.png"]);

    for (int i = 0; i < 10; i++) {
      add(Asteroid());
    }
  }

  @override
  void onTapUp(TapUpEvent event) {
    super.onTapUp(event);
    //increment score
    gameProvider.incrementScore(1);

    //play sound effect
    gameProvider.playSfx('shot.wav');
  }
}
