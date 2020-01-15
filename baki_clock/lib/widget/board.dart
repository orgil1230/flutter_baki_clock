import 'dart:async';

import 'package:flutter/material.dart';
import 'package:states_rebuilder/states_rebuilder.dart';

import '../config/size_config.dart';
import '../config/const.dart';
import './cell_item.dart';

import '../model/cells.dart';
import '../model/droid.dart';

class Board extends StatefulWidget {
  @override
  _BoardState createState() => _BoardState();
}

class _BoardState extends State<Board> {
  DroidModel _droidModel;
  bool init = false;

  @override
  void initState() {
    super.initState();
    _droidModel = Injector.get();
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    Future.microtask(() => _droidModel.moveDroid());
  }

  @override
  void dispose() {
    //_timer?.cancel();TODO
    super.dispose();
  }

  List<Positioned> _buildCells() {
    final pathGrid = <Positioned>[];
    Cells cells = Cells(5);
    int i = 0;
    cells.items.forEach((cell) {
      pathGrid.add(
        Positioned(
          child: Container(
            height: SizeConfig.cellHeight,
            width: SizeConfig.cellWidth,
            alignment: Alignment.center,
            child: StateBuilder<DroidModel>(
              models: [_droidModel],
              tag: i,
              builder: (context, model) => CellItem(
                cell: cell,
                position: _droidModel.position,
              ),
            ),
          ),
          bottom: cell.point.y * SizeConfig.cellHeight,
          left: cell.point.x * SizeConfig.cellWidth,
        ),
      );
      i++;
    });

    return pathGrid;
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(
        vertical: SizeConfig.verticalMargin,
        horizontal: SizeConfig.horizontalMargin,
      ),
      child: StateWithMixinBuilder(
        mixinWith: MixinWith.automaticKeepAliveClientMixin,
        builder: (_, __) => Stack(
          children: _buildCells(),
        ),
      ),
    );
  }
}
