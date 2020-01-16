// Copyright 2020 The Chromium Authors. All rights reserved.
// Use of this source code is governed by a BSD-style license that can be
// found in the LICENSE file.

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import './config/size_config.dart';

import './provider/theme.dart';

import './widget/board.dart';
import './widget/clock.dart';
import './widget/date.dart';
import './widget/responsive_safe_area.dart';
import './widget/weather.dart';

class BakiClock extends StatefulWidget {
  @override
  _BakiClockState createState() => _BakiClockState();
}

class _BakiClockState extends State<BakiClock> {
  ThemeProvider _theme;

  @override
  void initState() {
    super.initState();
    _theme = Provider.of<ThemeProvider>(context, listen: false);
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();

    // Theme change listen here
    Future<void>.microtask(() => _theme.setThemeLight =
        Theme.of(context).brightness == Brightness.light
            ? ThemeProvider.light
            : ThemeProvider.dark);
  }

  @override
  Widget build(BuildContext context) {
    return ResponsiveSafeArea(builder: (BuildContext context, Size safeSize) {
      /// Calculate safeArea without status bar and home bar indicator.
      /// All size depend on screen size (Lenova smart clock size is 800:480).
      SizeConfig().init(context, safeSize);

      return Container(
        height: SizeConfig.screenHeight,
        width: SizeConfig.screenWidth,
        color: _theme.data[ELEMENT.background],
        child: Stack(children: <Widget>[
          ///Board provide cells (Droid, Apple, Dots, Space).
          Board(),
          Container(
            margin: EdgeInsets.symmetric(
              vertical: SizeConfig.verticalMargin,
              horizontal: SizeConfig.horizontalMargin,
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Weather(),
                Clock(),
                Date(),
              ],
            ),
          ),
        ]),
      );
    });
  }
}
