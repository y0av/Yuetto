import 'package:flame/components.dart';
import 'package:flame/palette.dart';
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
  static final Paint paint2 = Paint()..color = Colors.lightGreen;
  static final Paint paint3 = Paint()..color = Colors.blueGrey;
  static final Paint error = Paint()..color = Colors.red;
  static const Color shadow = Colors.black12;
  static final TextStyle regularTextStyle =
      TextStyle(fontSize: 16, color: BasicPalette.white.color);
  static final TextPaint regularTextPaint = TextPaint(style: regularTextStyle);
}
