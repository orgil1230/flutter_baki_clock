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

  String theme;

  get data => theme == 'light' ? lightTheme : darkTheme;

  set setThemeLight(String val) {
    if (theme != val) {
      theme = val;
      notifyListeners();
    }
  }

  final lightTheme = {
    ELEMENT.background: Colors.white,
    ELEMENT.clock: Color(0xFF2334B6),
    ELEMENT.temperature: Color(0xFF63629C),
    ELEMENT.date: Color(0xFF63629C),
    ELEMENT.score: Color(0xFF4549D0),
    ELEMENT.dot: Color(0xFFE4E7E9), //Color(0xff505786),
  };

  final darkTheme = {
    ELEMENT.background: Color(0xFF222543),
    ELEMENT.clock: Colors.white,
    ELEMENT.temperature: Color(0xFFb3bdff),
    ELEMENT.date: Color(0xFFb3bdff),
    ELEMENT.score: Color(0xFFb4bdff),
    ELEMENT.dot: Color(0xff272C4A),
  };
}
