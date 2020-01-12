import 'package:flutter/material.dart';

import './ghost.dart';
import '../config/size_config.dart';

class Colon extends StatelessWidget {
  const Colon({
    Key key,
    @required this.droidPosition,
    @required this.colorPosition,
  }) : super(key: key);

  final int droidPosition;
  final int colorPosition;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: SizeConfig.primaryFontWidth,
      width: SizeConfig.cellHeight * 1.5,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Ghost(
            droidPositon: droidPosition,
            colorPosition: colorPosition,
          ),
          Ghost(
            droidPositon: droidPosition,
            colorPosition: (colorPosition + 1) % 4,
          ),
        ],
      ),
    );
  }
}
