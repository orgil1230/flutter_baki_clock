import 'package:flutter/material.dart';

import '../config/const.dart';
import '../config/size_config.dart';

const String appleIdle = 'apple.png';
const String appleBitten = 'apple_bitten.png';

class Apple extends StatefulWidget {
  const Apple({
    Key key,
    @required this.color,
    @required this.isBitten,
  }) : super(key: key);

  final Color color;
  final bool isBitten;

  @override
  _AppleState createState() => _AppleState();
}

class _AppleState extends State<Apple> {
  bool _isBitten = true;

  @override
  Widget build(BuildContext context) {
    setState(() {
      _isBitten = widget.isBitten;
    });
    return AnimatedCrossFade(
      duration: const Duration(seconds: Const.animationDuration),
      firstChild: apple(appleBitten),
      secondChild: apple(appleIdle),
      crossFadeState:
          _isBitten ? CrossFadeState.showFirst : CrossFadeState.showSecond,
    );
  }

  Container apple(String appleType) {
    return Container(
      height: SizeConfig.appleSize,
      child: Image.asset(
        'assets/elements/$appleType',
        fit: BoxFit.fitHeight,
        color: widget.color,
      ),
    );
  }
}
