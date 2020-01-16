// Copyright 2020 The Chromium Authors. All rights reserved.
// Use of this source code is governed by a BSD-style license that can be
// found in the LICENSE file.

import 'dart:async';

import 'package:flutter/material.dart';
import 'package:states_rebuilder/states_rebuilder.dart';

import '../config/size_config.dart';
import '../model/cell.dart';
import '../model/cells.dart';
import './cell_item.dart';

/// [_buildCells] that prepare droid path(60 spaces, 56 dots, 4 apples).
/// There are 120 cells = 60 seconds * 2.
class Board extends StatefulWidget {
  @override
  _BoardState createState() => _BoardState();
}

class _BoardState extends State<Board> {
  Cells _cells;

  @override
  void initState() {
    super.initState();

    /// Set the initial values, droid first position, widgets position, ...
    _cells = Injector.get();
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();

    /// Start move Droid every 0.5 seconds split rebuild current and previous cells.
    Future<void>.microtask(() => _cells.moveDroid());
  }

  @override
  void dispose() {
    _cells.cancelTimer();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(
        vertical: SizeConfig.verticalMargin,
        horizontal: SizeConfig.horizontalMargin,
      ),
      child: Stack(
        children: _buildCells(),
      ),
    );
  }

  List<Positioned> _buildCells() {
    final List<Positioned> pathGrid = <Positioned>[];

    /// [StateBuilder] that helps for split rebuild widgets by tag(position).
    for (final Cell cell in _cells.items) {
      pathGrid.add(
        Positioned(
          child: Container(
            height: SizeConfig.cellHeight,
            width: SizeConfig.cellWidth,
            alignment: Alignment.center,
            child: StateBuilder<Cells>(
              models: <Cells>[_cells],
              tag: cell.position,
              builder: (BuildContext context, ReactiveModel<Cells> model) =>
                  CellItem(cell: cell),
            ),
          ),
          bottom: cell.point.y * SizeConfig.cellHeight,
          left: cell.point.x * SizeConfig.cellWidth,
        ),
      );
    }
    return pathGrid;
  }
}
