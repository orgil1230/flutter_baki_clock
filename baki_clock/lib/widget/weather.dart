import 'package:flutter/material.dart';
import 'package:flutter_clock_helper/model.dart';
import 'package:provider/provider.dart';

import '../config/const.dart';
import '../config/size_config.dart';
import '../provider/theme.dart';

/// Basic weather
class Weather extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final ThemeProvider theme =
        Provider.of<ThemeProvider>(context, listen: true);
    final ClockModel model = Provider.of<ClockModel>(context, listen: true);

    return Container(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.end,
        children: <Widget>[
          Container(
            margin: EdgeInsets.only(bottom: SizeConfig.onePixel),
            height: SizeConfig.weatherHeight,
            child: Image.asset(
              'assets/weather/${theme.theme}/${model.weatherString}.png',
              fit: BoxFit.fitHeight,
            ),
          ),
          Container(
            child: FittedBox(
              fit: BoxFit.fitHeight,
              child: SizedBox(
                child: Text(
                  '${model.temperatureString.split('.').toList()[0]}°',
                  style: TextStyle(
                    fontFamily: Const.secondaryFont,
                    color: theme.data[ELEMENT.temperature],
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
