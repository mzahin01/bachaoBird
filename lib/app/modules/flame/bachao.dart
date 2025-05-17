import 'package:flame/components.dart';
import 'package:flame/events.dart';
import 'package:flame/game.dart';
import 'package:flame/input.dart';
import 'package:flutter/material.dart';

class FlappyGame extends FlameGame with TapDetector {
  late SpriteComponent bird;
  double velocityY = 0.0;
  final double gravity = 1200; // pixels per second²
  final double flapStrength = -500; // upward velocity

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
  }

  @override
  void update(double dt) {
    super.update(dt);

    velocityY += gravity * dt;
    bird.position.y += velocityY * dt;

    // Prevent bird from going below the screen
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
