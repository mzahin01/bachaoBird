import 'package:flame/collisions.dart'; // For collision detection components
import 'package:flame/components.dart'; // For basic game components like SpriteComponent

// PipeComponent represents a single pipe (top or bottom) in the game.
// It extends SpriteComponent to display an image, and mixes in HasGameReference
// (to access the game instance) and CollisionCallbacks (to handle collisions).
class PipeComponent extends SpriteComponent
    with HasGameReference, CollisionCallbacks {
  // Determines if this pipe is the top pipe (true) or bottom pipe (false)
  final bool isTop;

  // The horizontal speed at which the pipe moves to the left (pixels per second)
  final double speed = 150;

  // Constructor requires you to specify if this is a top or bottom pipe
  PipeComponent({required this.isTop});

  // Called when the component is added to the game
  @override
  Future<void> onLoad() async {
    // Load the appropriate sprite image based on whether this is a top or bottom pipe
    sprite = await game.loadSprite(isTop ? 'pipe_top.png' : 'pipe_bottom.png');
    // Set the size of the pipe (width: 60, height: 300)
    size = Vector2(60, 300);
    // Add a rectangle hitbox for collision detection
    add(RectangleHitbox());
  }

  // Called every frame; dt is the time since the last update (in seconds)
  @override
  void update(double dt) {
    super.update(dt);
    // Move the pipe left by (speed * dt) pixels
    position.x -= speed * dt;
    // If the pipe has moved completely off the left side of the screen,
    // reset its position to the right edge (recycling the pipe)
    if (position.x + width < 0) {
      position.x = game.size.x;
    }
  }
}
