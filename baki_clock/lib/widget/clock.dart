import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../config/const.dart';
import '../config/utils.dart';
import '../widget/colon.dart';
import '../widget/time.dart';

final List<Color> timeColors = Utils.generateDotColors();

class Clock extends StatelessWidget {
  const Clock({
    Key key,
    @required this.is24HourFormat,
    @required this.droidPosition,
  }) : super(key: key);

  final bool is24HourFormat;
  final int droidPosition;

  @override
  Widget build(BuildContext context) {
    return timeWidgets();
  }

  Widget timeWidgets() {
    final DateTime now = DateTime.now();
    final String hour = DateFormat(is24HourFormat ? 'HH' : 'hh').format(now);
    final String minute = DateFormat('mm').format(now);
    final String time = (hour + minute);

    List<Widget> list = new List<Widget>();

    var startRandom = int.parse(time.substring(2, 4)) % 4;
    for (var i = 0; i < time.length; i++) {
      var beginColor = (i + startRandom) % 4;
      var endColor = (beginColor + 1) % 4;

      if (i == 2) {
        list.add(
          Colon(
            droidPosition: droidPosition,
            colorPosition: startRandom,
          ),
        );
      }
      list.add(
        Time(
          time: time[i],
          beginColor: GOOGLE_COLORS[beginColor],
          endColor: GOOGLE_COLORS[endColor],
          animate: droidPosition == POSITION_RESET,
        ),
      );
    }
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: list,
    );
  }
}
