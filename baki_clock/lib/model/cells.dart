import 'dart:io';

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:states_rebuilder/states_rebuilder.dart';

import '.././config/utils.dart';
import '.././config/const.dart';
import './cell.dart';

final List<dynamic> pathList = Utils.generatePathCoordinate();
final List<Color> dotColors = Utils.generateDotColors();

class Cells extends StatesRebuilder {
  var _items = <Cell>[];
  var _droidPosition;
  var _now = DateTime.now();

  Cells() {
    _setFirstDroidPosition();
    prepareCells();
  }

  List<Cell> get items => _items;

  get position => _droidPosition;
  set setPosition(int position) {
    if (_droidPosition != position) {
      _droidPosition = position;
      rebuildStates();
    }
  }

  void prepareCells() {
    int position = 0;
    for (var point in pathList) {
      bool isBitten = position <= _droidPosition;
      Color color = dotColors[(position / 2).round() % 60];

      _items.add(
        new Cell(
          position: position,
          isBitten: isBitten,
          color: color,
          cellType: getCellType(position),
          mood: getCellType(position, droidPosition: _droidPosition),
          point: point,
          animate: false,
        ),
      );
      position++;
    }
  }

  CellType getCellType(int position, {int droidPosition}) {
    if (position == droidPosition)
      return CellType.droid;
    else if (position % QUARTER_DIVIDE_CELLS == 0)
      return CellType.apple;
    // There are apples in every 15 seconds = 30 cells
    else if (position.isEven) return CellType.dot; // dots every seconds

    return CellType.space;
    // Odd positions are an empty cells. (Every 0.5 seconds 1 empty cell)
  }

  void toBite(Cell cell) {
    cell.mood = cell.cellType;
    cell.isBitten = true;
    rebuildStates(['${cell.position}']);
  }

  void toReset() {
    for (var item in _items) {
      item.isBitten = false;
    }
    rebuildStates();
  }

  /* Let we know first Droid Position
   * Only app first time sleep until round integer second : 1.003 + sleep(0.997s) ~ 2, 1.450 + sleep(0.150s) ~ 2
   * Then _updateTime beginning of new second and fractionalSecond will be < 500milliseconds.*/
  void _setFirstDroidPosition() {
    _now = DateTime.now();
    int second = int.parse(DateFormat('s').format(_now));
    int fractionalSecond = int.parse(DateFormat('S').format(_now));
    fractionalSecond = MILLI_SECOND - fractionalSecond;

    sleep(Duration(milliseconds: fractionalSecond));
    _droidPosition = second * 2 + 1;
  }

  /* Update droid position per 0.5 second. Make sure to do it at the beginning of each
   * new second, so that the clock is accurate.
   * Testing on emulator for 3 days and proved no mistake.*/
  Future<void> moveDroid() async {
    _now = DateTime.now();
    int second = int.parse(DateFormat('s').format(_now));
    int fractionalSecond = int.parse(DateFormat('S').format(_now));
    var sleepTime = 0;

    toBite(_items[_droidPosition]);

    if (_droidPosition.isOdd) {
      sleepTime = fractionalSecond > MOVE_SPEED //Just in case
          ? fractionalSecond - MOVE_SPEED
          : MOVE_SPEED - fractionalSecond;
      _droidPosition = second * 2;
    } else {
      sleepTime = MILLI_SECOND - fractionalSecond;
      _droidPosition = second * 2 + 1;
    }

    _items[_droidPosition].mood = CellType.droid;
    rebuildStates(['$_droidPosition']); //Most useful part of my app

    if (_droidPosition == POSITION_RESET) toReset();

    await Future.delayed(Duration(milliseconds: sleepTime), moveDroid);
  }
}
