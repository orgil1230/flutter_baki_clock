import 'package:flutter/material.dart';

import '../config/size_config.dart';

const int startTop = 101;
const int startRight = 19;
const int startBottom = 41;
const int startLeft = 79;
const String DROID_IDLE = 'droid_idle.png';
const String DROID_OPEN_MOUTH_LEFT = 'droid_open_mouth_left.png';
const String DROID_OPEN_MOUTH_RIGHT = 'droid_open_mouth_right.png';

/// Droid cell element has 2 type. And change color every half seconds.
class Droid extends StatelessWidget {
  const Droid({
    Key key,
    @required this.color,
    @required this.position,
  }) : super(key: key);

  final Color color;
  final int position;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: SizeConfig.droidSize,
      width: SizeConfig.droidSize,
      child: RotatedBox(
        quarterTurns: turnQuarter(),
        child: Image.asset(
          'assets/elements/${droidType()}',
          fit: BoxFit.contain,
          alignment: Alignment.center,
          color: color,
        ),
      ),
    );
  }

  /// Some logic for droid's type
  String droidType() {
    return position.isEven
        ? DROID_IDLE
        : turnQuarter() >= 4 ? DROID_OPEN_MOUTH_LEFT : DROID_OPEN_MOUTH_RIGHT;
  }

  /// Droid turn using [RotateBox]
  /// 101 * * * * * * * * * * * ** 19
  /// *                             *
  /// *                             *
  /// *                             *
  /// *   Droid's turn positions    *
  /// *                             *
  /// *                             *
  /// 79 * * * * * * * * * * * * * 41
  int turnQuarter() {
    if (position >= startTop || position <= startRight) {
      return 0; // droid move left to right
    }
    if (position <= startBottom) {
      return 1; // droid move right to left
    }
    if (position <= startLeft) {
      return 4; // droid move bottom to top
    }
    return 5; // droid move top to bottom
  }
}
