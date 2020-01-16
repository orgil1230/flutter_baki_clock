import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../config/const.dart';
import '../config/size_config.dart';

import '../provider/theme.dart';

/// Dot cell element has 2 type of color
class Dot extends StatefulWidget {
  const Dot({
    Key key,
    @required this.color,
    @required this.isBitten,
  }) : super(key: key);

  final Color color;
  final bool isBitten;

  @override
  _DotState createState() => _DotState();
}

class _DotState extends State<Dot> {
  bool _isBitten = true;

  @override
  Widget build(BuildContext context) {
    final ThemeProvider theme =
        Provider.of<ThemeProvider>(context, listen: true);

    setState(() {
      _isBitten = widget.isBitten;
    });
    return AnimatedCrossFade(
      duration: const Duration(seconds: Const.animationDuration),
      firstChild: dot(theme.data[ELEMENT.dot]),
      secondChild: dot(widget.color),
      crossFadeState:
          _isBitten ? CrossFadeState.showFirst : CrossFadeState.showSecond,
    );
  }

  Container dot(Color color) {
    return Container(
      height: SizeConfig.dotSize,
      width: SizeConfig.dotSize,
      decoration: BoxDecoration(
        color: color,
        shape: BoxShape.circle,
      ),
    );
  }
}
