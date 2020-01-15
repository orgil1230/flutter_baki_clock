// Copyright 2019 The Chromium Authors. All rights reserved.
// Use of this source code is governed by a BSD-style license that can be
// found in the LICENSE file.

import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
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

    Future.microtask(() => _theme.setThemeLight =
        Theme.of(context).brightness == Brightness.light
            ? LIGHT_THEME
            : DARK_THEME);
  }

  @override
  Widget build(BuildContext context) {
    return ResponsiveSafeArea(builder: (context, safeSize) {
      SizeConfig().init(context, safeSize);

      return Container(
        height: SizeConfig.screenHeight,
        width: SizeConfig.screenWidth,
        color: _theme.data[ELEMENT.background],
        child: Stack(children: <Widget>[
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
