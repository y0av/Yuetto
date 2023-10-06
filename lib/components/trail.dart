import 'dart:ui';

import 'package:flame/components.dart';
import 'package:pinball/components/player_hand.dart';

class Trail extends Component with HasPaint {
  Trail({
    required this.playerHand,
  }) : super(priority: 1);

  final PlayerHand playerHand;

  final List<Offset> trail = <Offset>[];
  final int _trailLength = 30;

  @override
  Future<void> onLoad() async {
    paint
      ..color = (playerHand.getPaint().color.withOpacity(0.9))
      ..strokeWidth = 5.0;
  }

  @override
  void update(double dt) {
    if (trail.length > _trailLength) {
      trail.removeAt(0);
    }
    final trailPoint = playerHand.position.toOffset();
    trail.add(trailPoint);
    //print('len: ${trail.length} trail: $trail');
  }

  @override
  void render(Canvas canvas) {
    canvas.drawPoints(PointMode.polygon, trail, paint);
  }
}
