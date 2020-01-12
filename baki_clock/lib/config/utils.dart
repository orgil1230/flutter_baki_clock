import 'dart:ui';

import 'package:flutter/material.dart';

import '../model/point.dart';
import './const.dart';

class Utils {
  static List<Color> generateDotColors() {
    List<Color> _dotColors = new List<Color>(); // Color(0xff505786);
    double _interpolation;

    for (int i = 0; i < GOOGLE_COLORS.length; i++) {
      for (int j = 0; j < QUARTER_SECONDS; j++) {
        _interpolation = double.parse((j / QUARTER_SECONDS).toStringAsFixed(2));
        _dotColors.add(
          Color.lerp(
            GOOGLE_COLORS[i],
            GOOGLE_COLORS[(i + 1) % GOOGLE_COLORS.length],
            _interpolation,
          ),
        );
      }
    }

    return _dotColors;
  }

  static List<dynamic> generatePathCoordinate() {
    int _x = 0;
    int _y = 0;
    int _addend = 1;
    List<dynamic> _tempBoard = [];

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

    _tempBoard = new List.from(_tempBoard.sublist(POSITION_ZERO))
      ..addAll(_tempBoard.sublist(0, POSITION_ZERO));
  /*              {39}
    101 102 * * * * 0 * * * * 18 19
    100                          20
      *                           *
      *                           *
      *                           *  {23}
      *                           *
     80                          40
     79 78  * * * * * * * * * 42 41
     calculate this :)
  */

    return _tempBoard;
  }
}
