import 'dart:ui';

import 'package:flutter/material.dart';

import '../model/point.dart';
import './const.dart';

const int X_AXIS_MAX = 38; // 39x23 Grid 120 cells
const int Y_AXIS_MAX = 22; // 39x23 Grid 120 cells
const int POSITION_ZERO = 41; // 0th or 60th second's position in pathList
const int QUARTER_SECONDS = 15; // Gradient color change every 60/4 = 15 seconds

class Utils {
  static List<Color> generateDotColors() {
    final List<Color> _dotColors = <Color>[];
    double _interpolation;

    for (int i = 0; i < Const.GOOGLE_COLORS.length; i++) {
      for (int j = 0; j < QUARTER_SECONDS; j++) {
        _interpolation = double.parse((j / QUARTER_SECONDS).toStringAsFixed(2));
        _dotColors.add(
          Color.lerp(
            Const.GOOGLE_COLORS[i],
            Const.GOOGLE_COLORS[(i + 1) % Const.GOOGLE_COLORS.length],
            _interpolation,
          ),
        );
      }
    }

    return _dotColors;
  }

  static List<Point> generatePathCoordinate() {
    int _x = 0;
    int _y = 0;
    int _addend = 1;
    List<Point> _tempBoard = <Point>[];

    while ((_y < Y_AXIS_MAX && _addend > 0) || (_y > 0 && _addend < 0)) {
      _tempBoard.add(Point(_x.toDouble(), _y.toDouble()));
      _y += _addend;

      if ((_y == Y_AXIS_MAX && _addend > 0) || (_y == 0 && _addend < 0)) {
        while ((_x < X_AXIS_MAX && _addend > 0) || (_x > 0 && _addend < 0)) {
          _tempBoard.add(Point(_x.toDouble(), _y.toDouble()));
          _x += _addend;

          if (_x == X_AXIS_MAX) {
            _addend = -1;
            break;
          }
        }
      }
    }

    /*        horizontal: 39
    101 102 * * * * 0 * * * * 18 19
    100                          20
      *                           *
      *                           *
      *                           *  vertical: 23
      *                           *
     80                          40
     79 78  * * * * * * * * * 42 41
              calculate this
    */
    _tempBoard = List<Point>.from(_tempBoard.sublist(POSITION_ZERO))
      ..addAll(_tempBoard.sublist(0, POSITION_ZERO));

    return _tempBoard;
  }
}
