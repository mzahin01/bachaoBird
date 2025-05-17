import 'package:flame/components.dart'; // Imports Flame's components, such as SpriteComponent, which is used to represent game objects.
import 'package:flame/events.dart'; // Imports event handling utilities, like TapDetector, to handle user input.
import 'package:flame/game.dart'; // Imports the base game class from Flame, which provides the game loop and rendering logic.
import 'package:flame/input.dart'; // Imports input utilities for handling user interactions.
import 'package:flutter/material.dart'; // Imports Flutter's Material package for UI elements and colors.

class FlappyGame extends FlameGame with TapDetector {
  // Defines a game class that extends FlameGame and mixes in TapDetector to handle tap events.

  late SpriteComponent bird;
  // Declares a variable to hold the bird sprite. `late` means it will be initialized later.

  double velocityY = 0.0;
  // Vertical velocity of the bird. Controls how fast the bird moves up or down.
  // Changing this initial value will affect the bird's starting motion (e.g., setting it to a positive value will make the bird fall faster initially).

  final double gravity = 1200;
  // Acceleration due to gravity, in pixels per second squared.
  // Increasing this value will make the bird fall faster. Decreasing it will make the bird fall slower.

  final double flapStrength = -500;
  // The upward velocity applied when the bird flaps.
  // Making this value more negative will make the bird jump higher. Making it less negative will reduce the jump height.

  @override
  Color backgroundColor() => const Color(0xFF87CEEB);
  // Sets the background color of the game to a light blue (sky color).
  // Changing this value will change the background color of the game.

  @override
  Future<void> onLoad() async {
    // Called when the game is loaded. Used to initialize game objects.

    final birdSprite = await loadSprite('bird.png');
    // Loads the bird sprite from an image file named 'bird.png'.
    // If the file name is incorrect or missing, the game will throw an error.

    bird =
        SpriteComponent()
          ..sprite = birdSprite
          // Assigns the loaded sprite to the bird component.
          ..size = Vector2(50, 50)
          // Sets the size of the bird to 50x50 pixels.
          // Changing this will resize the bird. Larger values will make the bird bigger, and smaller values will shrink it.
          ..position = Vector2(size.x / 4, size.y / 2);
    // Positions the bird at 1/4th of the screen width and halfway down the screen height.
    // Changing these values will move the bird's starting position.

    add(bird);
    // Adds the bird component to the game so it can be rendered and updated.
  }

  @override
  void update(double dt) {
    // Called every frame to update the game state. `dt` is the time elapsed since the last frame.

    super.update(dt);
    // Calls the parent class's update method. This ensures any built-in functionality is preserved.

    velocityY += gravity * dt;
    // Increases the bird's vertical velocity due to gravity over time.
    // Changing `gravity` will affect how quickly the velocity increases.

    bird.position.y += velocityY * dt;
    // Updates the bird's vertical position based on its velocity.
    // If you remove this line, the bird will not move vertically.

    if (bird.position.y > size.y - bird.size.y) {
      // Checks if the bird has fallen below the bottom of the screen.
      // Changing this condition could allow the bird to fall off-screen.

      bird.position.y = size.y - bird.size.y;
      // Keeps the bird at the bottom edge of the screen if it falls too far.
      // Removing this line will allow the bird to fall off-screen.

      velocityY = 0;
      // Resets the velocity to 0 when the bird hits the bottom.
      // Removing this line will cause the bird to keep accelerating downward even when it hits the bottom.
    }
  }

  @override
  void onTapDown(TapDownInfo info) {
    // Called when the player taps the screen.

    velocityY = flapStrength;
    // Sets the bird's vertical velocity to the flap strength, making it jump upward.
    // Increasing `flapStrength` will make the bird jump higher. Decreasing it will make the jump weaker.
  }
}
