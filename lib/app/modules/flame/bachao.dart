import 'package:flame/components.dart';
import 'package:flame/game.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(GameWidget(game: FlappyGame()));
}

class FlappyGame extends FlameGame {
  late SpriteComponent bird;

  @override
  Color backgroundColor() => const Color(0xFF87CEEB);

  @override
  Future<void> onLoad() async {
    final birdSprite = await loadSprite('bird.png');
    bird =
        SpriteComponent()
          ..sprite = birdSprite
          ..size = Vector2(50, 50) // Width, height
          ..position = size / 2; // Center of the screen

    add(bird);
  }
}
