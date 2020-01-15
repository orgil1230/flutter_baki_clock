import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../model/cell.dart';
import '../provider/theme.dart';

import './dot.dart';
import './apple.dart';
import './droid.dart';

class CellItem extends StatefulWidget {
  const CellItem({
    Key key,
    @required this.cell,
  }) : super(key: key);

  final Cell cell;

  @override
  _CellItemState createState() => _CellItemState();
}

class _CellItemState extends State<CellItem> {
  String _theme = 'light';
  bool _stateInActive = false;
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    switch (widget.cell.mood) {
      case CellType.droid:
        return Droid(position: widget.cell.position, color: widget.cell.color);

      case CellType.apple:
        return Apple(isBitten: widget.cell.isBitten, color: widget.cell.color);

      case CellType.dot:
        final themeProvider =
            Provider.of<ThemeProvider>(context, listen: false);
        var themeChanged = false;
        if (_theme != themeProvider.theme) {
          _theme = themeProvider.theme;
          themeChanged = true;
        }

        if (_stateInActive != themeProvider.stateInActive) {
          _stateInActive = themeProvider.stateInActive;
          themeChanged = true;
        }

        return Dot(
            beginColor: widget.cell.isBitten
                ? themeProvider.data[ELEMENT.dot]
                : widget.cell.color,
            endColor: widget.cell.color,
            animate: widget.cell.animate,
            themeChanged: themeChanged);

      case CellType.space:
        return Container(); //Container(color: Colors.transparent);

      default:
        return Container();
    }
  }
}
