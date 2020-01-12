import 'package:baki_clock/config/const.dart';
import 'package:flutter/material.dart';
import '../config/size_config.dart';

class Dot extends StatefulWidget {
  final Color beginColor;
  final Color endColor;
  final bool animate;
  final bool themeChanged;

  const Dot({
    Key key,
    @required this.beginColor,
    @required this.endColor,
    @required this.animate,
    @required this.themeChanged,
  }) : super(key: key);

  @override
  _DotState createState() => _DotState();
}

class _DotState extends State<Dot> with SingleTickerProviderStateMixin {
  AnimationController _controller;
  Animation<Color> animation;
  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: const Duration(seconds: ANIMATION_DURATION),
      vsync: this,
    );

    animation = ColorTween(
      begin: widget.beginColor,
      end: widget.endColor,
    ).animate(_controller)
      ..addStatusListener(handler);
  }

  void handler(status) {
    if (status == AnimationStatus.completed) {
      _controller.reset();
      animation = ColorTween(
        begin: widget.beginColor,
        end: widget.endColor,
      ).animate(_controller);
    }
  }

  @override
  dispose() {
    _controller?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    if (widget.themeChanged) {
      animation = ColorTween(
        begin: widget.beginColor,
        end: widget.endColor,
      ).animate(_controller)
        ..addStatusListener(
          handler,
        ); //little trick for change theme dot color problem
    }

    if (widget.animate) {
      _controller.forward();
    }

    return Container(
      height: SizeConfig.dotSize,
      width: SizeConfig.dotSize,
      decoration: BoxDecoration(
        color: animation.value,
        shape: BoxShape.circle,
      ),
    );
  }
}
