import 'dart:math';

import 'package:flame/collisions.dart';
import 'package:flame/components.dart';
import 'package:flame/game.dart';
import 'package:flutter/material.dart';
import 'package:pinball/components/obstacle.dart';
import 'package:pinball/components/player.dart';
import 'package:pinball/constants/app_preferences.dart';
import 'package:pinball/constants/app_theme.dart';

enum HandSide { left, right }

class PlayerHand extends PositionComponent with CollisionCallbacks {
  PlayerHand({required this.handSide, required this.player}) : super();
  HandSide handSide;
  Player player;
  double get _handSign => (handSide == HandSide.left) ? -1 : 1;
  @override
  NotifyingVector2 get position =>
      NotifyingVector2.copy(Vector2(cos(player.angle), sin(player.angle)) *
          AppPrefs.horizontalOffset *
          _handSign);
/*  NotifyingVector2 get position =>
      NotifyingVector2.copy(Matrix2.rotation(-player.angle * 3)
          .transformed(Vector2(AppPrefs.horizontalOffset * _handSign, 0)));*/

/*  NotifyingVector2 get position => NotifyingVector2(
      cos(player.angle) * AppPrefs.horizontalOffset * _handSign,
      sin(player.angle) * AppPrefs.horizontalOffset * _handSign);*/

  @override
  Future<void> onLoad() async {
    CircleHitbox hand = CircleHitbox(
      position: Vector2(
          (handSide == HandSide.left)
              ? -AppPrefs.horizontalOffset
              : AppPrefs.horizontalOffset,
          0),
      radius: AppPrefs.radius,
      anchor: Anchor.center,
    )
      ..renderShape = true
      ..paint = (handSide == HandSide.left) ? AppTheme.paint1 : AppTheme.paint2;
    //add(Trail(playerHand: this));
    add(hand);
  }

  Paint getPaint() {
    return (handSide == HandSide.left) ? AppTheme.paint1 : AppTheme.paint2;
  }

  @override
  void onCollisionStart(
      Set<Vector2> intersectionPoints, PositionComponent other) {
    super.onCollisionStart(intersectionPoints, other);
    //super.onCollision(intersectionPoints, other);
    if (other is FallingComponent) {
      print('Collision with ${other.runtimeType}');
      (parent as Player).gotHit(intersectionPoints, other, handSide);
    }
  }

  @override
  void render(Canvas canvas) {
    //print(player.angle);
  }
}
