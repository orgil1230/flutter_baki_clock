import 'dart:io';

import 'package:intl/intl.dart';
import 'package:states_rebuilder/states_rebuilder.dart';

import '../config/const.dart';

class DroidModel extends StatesRebuilder {
  var _position = 0;
  var _now = DateTime.now();

  DroidModel() {
    print(_now);
    _setFirstDroidPosition();
  }

  get position => _position;
  set setPosition(int position) {
    if (_position != position) {
      _position = position;
      rebuildStates();
    }
  }

  /* Let we know first Droid Position
   * Only app first time sleep until round integer second : 1.003 + sleep(0.997s) ~ 2, 1.450 + sleep(0.150s) ~ 2
   * Then _updateTime beginning of new second and fractionalSecond will be < 500milliseconds.*/
  void _setFirstDroidPosition() {
    _now = DateTime.now();
    int second = int.parse(DateFormat('s').format(_now));
    int fractionalSecond = int.parse(DateFormat('S').format(_now));
    fractionalSecond = MILLI_SECOND - fractionalSecond;

    sleep(Duration(milliseconds: fractionalSecond));
    _position = second * 2 + 1;
  }

  /* Update droid position per 0.5 second. Make sure to do it at the beginning of each
   * new second, so that the clock is accurate.
   * Testing on emulator for 3 days and proved no mistake.*/
  Future<void> moveDroid() async {
    _now = DateTime.now();
    int second = int.parse(DateFormat('s').format(_now));
    int fractionalSecond = int.parse(DateFormat('S').format(_now));
    var sleepTime = 0;

    if (_position.isOdd) {
      sleepTime = fractionalSecond > MOVE_SPEED //Just in case
          ? fractionalSecond - MOVE_SPEED
          : MOVE_SPEED - fractionalSecond;
      _position = second * 2;
    } else {
      sleepTime = MILLI_SECOND - fractionalSecond;
      _position = second * 2 + 1;
    }
    rebuildStates();
    await Future.delayed(Duration(milliseconds: sleepTime), moveDroid);
  }
}
