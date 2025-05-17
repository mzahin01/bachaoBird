import 'package:flame/game.dart';
import 'package:flutter/material.dart';

class FlappyGame extends FlameGame {
  @override
  Color backgroundColor() => const Color(0xFF87CEEB); // Sky blue

  @override
  Future<void> onLoad() async {
    // This will be used to load bird and pipe assets later.
    super.onLoad();
  }

  @override
  void update(double dt) {
    super.update(dt);
    // Game logic like gravity and movement will go here.
  }

  @override
  void render(Canvas canvas) {
    super.render(canvas);
    // Custom drawing (if needed)
  }
}
