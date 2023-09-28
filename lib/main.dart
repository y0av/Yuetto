import 'package:flame/game.dart';
import 'package:flutter/widgets.dart';
import 'package:pinball/game.dart';

void main() {
  runApp(const GameWidget.controlled(gameFactory: PinballGame.new));
}
