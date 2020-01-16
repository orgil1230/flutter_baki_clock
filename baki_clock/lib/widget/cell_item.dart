import 'package:flutter/material.dart';

import '../model/cell.dart';

import './apple.dart';
import './dot.dart';
import './droid.dart';

/// This is return current mood(type) of cell.
class CellItem extends StatelessWidget {
  const CellItem({
    Key key,
    @required this.cell,
  }) : super(key: key);

  final Cell cell;

  @override
  Widget build(BuildContext context) {
    switch (cell.mood) {
      case CellType.droid:
        return Droid(color: cell.color, position: cell.position);

      case CellType.apple:
        return Apple(color: cell.color, isBitten: cell.isBitten);

      case CellType.dot:
        return Dot(color: cell.color, isBitten: cell.isBitten);

      case CellType.space:
        return Container();

      default:
        return Container();
    }
  }
}
