// Import statements - these bring in external functionality
import 'package:flame/game.dart'; // Flame game engine for 2D games
import 'package:flutter/material.dart'; // Flutter UI framework
import 'package:get/get.dart'; // GetX state management library
import '../../flame/bachao.dart'; // Your custom game class (FlappyGame)
import '../controllers/home_controller.dart'; // GetX controller for this view

// HomeView extends GetView<HomeController> - this connects the view to a GetX controller
// GetView automatically provides access to the controller via 'controller' property
class HomeView extends GetView<HomeController> {
  const HomeView({super.key});

  @override
  Widget build(BuildContext context) {
    // Create an instance of your Flame game
    // This is the actual game logic and rendering engine
    final game = FlappyGame();

    return Scaffold(
      body: Center(
        child: GameWidget(
          // GameWidget is Flame's bridge between Flutter widgets and Flame games
          // It renders your game inside a Flutter widget tree
          game: game,

          // overlayBuilderMap defines UI overlays that can appear on top of your game
          // These are Flutter widgets that render over the game canvas
          overlayBuilderMap: {
            // 'GameOver' is the overlay name/key
            // When game.overlays.add('GameOver') is called, this builder runs
            'GameOver': (_, game) => buildRestartButton(game as FlappyGame),
            //           ^context ^game instance
          },
        ),
      ),
    );
  }

  // This method builds the restart button overlay
  // It's called when the 'GameOver' overlay is active
  Widget buildRestartButton(FlappyGame game) {
    return Center(
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(backgroundColor: Colors.white),
        onPressed: () {
          // When button is pressed, reset the game state
          game.reset(); // Calls your custom reset method in FlappyGame
          game.overlays.remove('GameOver'); // Hides this overlay
          game.resumeEngine(); // Resumes the game loop (if paused)
        },
        child: const Text('Restart', style: TextStyle(color: Colors.black)),
      ),
    );
  }
}
