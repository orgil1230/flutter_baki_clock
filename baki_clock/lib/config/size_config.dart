import 'package:flutter/widgets.dart';

class SizeConfig {
  /* 39x2 + 21x2 = 120 cells */
  static const int GRID_HORIZONTAL = 39; // horizontal cells
  static const int GRID_VERTICAL = 23; // vertical cells added top and bottom 21 + 1 + 1

  static MediaQueryData _mediaQueryData;

  static double screenWidth;
  static double screenHeight;
  static double cellWidth;
  static double cellHeight;

  static double onePixel;
  static double verticalMargin;
  static double horizontalMargin;

  static double primaryFontHeight;
  static double primaryFontWidth;
  static double secondaryFontSize;
  static double clockMargin;

  static double droidSize;
  static double appleSize;
  static double dotSize;

  static double weatherHeight;

  static double dateHeight;
  static double dateMarginTop;

  static double scoreHeight;
  static double scoreMarginTop;
  static double scoreMarginLeft;

  void init(BuildContext context, Size size) {
    _mediaQueryData = MediaQuery.of(context);

    if (_mediaQueryData.orientation == Orientation.landscape) {
      /*var safeArea = 5.0;
      if (_isIPhoneX(_mediaQueryData)) {
        safeArea = 25.0;
      }*/
      screenHeight = size.height; // 480 pixel 5:3 ratio
      screenWidth = screenHeight / 3 * 5; // 800 pixel 5:3 ratio
    } else {
      screenWidth = size.width; // 800 pixel
      screenHeight = screenWidth / 5 * 3; // 480 pixel 5:3 ratio
    }

    onePixel = screenWidth / 800; // 1px
    verticalMargin = screenWidth / 400; // 2px
    horizontalMargin = screenWidth / 200; // 4px

    cellWidth = (screenWidth - horizontalMargin * 2) / GRID_HORIZONTAL;
    // 800px-8x:39 cells horizontal ~ 20.3px
    cellHeight = (screenHeight - verticalMargin * 2) / GRID_VERTICAL;
    // 480px-4px:23 cells vertical ~ 20.69px

    primaryFontHeight = screenWidth / 3.8; // ~228px
    primaryFontWidth = screenWidth / 5.5; // ~145px
    secondaryFontSize = screenWidth / 25; // 32px
    clockMargin = cellHeight + verticalMargin; // ~24.69px

    droidSize = screenWidth / 22.2; // 36px
    appleSize = screenWidth / 40; // 20px
    dotSize = screenWidth / 100; // 8px

    weatherHeight = screenWidth / 20; // 40px

    dateHeight = screenWidth / 25; // 18px
    dateMarginTop = screenWidth / 29.6; // 27px

    scoreHeight = screenWidth / 30; // 22.8px
    scoreMarginTop = screenWidth / 70; // 50px
    scoreMarginLeft = screenWidth / 30; // 20px
  }
}

/*bool _isIPhoneX(MediaQueryData mediaQuery) {
  if (Platform.isIOS) {
    var size = mediaQuery.size;
    if (size.height >= 812.0 || size.width >= 812.0) {
      //IPhone X, XS MAX, 11 bottom navigation height
      return true;
    }
  }
  return false;
}*/
