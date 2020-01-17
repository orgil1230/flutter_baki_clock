import 'dart:async';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:states_rebuilder/states_rebuilder.dart';

import '.././config/utils.dart';
import './cell.dart';
import './point.dart';

enum CellsTag { timeWidget, ghostWidget }

const int milliSecond = 1000; // 1 sec  = 1000 milliseconds
const int moveSpeed = 500; //Droid move every 500 milliseconds 1 cell
const int positionReset = 119; // 59.5 second reset all
const int quarterDivide = 30; // 30 cells = 15 seconds
const int splitCells = 15;

final List<Point> pathList = Utils.calculatePathPoints();
final List<Color> dotColors = Utils.calculateDotColors();

class Cells extends StatesRebuilder {
  Cells() {
    _droidFirstPosition();
    _prepareCells();
  }

  final List<Cell> _items = <Cell>[];
  List<Cell> get items => _items;
  DateTime _now = DateTime.now();
  Timer _timer;
  int _second;
  int get second => _second;
  int _droidPosition;
  int get droidPosition => _droidPosition;

  void cancelTimer() {
    _timer?.cancel();
  }

  /// Little trick for some dots bitten or idle type not changed sometimes.
  /// When app inactive - pause - inactive - resumed.
  void lifecycleState(AppLifecycleState state) {
    if (state == AppLifecycleState.resumed) {
      // Even positions are only dots and apples. +=2. don't need spaces
      for (int i = 0; i < _items.length; i += 2) {
        /// This error happens very rarely and not all of dots and apples.
        /// Then this conditions for split rebuild only not changed dots.
        if (!_items[i].isBitten && i < _droidPosition) {
          _items[i].isBitten = true;
          rebuildStates(['$i']);
        } else if (_items[i].isBitten && i > _droidPosition) {
          _items[i].isBitten = false;
          rebuildStates(['$i']);
        }
      }
    }
  }

  /// Update droid position per 0.5 second. Make sure to do it at
  /// the beginning of each new second, so that the clock is accurate.
  /// Testing on emulator for 3 days and proved no mistake.
  void moveDroid() {
    _now = DateTime.now();
    final int second = int.parse(DateFormat('s').format(_now));
    final int fractionalSecond = int.parse(DateFormat('S').format(_now));
    _second = second;
    int sleepDuration = 0;

    _bittenCell(_items[_droidPosition]);
    _resetCells(_droidPosition);

    if (_droidPosition.isEven) {
      sleepDuration = milliSecond - fractionalSecond;
      _droidPosition = second * 2 + 1;
    } else {
      sleepDuration = fractionalSecond > moveSpeed //Just in case
          ? fractionalSecond - moveSpeed
          : moveSpeed - fractionalSecond;
      _droidPosition = second * 2;
    }

    _droidCell(_items[_droidPosition]);

    _timer = Timer(
      Duration(milliseconds: sleepDuration),
      moveDroid,
    );
  }

  /// We want to beginning of new second. Every second begins [odd] position.
  /// Only first time sleep [sleepDuration] until round integer second :
  /// 1.003 + sleep(0.997s) ~ 2, 1.450 + sleep(0.150s) ~ 2
  /// Then [moveDroid] will begin of new second and fractionalSecond will be < 500milliseconds.
  void _droidFirstPosition() {
    _now = DateTime.now();
    final int second = int.parse(DateFormat('s').format(_now));
    final int fractionalSecond = int.parse(DateFormat('S').format(_now));
    final int sleepDuration = milliSecond - fractionalSecond;
    _second = second;

    _droidPosition = second * 2 + 1;
    sleep(Duration(milliseconds: sleepDuration));
  }

  void _prepareCells() {
    int position = 0;
    for (final Point point in pathList) {
      final bool isBitten = position <= _droidPosition;
      final Color color = dotColors[(position / 2).round() % 60];

      _items.add(
        Cell(
          position: position,
          isBitten: isBitten,
          color: color,
          type: _cellType(position),
          mood: _cellType(position, droidPosition: _droidPosition),
          point: point,
        ),
      );
      position++;
    }
  }

  CellType _cellType(int position, {int droidPosition}) {
    if (position == droidPosition) {
      return CellType.droid;
    } else if (position % quarterDivide == 0) {
      return CellType.apple;
    } else if (position.isEven) {
      return CellType.dot;
    } // dots every seconds

    return CellType.space;
    // Odd positions are an empty cells. (Every 0.5 seconds 1 empty cell)
  }

  /// Droid previous cell was bitten and set default type
  void _bittenCell(Cell cell) {
    cell.mood = cell.type;
    cell.isBitten = true;
    rebuildStates(['${cell.position}']);
  }

  /// Droid's current cell and rebuild [ghost]
  void _droidCell(Cell cell) {
    cell.mood = CellType.droid;
    rebuildStates(['${cell.position}', CellsTag.ghostWidget]);
  }

  /// We need reset cells every minutes and start [clock] animation
  /// Split animations for performance 15 cells = 120 cells / 8
  Future<void> _resetCells(int droidPosition) async {
    if (droidPosition == positionReset) {
      int i = 0;
      int k = 0;
      for (final Cell item in _items) {
        item.isBitten = false;
        i++;
        if (i == splitCells) {
          for (int j = splitCells * k; j < splitCells * (k + 1); j++) {
            if (j.isEven) {
              rebuildStates(['$j']);
            }
          }
          await Future<void>.delayed(const Duration(milliseconds: 500));
          i = 0;
          k++;
        }
      }
    }
  }
}
