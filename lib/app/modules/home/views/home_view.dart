import 'package:flame/game.dart';
import 'package:flutter/material.dart';

import 'package:get/get.dart';

import '../../flame/bachao.dart';
import '../controllers/home_controller.dart';

class HomeView extends GetView<HomeController> {
  const HomeView({super.key});

  @override
  Widget build(BuildContext context) {
    final game = FlappyGame();
    return Scaffold(
      body: Center(
        child: GameWidget(
          game: game,
          overlayBuilderMap: {
            'GameOver': (_, game) => buildRestartButton(game as FlappyGame),
          },
        ),
      ),
    );
  }

  Widget buildRestartButton(FlappyGame game) {
    return Center(
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(backgroundColor: Colors.white),
        onPressed: () {
          game.reset();
          game.overlays.remove('GameOver');
          game.resumeEngine();
        },
        child: const Text('Restart', style: TextStyle(color: Colors.black)),
      ),
    );
  }
}
