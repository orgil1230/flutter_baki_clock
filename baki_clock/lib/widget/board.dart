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

class Board extends StatefulWidget {
  @override
  _BoardState createState() => _BoardState();
}

class _BoardState extends State<Board> {
  Cells _cells;

  /// Set the initial values, droid first position, widgets position, ...
  @override
  void initState() {
    super.initState();
    _cells = Injector.get();
  }

  /// Start move Droid every 0.5 seconds split rebuild current and previous cells.
  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    Future<void>.microtask(() => _cells.moveDroid());
  }

  @override
  void dispose() {
    _cells.cancelTimer();
    super.dispose();
  }

  /// We can listen Widget's LifeCycleState by [StateWithMixinBuilder].
  @override
  Widget build(BuildContext context) {
    final Cells cells = Injector.get<Cells>();
    return Container(
      padding: EdgeInsets.symmetric(
        vertical: SizeConfig.verticalMargin,
        horizontal: SizeConfig.horizontalMargin,
      ),
      child: StateWithMixinBuilder<WidgetsBindingObserver>(
        mixinWith: MixinWith.widgetsBindingObserver,
        initState: (_, WidgetsBindingObserver observer) {
          WidgetsBinding.instance.addObserver(observer);
        },
        dispose: (_, WidgetsBindingObserver observer) =>
            WidgetsBinding.instance.removeObserver(observer),
        didChangeAppLifecycleState:
            (BuildContext context, AppLifecycleState state) {
          cells.lifecycleState(state);
        },
        builder: (_, __) => Stack(
          children: _buildCells(),
        ),
      ),
    );
  }

  /// [_buildCells] that prepare droid path(60 spaces, 56 dots, 4 apples).
  /// There are 120 cells = 60 seconds * 2.
  /// [StateBuilder] that helps for split rebuild widgets by tag(position).
  List<Positioned> _buildCells() {
    final List<Positioned> pathGrid = <Positioned>[];
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
