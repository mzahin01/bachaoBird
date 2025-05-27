import 'package:flame/events.dart'; // For handling user input events, like taps.
import 'package:flame/game.dart'; // Provides the FlameGame base class for the game loop and rendering.
import 'package:flame/input.dart'; // Additional input utilities for user interactions.
import 'package:flutter/material.dart'; // For using Flutter's Color class and other UI elements.

import 'bird.dart'; // Imports the Bird class/component (your player).
import 'pipe.dart'; // Imports the PipeComponent class (the obstacles).

// The main game class, extending FlameGame.
// Also mixes in TapDetector (to handle tap events) and HasCollisionDetection (for collision logic).
class FlappyGame extends FlameGame with TapDetector, HasCollisionDetection {
  late Bird bird; // The player character.
  late PipeComponent topPipe; // The top obstacle.
  late PipeComponent bottomPipe; // The bottom obstacle.

  // Sets the background color of the game to a sky blue.
  @override
  Color backgroundColor() => const Color(0xFF87CEEB);

  // Called when the game is loaded.
  @override
  Future<void> onLoad() async {
    bird = Bird(); // Create the bird/player.

    // Create the top pipe, position it at the right edge (size.x), and above the screen (-100).
    topPipe = PipeComponent(isTop: true)..position = Vector2(size.x, -100);

    // Create the bottom pipe, position it at the right edge (size.x), and near the bottom (size.y - 200).
    bottomPipe = PipeComponent(isTop: false)
      ..position = Vector2(size.x, size.y - 200);

    // Add all components to the game so they are rendered and updated.
    addAll([bird, topPipe, bottomPipe]);
  }

  // Called when the user taps the screen.
  @override
  void onTapDown(TapDownInfo info) {
    bird.flap(); // Make the bird "flap" (jump upwards).
  }

  void reset() {
    bird.velocityY = 0;
    bird.position = Vector2(size.x / 4, size.y / 2);

    topPipe.position = Vector2(size.x, -100);
    bottomPipe.position = Vector2(size.x, size.y - 200);
  }
}
