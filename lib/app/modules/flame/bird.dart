import 'package:flame/components.dart';
import 'package:flame/collisions.dart';

// The Bird class represents the player character in the game.
// It extends SpriteComponent to display an image, and mixes in
// HasGameReference (to access the game instance) and CollisionCallbacks (to handle collisions).
class Bird extends SpriteComponent with HasGameReference, CollisionCallbacks {
  // The vertical velocity of the bird (positive is falling, negative is rising).
  double velocityY = 0.0;

  // The acceleration due to gravity (pixels per second squared).
  final double gravity = 800;

  // The upward force applied when the bird "flaps" (negative to go up).
  final double flapStrength = -300;

  // Constructor for the Bird class.
  Bird();

  // Called when the Bird is added to the game.
  @override
  Future<void> onLoad() async {
    // Load the bird sprite image from assets.
    sprite = await game.loadSprite('bird.png');

    // Set the size of the bird (width: 50, height: 50).
    size = Vector2(50, 50);

    // Set the initial position of the bird (1/4th width, center height).
    position = Vector2(game.size.x / 4, game.size.y / 2);

    // Add a rectangular hitbox for collision detection.
    add(RectangleHitbox());
  }

  // Called every frame to update the bird's state.
  @override
  void update(double dt) {
    super.update(dt);

    // Apply gravity to the vertical velocity.
    velocityY += gravity * dt;

    // Move the bird vertically based on its velocity.
    position.y += velocityY * dt;

    // Prevent the bird from falling below the bottom of the screen.
    if (position.y > game.size.y - size.y) {
      position.y = game.size.y - size.y;
      velocityY = 0;
    }
  }

  // Called when the player makes the bird "flap" (jump).
  void flap() {
    // Set the vertical velocity to the flap strength (makes the bird go up).
    velocityY = flapStrength;
  }

  // Called when the bird collides with another component.
  @override
  void onCollision(Set<Vector2> intersectionPoints, PositionComponent other) {
    super.onCollision(intersectionPoints, other);

    // Pause the game engine (typically used for game over).
    game.pauseEngine();

    // Uncomment the line below to print "Game Over!" to the console.
    // print('Game Over!');
  }
}
