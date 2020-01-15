import 'dart:async';

import 'package:flutter/material.dart';
import 'package:states_rebuilder/states_rebuilder.dart';

import '../config/size_config.dart';
import './cell_item.dart';

import '../model/cells.dart';
import '../model/droid.dart';

class Board extends StatefulWidget {
  @override
  _BoardState createState() => _BoardState();
}

class _BoardState extends State<Board> {
  Cells _cells;
  bool init = false;

  @override
  void initState() {
    super.initState();
    _cells = Injector.get();
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    Future.microtask(() => _cells.moveDroid());
  }

  @override
  void dispose() {
    //_timer?.cancel();TODO
    super.dispose();
  }

  List<Positioned> _buildCells() {
    final pathGrid = <Positioned>[];

    for (var cell in _cells.items) {
      pathGrid.add(
        Positioned(
          child: Container(
            height: SizeConfig.cellHeight,
            width: SizeConfig.cellWidth,
            alignment: Alignment.center,
            child: StateBuilder<Cells>(
              models: [_cells],
              tag: cell.position,
              builder: (context, model) => CellItem(
                cell: cell,
              ),
            ),
          ),
          bottom: cell.point.y * SizeConfig.cellHeight,
          left: cell.point.x * SizeConfig.cellWidth,
        ),
      );
    }

    return pathGrid;
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
  //StateWithMixinBuilder(
  //        mixinWith: MixinWith.automaticKeepAliveClientMixin,
  //        builder: (_, __) =>
}
