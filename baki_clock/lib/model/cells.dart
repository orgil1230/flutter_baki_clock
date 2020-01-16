import 'dart:async';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:states_rebuilder/states_rebuilder.dart';

import '.././config/utils.dart';
import './cell.dart';
import './point.dart';

const int MILLI_SECOND = 1000; // 1 sec  = 1000 milliseconds
const int MOVE_SPEED = 500; //Droid move every 500 milliseconds 1 cell
const int POSITION_RESET = 119; // 59.5 second reset all
const int QUARTER_DIVIDE_CELLS = 30; //30 cells = 15 seconds

final List<Point> pathList = Utils.generatePathCoordinate();
final List<Color> dotColors = Utils.generateDotColors();

class Cells extends StatesRebuilder {
  Cells() {
    _setFirstDroidPosition();
    prepareCells();
  }

  final List<Cell> _items = <Cell>[];
  int _droidPosition;
  DateTime _now = DateTime.now();
  Timer _timer;

  List<Cell> get items => _items;

  void prepareCells() {
    int position = 0;
    for (final Point point in pathList) {
      final bool isBitten = position <= _droidPosition;
      final Color color = dotColors[(position / 2).round() % 60];

      _items.add(
        Cell(
          position: position,
          isBitten: isBitten,
          color: color,
          type: getCellType(position),
          mood: getCellType(position, droidPosition: _droidPosition),
          point: point,
        ),
      );
      position++;
    }
  }

  CellType getCellType(int position, {int droidPosition}) {
    if (position == droidPosition) {
      return CellType.droid;
    } else if (position % QUARTER_DIVIDE_CELLS == 0) {
      return CellType.apple;
    } else if (position.isEven) {
      return CellType.dot;
    } // dots every seconds

    return CellType.space;
    // Odd positions are an empty cells. (Every 0.5 seconds 1 empty cell)
  }

  void toBite(Cell cell) {
    cell.mood = cell.type;
    cell.isBitten = true;
    rebuildStates(['${cell.position}']);
  }

  Future<void> toReset(int droidPosition) async {
    if (droidPosition == POSITION_RESET) {
      int i = 0;
      int k = 0;
      for (final Cell item in _items) {
        item.isBitten = false;
        i++;
        if (i == 15) {
          for (int j = 15 * k; j < 15 * (k + 1); j++) {
            rebuildStates(['$j']); //TODO : split animations
          }
          await Future<void>.delayed(const Duration(seconds: 1));
          i = 0;
          k++;
        }
      }
    }
  }

  void stopTimer() {
    _timer?.cancel();
  }

  /* Let we know first Droid Position
   * Only app first time sleep until round integer second : 1.003 + sleep(0.997s) ~ 2, 1.450 + sleep(0.150s) ~ 2
   * Then _updateTime beginning of new second and fractionalSecond will be < 500milliseconds.*/
  void _setFirstDroidPosition() {
    _now = DateTime.now();
    final int second = int.parse(DateFormat('s').format(_now));
    int fractionalSecond = int.parse(DateFormat('S').format(_now));
    fractionalSecond = MILLI_SECOND - fractionalSecond;

    sleep(Duration(milliseconds: fractionalSecond));
    _droidPosition = second * 2 + 1;
  }

  /* Update droid position per 0.5 second. Make sure to do it at the beginning of each
   * new second, so that the clock is accurate.
   * Testing on emulator for 3 days and proved no mistake.*/
  void moveDroid() {
    _now = DateTime.now();
    final int second = int.parse(DateFormat('s').format(_now));
    final int fractionalSecond = int.parse(DateFormat('S').format(_now));
    int sleepTime = 0;

    toBite(_items[_droidPosition]); //previous position bitten and default type

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

    toReset(_droidPosition); // if droid position = 119 reset all

    _timer = Timer(
      Duration(milliseconds: sleepTime),
      moveDroid,
    );
  }
}
