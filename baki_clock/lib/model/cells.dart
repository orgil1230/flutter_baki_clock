import 'package:flutter/material.dart';

import '.././config/utils.dart';
import '.././config/const.dart';
import './cell.dart';

final List<dynamic> pathList = Utils.generatePathCoordinate();
final List<Color> dotColors = Utils.generateDotColors();

class Cells {
  List<Cell> _items = [];
  int _droidPosition;

  List<Cell> get items => _items;

  Cells(this._droidPosition) {
    prepareCells();
  }

  void prepareCells() {
    int position = 0;
    pathList.forEach((point) {
      bool isBitten = position <= _droidPosition;
      Color color = dotColors[(position / 2).round() % 60];

      _items.add(
        new Cell(
          position: position,
          isBitten: isBitten,
          color: color,
          cellType: getCellType(position),
          point: point,
          animate: _droidPosition == 119,
        ),
      );
      position++;
    });
  }

  CellType getCellType(int position) {
    if (position == _droidPosition)
      return CellType.droid;
    else if (position % QUARTER_DIVIDE_CELLS == 0)
      return CellType.apple;
    // There are an apples in every 15 seconds = 30 cells
    else if (position.isEven) return CellType.dot;

    return CellType.space;
    // Odd positions are an empty cells. (Every 0.5 seconds 1 empty cell)
  }
}
