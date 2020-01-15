import 'package:flutter/material.dart';

const ANIMATION_DURATION = 3;
const MOVE_SPEED = 500; //Droid move every 500 milliseconds 1 cell
const MILLI_SECOND = 1000;
const QUARTER_DIVIDE_CELLS = 30;
const QUARTER_SECONDS = 15;
const X_AXIS_MAX = 38; // 39x23 Grid 120 cells
const Y_AXIS_MAX = 22; // 39x23 Grid 120 cells
const POSITION_RESET = 119; // 59.5 second position reset all
const POSITION_ZERO = 41; // 0th or 60th second's position in pathList
/*              {39}
  101 102 * * * * 0 * * * * 18 19 
  100                          20
    *                           *
    *                           *
    *                           *  {23}
    *                           *
   80                          40
   79 78  * * * * * * * * * 42 41    
*/
const START_TOP_SIDE = 101;
const START_RIGHT_SIDE = 19;
const START_BOTTOM_SIDE = 41;
const START_LEFT_SIDE = 79;

const DARK_THEME = 'dark';
const LIGHT_THEME = 'light';

const PRIMARY_FONT = 'IBMPlexSans-Medium';
const SECONDARY_FONT = 'BebasNeue-Regular';

const List<Color> GOOGLE_COLORS = [
  Color(0xFF4081ed),
  Color(0xFFe44134),
  Color(0xFFf4b705),
  Color(0xFF33a351),
];
const List<String> GHOST_COLORS = [
  'blue',
  'red',
  'yellow',
  'green',
];

const DROID_IDLE = 'assets/elements/droid_idle.png';
const DROID_OPEN_MOUTH_LEFT = 'assets/elements/droid_open_mouth_left.png';
const DROID_OPEN_MOUTH_RIGHT = 'assets/elements/droid_open_mouth_right.png';

const APPLE_IDLE = 'assets/elements/apple.png';
const APPLE_BITTEN = 'assets/elements/apple_bitten.png';
