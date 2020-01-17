import 'dart:ui';

import 'package:flutter/material.dart';

import '../model/point.dart';
import 'const.dart';

class Utils {
  /// Generate gradient colors for cells (Droid, Dots).
  static List<Color> calculateDotColors() {
    // Gradient color change every 60/4 = 15 seconds
    const int quarterSeconds = 15;
    final List<Color> dotColors = <Color>[];
    double interpolation;

    for (int i = 0; i < Const.googleColors.length; i++) {
      for (int j = 0; j < quarterSeconds; j++) {
        interpolation = double.parse((j / quarterSeconds).toStringAsFixed(2));

        dotColors.add(
          Color.lerp(
            Const.googleColors[i],
            Const.googleColors[(i + 1) % 4],
            interpolation,
          ),
        );
      }
    }

    return dotColors;
  }

  ///        horizontal: 39
  /// 101 102 * * 119 0 1 * * * 18 19
  /// 100                          20
  /// *                             *
  /// *                             *
  /// *                             *  vertical: 23
  /// *                             *
  /// 80                           40
  /// 79 78 * * * * * * * * * * 42 41
  static List<Point> calculatePathPoints() {
    const int positionZero = 41; // 0th && 60th second's position in pathList
    const int xMax = 38; // 39 horizontal
    const int yMax = 22; // 23 vertical

    List<Point> pathPoints = <Point>[];
    int addend = 1;
    int x = 0;
    int y = 0;

    while ((y < yMax && addend > 0) || (y > 0 && addend < 0)) {
      pathPoints.add(Point(x.toDouble(), y.toDouble()));
      y += addend;

      if ((y == yMax && addend > 0) || (y == 0 && addend < 0)) {
        while ((x < xMax && addend > 0) || (x > 0 && addend < 0)) {
          pathPoints.add(Point(x.toDouble(), y.toDouble()));
          x += addend;

          if (x == xMax) {
            addend = -1;
            break;
          }
        }
      }
    }

    pathPoints = List<Point>.from(pathPoints.sublist(positionZero))
      ..addAll(pathPoints.sublist(0, positionZero));

    return pathPoints;
  }
}
