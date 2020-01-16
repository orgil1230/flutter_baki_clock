import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_clock_helper/model.dart';
import 'package:provider/provider.dart';
import 'package:intl/intl.dart';

import '../widget/colon.dart';
import '../widget/time.dart';

const List<Color> googleColors = <Color>[
  Color(0xFF4081ed),
  Color(0xFFe44134),
  Color(0xFFf4b705),
  Color(0xFF33a351),
];

/// A basic clock.
class Clock extends StatefulWidget {
  @override
  _ClockState createState() => _ClockState();
}

class _ClockState extends State<Clock> {
  DateTime _now = DateTime.now();
  Timer _timer;

  @override
  void initState() {
    super.initState();
    _updateTime();
  }

  @override
  void dispose() {
    _timer?.cancel();
    super.dispose();
  }

  /// Every seconds animate ghosts
  void _updateTime() {
    setState(() {
      _now = DateTime.now();
      _timer = Timer(
        const Duration(seconds: 1) - Duration(milliseconds: _now.millisecond),
        _updateTime,
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: timeWidgets(),
    );
  }

  /// Calculate time and colon's colors, animations
  List<Widget> timeWidgets() {
    final ClockModel model = Provider.of<ClockModel>(context, listen: false);
    final String hour =
        DateFormat(model.is24HourFormat ? 'HH' : 'hh').format(_now);
    final String minute = DateFormat('mm').format(_now);
    final String time = hour + minute;
    final int second = int.parse(DateFormat('s').format(_now));
    final List<Widget> listWidgets = <Widget>[];
    final int startPos = int.parse(time.substring(2, 4)) % 4;

    for (int i = 0; i < time.length; i++) {
      final int beginColor = (i + startPos) % 4;
      final int endColor = (beginColor + 1) % 4;

      if (i == 2) {
        listWidgets.add(Colon(second: second, colorPosition: startPos));
      }

      listWidgets.add(
        Time(
          time: time[i],
          beginColor: googleColors[beginColor],
          endColor: googleColors[endColor],
          animate: second == 59, // Start animation
        ),
      );
    }
    return listWidgets;
  }
}
