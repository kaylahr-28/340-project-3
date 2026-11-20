import 'dart:async';
import 'dart:math';

import 'package:flame/components.dart';
import 'package:flame/collisions.dart';

import 'asteroid.dart';
import 'game.dart';
import '../globals.dart';

import 'game_provider.dart';

import 'package:flame/events.dart';

///
/// BLoot Sprite
/// This is our bloot
///
///
///
/// sprite that will bounce off the walls
/// When invoked it will create an instance of an Asteroid spritecomponent.
/// The position and velocity are randomized.
/// The update method ensures the asteroid stays on screen and bounces off the walls.
///

class Bloot extends SpriteComponent
    with HasGameReference<BlootMinigame>, CollisionCallbacks {
  //late Vector2 velocity;

  static const double blootSize = 50.0;

  //
  // onLoad
  // sets up an asteroid with a random position and velocity
  //
  @override
  Future<void> onLoad() async {
    sprite = Sprite(game.images.fromCache('bloot.png'));
    anchor = Anchor.center;
    position = Vector2(game.size.x / 2, game.size.y - 75);
    size = Vector2(blootSize, blootSize);
    // velocity = Vector2(
    //   Random().nextDouble() * 100,
    //   Random().nextDouble() * 100,
    // );

    add(CircleHitbox());
  }

  @override
  void onCollision(Set<Vector2> intersectionPoints, PositionComponent other) {
    super.onCollision(intersectionPoints, other);

    if (other is Asteroid) {
      game.paused = true;
      game.overlays.add('gameOver');
      game.gameProvider.addToTotalCoins();
      //   position = Vector2(
      //     Random().nextDouble() * game.size.x,
      //     Random().nextDouble() * game.size.y,
      //   );
      //   game.findGame()
      //   //.incrementScore(1);
    }
  }

  void restartGame() {
    position = Vector2(game.size.x / 2, game.size.y - 75);
  }

  //
  // update
  // moves the asteroid and bounces it off the walls
  //
  @override
  void update(double dt) {
    super.update(dt);
    // position += velocity * dt;
    // if (position.y < 0 || position.y > game.size.y) {
    //   velocity = Vector2(velocity.x, -velocity.y);
    // }
    // if (position.x < 0 || position.x > game.size.x) {
    //   velocity = Vector2(-velocity.x, velocity.y);
    // }
  }

  void move(Vector2 delta) {
    position.add(delta);
  }
}
