import 'package:flutter/material.dart';

import '../config/size_config.dart';
import './ghost.dart';

/// Colons colors change same as Hour's color every minutes
class Colon extends StatelessWidget {
  const Colon({
    Key key,
    @required this.second,
    @required this.colorPosition,
  }) : super(key: key);

  final int second;
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
            second: second,
            colorPosition: colorPosition,
          ),
          Ghost(
            second: second,
            colorPosition: (colorPosition + 1) % 4,
          ),
        ],
      ),
    );
  }
}
