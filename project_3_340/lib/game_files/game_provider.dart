import 'package:flutter/material.dart';
import 'package:flame_audio/flame_audio.dart';
import 'package:flame/game.dart';

import '../globals.dart';

class GameProvider extends ChangeNotifier {
  // Private variables for settings
  double _musicVolume = 1.0;
  double _sfxVolume = 1.0;
  int _score = 0;
  int _highScore = 0;
  bool _inGame = false;
  FlameGame? _game;

  // Getters to access private variables
  double get musicVolume => _musicVolume;
  double get sfxVolume => _sfxVolume;
  int get score => _score;
  int get highScore => _highScore;
  bool get inGame => _inGame;
  FlameGame? get game => _game;

  set game(FlameGame? value) {
    _game = value;
  }

  // Setters with notifyListeners
  void setMusicVolume(double value) {
    _musicVolume = value;
    FlameAudio.bgm.audioPlayer.setVolume(value);
    WidgetsBinding.instance.addPostFrameCallback((_) {
      notifyListeners();
    });
  }

  void setSfxVolume(double value) {
    _sfxVolume = value;
    WidgetsBinding.instance.addPostFrameCallback((_) {
      notifyListeners();
    });
  }

  void incrementScore(int value) {
    _score += value;
    WidgetsBinding.instance.addPostFrameCallback((_) {
      notifyListeners();
    });
  }

  //adds to total coins and also updates highscore
  void addToTotalCoins() {
    totalCoins += _score;
    if (_score > _highScore) _highScore = _score;
    WidgetsBinding.instance.addPostFrameCallback((_) {
      notifyListeners();
    });
  }

  void restartGame() {
    _score = 0;

    WidgetsBinding.instance.addPostFrameCallback((_) {
      notifyListeners();
    });
  }

  //play bg music (auto loops)
  Future<void> playBgm(String url) async {
    //WARNING! Notice how the one uses FlameAudio.bgm.play()
    //As opposed to the SFX which just uses FlameAudio.play()!
    //Subtle difference that I forgot while doing  demo!
    await FlameAudio.bgm.play(url, volume: _musicVolume);
  }

  //play sound effect (one-shot)
  Future<void> playSfx(String url) async {
    await FlameAudio.play(url, volume: _sfxVolume);
  }
}
