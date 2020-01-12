import 'package:baki_clock/config/size_config.dart';
import 'package:flutter/material.dart';

import '../config/const.dart';

class Time extends StatefulWidget {
  const Time({
    Key key,
    @required this.time,
    @required this.beginColor,
    @required this.endColor,
    @required this.animate,
  }) : super(key: key);

  final String time;
  final Color beginColor;
  final Color endColor;
  final bool animate;

  @override
  _TimeState createState() => _TimeState();
}

class _TimeState extends State<Time> with SingleTickerProviderStateMixin {
  AnimationController _controller;
  Animation<Color> _animation;
  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: const Duration(seconds: ANIMATION_DURATION),
      vsync: this,
    );
    void handler(status) {
      if (status == AnimationStatus.completed) {
        _controller.reset();
        _animation = ColorTween(
          begin: widget.beginColor,
          end: widget.endColor,
        ).animate(_controller);
      }
    }

    _animation = ColorTween(
      begin: widget.beginColor,
      end: widget.endColor,
    ).animate(_controller)
      ..addStatusListener(handler);
  }

  @override
  dispose() {
    _controller?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    if (widget.animate) {
      _controller.forward();
    }
    return Center(
      child: Container(
        height: SizeConfig.primaryFontHeight,
        width: SizeConfig.primaryFontWidth,
        child: FittedBox(
          fit: BoxFit.fitHeight,
          child: Text(
            widget.time,
            style: TextStyle(
              fontFamily: PRIMARY_FONT,
              height: 1.0,
              color: _animation.value,
            ),
          ),
        ),
      ),
    );
  }
}
