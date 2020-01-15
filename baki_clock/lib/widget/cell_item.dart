import 'package:flutter/material.dart';

import '../model/cell.dart';

import './dot.dart';
import './apple.dart';
import './droid.dart';

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
        return Droid(position: cell.position, color: cell.color);

      case CellType.apple:
        return Apple(isBitten: cell.isBitten, color: cell.color);

      case CellType.dot:
        return Dot(color: cell.color, isBitten: cell.isBitten);

      case CellType.space:
        return Container();

      default:
        return Container();
    }
  }
}
