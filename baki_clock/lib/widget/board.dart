import 'package:flutter/material.dart';

import '../config/size_config.dart';
import './cell_item.dart';

import '../model/cells.dart';

class Board extends StatelessWidget {
  const Board({@required this.droidPosition});

  final droidPosition;

  List<Positioned> _buildCells() {
    final pathGrid = List<Positioned>();

    Cells cells = Cells(droidPosition);
    cells.items.forEach((cell) {
      pathGrid.add(
        Positioned(
          child: Container(
            height: SizeConfig.cellHeight,
            width: SizeConfig.cellWidth,
            alignment: Alignment.center,
            child: CellItem(cell: cell),
          ),
          bottom: cell.point.y * SizeConfig.cellHeight,
          left: cell.point.x * SizeConfig.cellWidth,
        ),
      );
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
      child: Stack(children: _buildCells()),
    );
  }
}
