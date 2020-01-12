import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../config/size_config.dart';
import '../config/const.dart';
import '../provider/theme.dart';

class Weather extends StatelessWidget {
  const Weather({
    Key key,
    @required this.weather,
    @required this.temperature,
  }) : super(key: key);

  final weather;
  final temperature;

  @override
  Widget build(BuildContext context) {
    final ThemeProvider themeProvider =
        Provider.of<ThemeProvider>(context, listen: false);

    return Container(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.end,
        children: <Widget>[
          Container(
            margin: EdgeInsets.only(bottom: SizeConfig.onePixel),
            height: SizeConfig.weatherHeight,
            child: Image.asset(
              'assets/weather/${themeProvider.theme}/$weather.png',
              fit: BoxFit.fitHeight,
            ),
          ),
          Container(
            child: FittedBox(
              fit: BoxFit.fitHeight,
              child: SizedBox(
                child: Text(
                  '$temperature°',
                  style: TextStyle(
                    fontFamily: SECONDARY_FONT,
                    color: themeProvider.data[ELEMENT.temperature],
                    fontSize: SizeConfig.secondaryFontSize,
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
