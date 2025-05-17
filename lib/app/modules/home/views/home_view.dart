import 'package:flame/game.dart';
import 'package:flutter/material.dart';

import 'package:get/get.dart';

import '../../flame/bachao.dart';
import '../controllers/home_controller.dart';

class HomeView extends GetView<HomeController> {
  const HomeView({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(body: Center(child: GameWidget(game: FlappyGame())));
  }
}
