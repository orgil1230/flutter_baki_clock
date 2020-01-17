import 'package:flutter/material.dart';

import '../config/size_config.dart';
import './ghost.dart';

/// Colons colors change same as Hour's color every minutes
class Colon extends StatelessWidget {
  const Colon({
    Key key,
    @required this.colorPosition,
  }) : super(key: key);

  final int colorPosition;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: SizeConfig.primaryFontWidth,
      width: SizeConfig.cellHeight * 1.5,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Ghost(colorPosition: colorPosition),
          Ghost(colorPosition: (colorPosition + 1) % 4),
        ],
      ),
    );
  }
}
