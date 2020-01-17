import 'package:baki_clock/config/const.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:intl/intl.dart';

import '../config/size_config.dart';
import '../provider/theme.dart';

/// Basic Date
class Date extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final String date =
        DateFormat('EE dd MMM').format(DateTime.now()).toUpperCase();
    final ThemeProvider theme =
        Provider.of<ThemeProvider>(context, listen: true);

    final TextStyle textStyle = TextStyle(
      color: theme.data[ELEMENT.date],
      fontFamily: Const.secondaryFont,
      fontSize: SizeConfig.secondaryFontSize,
    );

    return FittedBox(
      fit: BoxFit.fitHeight,
      child: SizedBox(
        child: Text(
          '$date',
          style: textStyle,
        ),
      ),
    );
  }
}
