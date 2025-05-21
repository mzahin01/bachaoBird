import 'package:flame/components.dart'; // Imports Flame's components, such as SpriteComponent, which is used to represent game objects.
import 'package:flame/events.dart'; // Imports event handling utilities, like TapDetector, to handle user input.
import 'package:flame/game.dart'; // Imports the base game class from Flame, which provides the game loop and rendering logic.
import 'package:flame/input.dart'; // Imports input utilities for handling user interactions.
import 'package:flutter/material.dart';

import 'pipe.dart'; // Imports Flutter's Material package for UI elements and colors.

class FlappyGame extends FlameGame with TapDetector {
  late SpriteComponent bird;
  double velocityY = 0.0;
  final double gravity = 800;
  final double flapStrength = -300;

  late PipeComponent topPipe;
  late PipeComponent bottomPipe;

  @override
  Color backgroundColor() => const Color(0xFF87CEEB);

  @override
  Future<void> onLoad() async {
    final birdSprite = await loadSprite('bird.png');
    bird =
        SpriteComponent()
          ..sprite = birdSprite
          ..size = Vector2(50, 50)
          ..position = Vector2(size.x / 4, size.y / 2);
    add(bird);

    topPipe = PipeComponent(isTop: true)
      ..position = Vector2(size.x, -100); // Move up
    bottomPipe = PipeComponent(isTop: false)
      ..position = Vector2(size.x, size.y - 200); // Move down

    addAll([topPipe, bottomPipe]);
  }

  @override
  void update(double dt) {
    super.update(dt);

    velocityY += gravity * dt;
    bird.position.y += velocityY * dt;

    if (bird.position.y > size.y - bird.size.y) {
      bird.position.y = size.y - bird.size.y;
      velocityY = 0;
    }
  }

  @override
  void onTapDown(TapDownInfo info) {
    velocityY = flapStrength;
  }
}
