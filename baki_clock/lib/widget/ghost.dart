import 'package:flutter/material.dart';
import 'package:states_rebuilder/states_rebuilder.dart';

import '../config/size_config.dart';
import '../model/cells.dart';

const List<String> GHOSTS = <String>[
  'inky', //blue
  'blinky', //red
  'clyde', //yellow
  'pinky', //green
];

/// Ghost animate every half seconds
class Ghost extends StatelessWidget {
  const Ghost({
    Key key,
    @required this.colorPosition,
  }) : super(key: key);

  final int colorPosition;

  @override
  Widget build(BuildContext context) {
    final Cells cells = Injector.get<Cells>();
    return StateBuilder<Cells>(
      models: <Cells>[cells],
      tag: CellsTag.ghostWidget,
      builder: (BuildContext context, ReactiveModel<Cells> model) => Container(
        margin: EdgeInsets.only(bottom: SizeConfig.cellHeight),
        height: SizeConfig.appleSize,
        child: Image.asset(
          ghost(cells),
          fit: BoxFit.fitHeight,
        ),
      ),
    );
  }

  String ghost(Cells cells) {
    final String ghost = GHOSTS[colorPosition];

    /// This logic for 2 ghosts position's difference
    final int position = colorPosition.isEven
        ? (cells.droidPosition + 2) % 4
        : cells.droidPosition % 4;

    return 'assets/elements/ghosts/${ghost}_$position.png';
  }
}
