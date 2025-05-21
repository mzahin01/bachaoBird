import 'package:flame/components.dart';
import 'package:flame/collisions.dart';

class Bird extends SpriteComponent with HasGameReference, CollisionCallbacks {
  double velocityY = 0.0;
  final double gravity = 800;
  final double flapStrength = -300;

  Bird();

  @override
  Future<void> onLoad() async {
    sprite = await game.loadSprite('bird.png');
    size = Vector2(50, 50);
    position = Vector2(game.size.x / 4, game.size.y / 2);

    add(RectangleHitbox());
  }

  @override
  void update(double dt) {
    super.update(dt);
    velocityY += gravity * dt;
    position.y += velocityY * dt;

    if (position.y > game.size.y - size.y) {
      position.y = game.size.y - size.y;
      velocityY = 0;
    }
  }

  void flap() {
    velocityY = flapStrength;
  }

  @override
  void onCollision(Set<Vector2> intersectionPoints, PositionComponent other) {
    super.onCollision(intersectionPoints, other);
    game.pauseEngine();
    // print('Game Over!');
  }
}
