import 'package:flutter/material.dart';

import '../config/const.dart';
import '../config/size_config.dart';

class Droid extends StatelessWidget {
  const Droid({
    Key key,
    @required this.position,
    @required this.color,
  }) : super(key: key);

  final position;
  final color;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: SizeConfig.droidSize,
      width: SizeConfig.droidSize,
      child: RotatedBox(
        quarterTurns: droidTurn(),
        child: Image.asset(
          droid(),
          fit: BoxFit.contain,
          alignment: Alignment.center,
          color: color,
        ),
      ),
    );
  }

  String droid() {
    return position.isEven
        ? DROID_IDLE
        : droidTurn() >= 4 ? DROID_OPEN_MOUTH_LEFT : DROID_OPEN_MOUTH_RIGHT;
  }

  int droidTurn() {
    if (position >= START_TOP_SIDE || position <= START_RIGHT_SIDE) {
      return 0; // droid move left to right
    }
    if (position <= START_BOTTOM_SIDE) {
      return 1; // droid move right to left
    }
    if (position <= START_LEFT_SIDE) {
      return 4; // droid move bottom to top
    }
    return 5; // droid move top to bottom
  }
}
