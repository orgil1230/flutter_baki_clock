import 'package:flutter/material.dart';

enum ELEMENT {
  background,
  clock,
  temperature,
  date,
  score,
  dot,
}

class ThemeProvider with ChangeNotifier {
  ThemeProvider({this.theme});

  Map<ELEMENT, Color> get data => theme == light ? lightTheme : darkTheme;
  String theme;
  set setThemeLight(String val) {
    if (theme != val) {
      theme = val;
      notifyListeners();
    }
  }

  static const String light = 'light';
  static const String dark = 'dark';

  final Map<ELEMENT, Color> lightTheme = <ELEMENT, Color>{
    ELEMENT.background: Colors.white,
    ELEMENT.clock: const Color(0xFF2334B6),
    ELEMENT.temperature: const Color(0xFF63629C),
    ELEMENT.date: const Color(0xFF63629C),
    ELEMENT.score: const Color(0xFF4549D0),
    ELEMENT.dot: const Color(0xFFE4E7E9),
  };

  final Map<ELEMENT, Color> darkTheme = <ELEMENT, Color>{
    ELEMENT.background: const Color(0xFF222543),
    ELEMENT.clock: Colors.white,
    ELEMENT.temperature: const Color(0xFFb3bdff),
    ELEMENT.date: const Color(0xFFb3bdff),
    ELEMENT.score: const Color(0xFFb4bdff),
    ELEMENT.dot: const Color(0xff272C4A),
  };
}
