// Copyright 2019 The Chromium Authors. All rights reserved.
// Use of this source code is governed by a BSD-style license that can be
// found in the LICENSE file.

import 'dart:io';

import 'package:flutter_clock_helper/customizer.dart';
import 'package:flutter_clock_helper/model.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:states_rebuilder/states_rebuilder.dart';

import './model/cells.dart';
import './provider/theme.dart';

import 'baki_clock.dart';

void main() {
  if (!kIsWeb && Platform.isMacOS) {
    debugDefaultTargetPlatformOverride = TargetPlatform.fuchsia;
  }

  runApp(ClockCustomizer(
    (ClockModel model) => MyApp(model),
  ));
}

class MyApp extends StatelessWidget {
  const MyApp(this.model);

  final ClockModel model;

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: <ChangeNotifierProvider<dynamic>>[
        ChangeNotifierProvider<ThemeProvider>(
          create: (_) => ThemeProvider(theme: 'light'),
        ),
        ChangeNotifierProvider<ClockModel>.value(
          value: model,
        ),
      ],
      child: Injector(
        inject: <Inject<Cells>>[Inject<Cells>(() => Cells())],
        builder: (_) {
          return BakiClock();
        },
      ),
    );
  }
}
