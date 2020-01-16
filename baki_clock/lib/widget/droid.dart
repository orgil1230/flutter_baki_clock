import 'package:flutter/material.dart';

import '../config/size_config.dart';

const int START_TOP_SIDE = 101;
const int START_RIGHT_SIDE = 19;
const int START_BOTTOM_SIDE = 41;
const int START_LEFT_SIDE = 79;
const String DROID_IDLE = 'droid_idle.png';
const String DROID_OPEN_MOUTH_LEFT = 'droid_open_mouth_left.png';
const String DROID_OPEN_MOUTH_RIGHT = 'droid_open_mouth_right.png';

class Droid extends StatelessWidget {
  const Droid({
    Key key,
    @required this.position,
    @required this.color,
  }) : super(key: key);

  final int position;
  final Color color;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: SizeConfig.droidSize,
      width: SizeConfig.droidSize,
      child: RotatedBox(
        quarterTurns: droidTurn(),
        child: Image.asset(
          'assets/elements/${droid()}',
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

  /*          horizontal: 39
    101 102 * * * * 0 * * * * 18 19
    100                          20
      *                           *
      *                           *
      *                           *  vertical: 23
      *                           *
     80                          40
     79 78  * * * * * * * * * 42 41
  */
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
