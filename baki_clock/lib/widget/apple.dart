import 'package:flutter/material.dart';

import '../config/const.dart';
import '../config/size_config.dart';

const String APPLE_IDLE = 'assets/elements/apple.png';
const String APPLE_BITTEN = 'assets/elements/apple_bitten.png';

class Apple extends StatefulWidget {
  const Apple({
    Key key,
    @required this.isBitten,
    @required this.color,
  }) : super(key: key);

  final bool isBitten;
  final Color color;

  @override
  _AppleState createState() => _AppleState();
}

class _AppleState extends State<Apple> {
  bool fade = true;

  @override
  Widget build(BuildContext context) {
    setState(() {
      fade = widget.isBitten;
    });
    return AnimatedCrossFade(
      duration: const Duration(seconds: Const.ANIMATION_DURATION),
      firstChild: apple(APPLE_BITTEN),
      secondChild: apple(APPLE_IDLE),
      crossFadeState:
          fade ? CrossFadeState.showFirst : CrossFadeState.showSecond,
    );
  }

  Container apple(String appleType) {
    return Container(
      height: SizeConfig.appleSize,
      child: Image.asset(
        appleType,
        fit: BoxFit.fitHeight,
        color: widget.color,
      ),
    );
  }
}
