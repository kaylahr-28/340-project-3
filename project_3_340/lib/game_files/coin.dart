import 'dart:async';
import 'dart:math';

import 'package:flame/components.dart';
import 'package:flame/collisions.dart';
import 'package:project_3_340/game_files/game.dart';

import 'asteroid.dart';
import 'bloot.dart';

import 'game_provider.dart';

///
/// Asteroid Sprite
/// This is our asteroid sprite that will bounce off the walls
/// When invoked it will create an instance of an Asteroid spritecomponent.
/// The position and velocity are randomized.
/// The update method ensures the asteroid stays on screen and bounces off the walls.
///

class Coin extends SpriteComponent
    with HasGameReference<BlootMinigame>, CollisionCallbacks {
  //late Vector2 velocity;

  // All asteroids are the same size
  static const double coinSize = 25.0;

  //
  // onLoad
  // sets up an asteroid with a random position and velocity
  //
  @override
  Future<void> onLoad() async {
    sprite = Sprite(game.images.fromCache('coin.png'));
    anchor = Anchor.center;
    position = Vector2(
      Random().nextDouble() * game.size.x,
      Random().nextDouble() * game.size.y,
    );
    size = Vector2(coinSize, coinSize);
    // velocity = Vector2(
    //   Random().nextDouble() * 100,
    //   Random().nextDouble() * 100,
    // );

    add(CircleHitbox());
  }

  @override
  void onCollision(Set<Vector2> intersectionPoints, PositionComponent other) {
    super.onCollision(intersectionPoints, other);

    if (other is Bloot) {
      position = Vector2(
        Random().nextDouble() * game.size.x,
        Random().nextDouble() * game.size.y,
      );
      game.gameProvider.incrementScore(1);
    }
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
}
