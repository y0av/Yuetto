import 'package:flutter/material.dart';

class AppTheme {
  static final Paint paintObstacle = Paint()
    ..color = Colors.blueGrey
/*    ..shader = const LinearGradient(
      begin: Alignment.topRight,
      end: Alignment.bottomLeft,
      colors: [
        Colors.blue,
        Colors.red,
      ],
    ).createShader(Rect.zero)*/
    ..style = PaintingStyle.fill;

  static const double strokeWidth = 1;
  static final Paint paintCircleStroke = Paint()
    ..color = Colors.white24
    ..strokeWidth = strokeWidth
    ..style = PaintingStyle.stroke;
  static final Paint paint1 = Paint()..color = Colors.purple;
  static final Paint paint2 = Paint()..color = Colors.tealAccent;

  static final Paint error = Paint()..color = Colors.red;
}
