import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../config/const.dart';
import '../config/size_config.dart';

import '../provider/theme.dart';

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
  bool fade = true;

  @override
  Widget build(BuildContext context) {
    final ThemeProvider theme =
        Provider.of<ThemeProvider>(context, listen: true);

    setState(() {
      fade = widget.isBitten;
    });
    return AnimatedCrossFade(
      duration: const Duration(seconds: Const.ANIMATION_DURATION),
      firstChild: dot(theme.data[ELEMENT.dot]),
      secondChild: dot(widget.color),
      crossFadeState:
          fade ? CrossFadeState.showFirst : CrossFadeState.showSecond,
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
