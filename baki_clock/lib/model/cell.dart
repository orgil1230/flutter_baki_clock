import 'package:flutter/material.dart';

import './point.dart';

class Cell {
  Cell({
    @required this.color,
    @required this.point,
    @required this.position,
    @required this.isBitten,
    @required this.mood,
    @required this.type,
  });

  final Color color;
  final Point point;
  final int position;
  bool isBitten;
  CellType mood;
  CellType type;
}

enum CellType {
  apple,
  dot,
  droid,
  space,
}
