import 'package:flame/components.dart';
import 'package:flame/game.dart';

class PipeComponent extends SpriteComponent with HasGameReference<FlameGame> {
  final bool isTop;
  final double speed = 150;

  PipeComponent({required this.isTop});

  @override
  Future<void> onLoad() async {
    sprite = await game.loadSprite(isTop ? 'pipe_top.png' : 'pipe_bottom.png');
    size = Vector2(60, 300);
  }

  @override
  void update(double dt) {
    super.update(dt);
    position.x -= speed * dt;

    // Recycle if off screen
    if (position.x + width < 0) {
      position.x = game.size.x;
    }
  }
}
