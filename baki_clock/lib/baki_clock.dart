// Copyright 2019 The Chromium Authors. All rights reserved.
// Use of this source code is governed by a BSD-style license that can be
// found in the LICENSE file.

import 'dart:async';
import 'dart:io';

import 'package:flutter_clock_helper/model.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

import './widget/responsive_safe_area.dart';
import './widget/board.dart';
import './widget/weather.dart';
import './widget/clock.dart';
import './widget/date.dart';

import './config/size_config.dart';
import './config/const.dart';

import './provider/theme.dart';

class BakiClock extends StatefulWidget {
  const BakiClock(this.model);

  final ClockModel model;

  @override
  _BakiClockState createState() => _BakiClockState();
}

class _BakiClockState extends State<BakiClock> with WidgetsBindingObserver {
  var _now = DateTime.now();
  var _weather = '';
  var _temperature = '';
  var _droidPosition = 0;
  ThemeProvider _themeProvider;
  Timer _timer;

  @override
  void initState() {
    super.initState();

    //SystemChrome.setEnabledSystemUIOverlays([]); //hide status bar
    WidgetsBinding.instance.addObserver(this);
    widget.model.addListener(_updateModel);

    _themeProvider = Provider.of<ThemeProvider>(context, listen: false);
    _setFirstDroidPosition();
    _updateTime();
    _updateModel();
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    if (Theme.of(context).brightness == Brightness.light) {
      Future.microtask(() => _themeProvider.setThemeLight = LIGHT_THEME);
    } else {
      Future.microtask(() => _themeProvider.setThemeLight = DARK_THEME);
    }
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    if (state == AppLifecycleState.resumed) {
      _themeProvider.setStateInActive = false;
    }
    if (state == AppLifecycleState.inactive) {
      _themeProvider.setStateInActive = true;
    } // Need to know if app inactive and paused, dot's animation won't work
  }

  @override
  void didUpdateWidget(BakiClock oldWidget) {
    super.didUpdateWidget(oldWidget);

    if (widget.model != oldWidget.model) {
      oldWidget.model.removeListener(_updateModel);
      widget.model.addListener(_updateModel);
    }
  }

  @override
  void dispose() {
    super.dispose();

    WidgetsBinding.instance.removeObserver(this);
    _timer?.cancel();
    widget.model.removeListener(_updateModel);
    widget.model.dispose();
  }

  /*
   * Let we know first Droid Position
   * Only app first time sleep until round integer second : 1.003 + sleep(0.997s) ~ 2, 1.450 + sleep(0.150s) ~ 2
   * Then _updateTime beginning of new second and fractionalSecond will be < 500milliseconds.
   */
  void _setFirstDroidPosition() {
    _now = DateTime.now();
    int second = int.parse(DateFormat('s').format(_now));
    int fractionalSecond = int.parse(DateFormat('S').format(_now));
    fractionalSecond = MILLI_SECOND - fractionalSecond;

    sleep(Duration(milliseconds: fractionalSecond));
    _droidPosition = second * 2 + 1;
  }

  /*
   * Update droid position per 0.5 second. Make sure to do it at the beginning of each
   * new second, so that the clock is accurate.
   * Testing on emulator for 3 days and proved no mistake.
   */
  void _updateTime() {
    _now = DateTime.now();
    int second = int.parse(DateFormat('s').format(_now));
    int fractionalSecond = int.parse(DateFormat('S').format(_now));
    var sleepTime = 0;

    if (_droidPosition.isOdd) {
      sleepTime = fractionalSecond > MOVE_SPEED //Just in case
          ? fractionalSecond - MOVE_SPEED
          : MOVE_SPEED - fractionalSecond;
      setState(() {
        _droidPosition = second * 2;
      });
    } else {
      sleepTime = MILLI_SECOND - fractionalSecond;
      setState(() {
        _droidPosition = second * 2 + 1;
      });
    }

    _timer = Timer(Duration(milliseconds: sleepTime), _updateTime);
  }

  void _updateModel() {
    setState(() {
      _weather = widget.model.weatherString;
      _temperature = widget.model.temperatureString.split('.').toList()[0];
    });
  }

  @override
  Widget build(BuildContext context) {
    return ResponsiveSafeArea(builder: (context, size) {
      SizeConfig().init(context, size);

      return Container(
        height: SizeConfig.screenHeight,
        width: SizeConfig.screenWidth,
        color: _themeProvider.data[ELEMENT.background],
        child: Stack(children: <Widget>[
          Board(droidPosition: _droidPosition),
          Container(
            margin: EdgeInsets.symmetric(
              vertical: SizeConfig.verticalMargin,
              horizontal: SizeConfig.horizontalMargin,
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Weather(
                  weather: _weather,
                  temperature: _temperature,
                ),
                Clock(
                  is24HourFormat: widget.model.is24HourFormat,
                  droidPosition: _droidPosition,
                ),
                Date(),
              ],
            ),
          ),
        ]),
      );
    });
  }
}
