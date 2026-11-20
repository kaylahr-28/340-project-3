import 'dart:async';
import 'dart:math';

import 'package:flame/components.dart';
import 'package:flame/collisions.dart';

///
/// Asteroid Sprite
/// This is our asteroid sprite that will bounce off the walls
/// When invoked it will create an instance of an Asteroid spritecomponent.
/// The position and velocity are randomized.
/// The update method ensures the asteroid stays on screen and bounces off the walls.
///

class Asteroid extends SpriteComponent
    with HasGameReference, CollisionCallbacks {
  late Vector2 velocity;

  // All asteroids are the same size
  static const double asteroidSize = 50.0;

  //
  // onLoad
  // sets up an asteroid with a random position and velocity
  //
  @override
  Future<void> onLoad() async {
    sprite = Sprite(game.images.fromCache('asteroid.png'));
    anchor = Anchor.center;
    position = Vector2(
      Random().nextDouble() * game.size.x,
      Random().nextDouble() * game.size.y - 100,
    );
    size = Vector2(asteroidSize, asteroidSize);
    velocity = Vector2(
      Random().nextDouble() * 100,
      Random().nextDouble() * 100,
    );

    add(CircleHitbox());
  }

  @override
  void onCollision(Set<Vector2> intersectionPoints, PositionComponent other) {
    super.onCollision(intersectionPoints, other);

    if (other is Asteroid) {
      final normal = (other.position - position).normalized();

      //calculate relative velocity
      final relativeVelocity = velocity - other.velocity;

      final impulse = relativeVelocity.dot(normal);

      if (impulse > 0) {
        velocity -= normal * impulse;
        other.velocity += normal * impulse;
      }
    }
  }

  //set new position and velocities
  void restartGame() {
    position = Vector2(
      Random().nextDouble() * game.size.x,
      Random().nextDouble() * game.size.y - 100,
    );

    velocity = Vector2(
      Random().nextDouble() * 100,
      Random().nextDouble() * 100,
    );
  }

  //
  // update
  // moves the asteroid and bounces it off the walls
  //
  @override
  void update(double dt) {
    super.update(dt);
    position += velocity * dt;
    if (position.y < 0 || position.y > game.size.y) {
      velocity = Vector2(velocity.x, -velocity.y);
    }
    if (position.x < 0 || position.x > game.size.x) {
      velocity = Vector2(-velocity.x, velocity.y);
    }
  }
}
