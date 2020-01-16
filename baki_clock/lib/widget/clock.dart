import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_clock_helper/model.dart';
import 'package:provider/provider.dart';
import 'package:intl/intl.dart';

import '../config/const.dart';
import '../config/utils.dart';
import '../widget/colon.dart';
import '../widget/time.dart';

final List<Color> timeColors = Utils.generateDotColors();

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
    final ClockModel model = Provider.of<ClockModel>(context, listen: false);
    final String hour =
        DateFormat(model.is24HourFormat ? 'HH' : 'hh').format(_now);
    final String minute = DateFormat('mm').format(_now);
    final String time = hour + minute;
    final int second = int.parse(DateFormat('s').format(_now));

    final List<Widget> list = <Widget>[];
    final int startPos = int.parse(time.substring(2, 4)) % 4;
    //Color transfer right to left every minutes
    for (int i = 0; i < time.length; i++) {
      final int beginColor = (i + startPos) % 4;
      final int endColor = (beginColor + 1) % 4;

      if (i == 2) {
        list.add(Colon(second: second, colorPosition: startPos));
      }

      list.add(
        Time(
          time: time[i],
          beginColor: Const.GOOGLE_COLORS[beginColor],
          endColor: Const.GOOGLE_COLORS[endColor],
          animate: second == 59,
        ),
      );
    }

    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: list,
    );
  }
}
