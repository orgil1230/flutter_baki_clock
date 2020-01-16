import 'package:flutter/material.dart';

import '../config/size_config.dart';

const List<String> GHOSTS = <String>[
  'inky',   //blue
  'blinky', //red
  'clyde',  //yellow
  'pinky',  //green
];

class Ghost extends StatelessWidget {
  const Ghost({
    Key key,
    @required this.second,
    @required this.colorPosition,
  }) : super(key: key);

  final int second;
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
    final String ghost = GHOSTS[colorPosition];
    final int position = colorPosition.isEven ? (second + 2) % 4 : second % 4;

    return 'assets/elements/ghosts/${ghost}_$position.png';
  }
}
