import 'package:flutter/material.dart';

import '../config/const.dart';
import '../config/size_config.dart';

class Ghost extends StatelessWidget {
  const Ghost({
    Key key,
    @required this.droidPositon,
    @required this.colorPosition,
  }) : super(key: key);

  final int droidPositon;
  final int colorPosition;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(bottom: SizeConfig.cellHeight),
      height: SizeConfig.appleSize,
      child: Image.asset(
        ghost(),
        fit: BoxFit.fitHeight,
      ),
    );
  }

  String ghost() {
    String color = GHOST_COLORS[colorPosition];
    int position =
        colorPosition.isEven ? (droidPositon + 2) % 4 : droidPositon % 4;

    return 'assets/elements/ghosts/${color}_$position.png';
  }
}
