import 'package:flutter/material.dart';

import '.././model/point.dart';

class Cell {
  final int position;
  final Color color;
  final Point point;
  CellType cellType;
  CellType mood;
  bool isBitten;
  bool animate;

  Cell({
    @required this.position,
    @required this.isBitten,
    @required this.color,
    @required this.cellType,
    @required this.mood,
    @required this.point,
    @required this.animate,
  });
}

enum CellType {
  droid,
  apple,
  dot,
  space,
}
