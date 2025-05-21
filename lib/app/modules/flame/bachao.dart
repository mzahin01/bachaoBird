import 'package:flame/events.dart'; // Imports event handling utilities, like TapDetector, to handle user input.
import 'package:flame/game.dart'; // Imports the base game class from Flame, which provides the game loop and rendering logic.
import 'package:flame/input.dart'; // Imports input utilities for handling user interactions.
import 'package:flutter/material.dart';

import 'bird.dart';
import 'pipe.dart'; // Imports Flutter's Material package for UI elements and colors.

class FlappyGame extends FlameGame with TapDetector, HasCollisionDetection {
  late Bird bird;
  late PipeComponent topPipe;
  late PipeComponent bottomPipe;

  @override
  Color backgroundColor() => const Color(0xFF87CEEB);

  @override
  Future<void> onLoad() async {
    bird = Bird();
    topPipe = PipeComponent(isTop: true)..position = Vector2(size.x, -100);
    bottomPipe = PipeComponent(isTop: false)
      ..position = Vector2(size.x, size.y - 200);

    addAll([bird, topPipe, bottomPipe]);
  }

  @override
  void onTapDown(TapDownInfo info) {
    bird.flap();
  }
}
