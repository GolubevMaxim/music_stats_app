import 'package:flutter/material.dart';
import 'package:music_stats_app/data/data.dart';

class TimersModel extends ChangeNotifier {
  final List<bool> states = [false, false, false];
  final List<int> values = [0, 0, 0];

  final List<int> yesterdayValues = [0, 0, 0];

  TimersModel() {
    _updaterYesterdayValues();
    _loadValues();
  }

  void Function() changeStateBuilder(int timerInd) {
    void func() {
      _changeState(timerInd);
    }

    return func;
  }

  int getPercent(int timerInd) {
    if (yesterdayValues[timerInd] == 0) {
      return 0;
    }
    return ((values[timerInd] / yesterdayValues[timerInd] - 1) * 100).toInt();
  }

  int getTotalTime() {
    return values.reduce((value, element) => value + element);
  }

  int getTotalPercent() {
    int totalTime = getTotalTime();
    int totalYesterdayTime = yesterdayValues.reduce((a, b) => a + b);

    if (totalYesterdayTime == 0) {
      return 0;
    }
    return ((totalTime / totalYesterdayTime - 1) * 100).toInt();
  }

  void _changeState(int timerInd) {
    for (int i = 0; i < states.length; i++) {
      if (i != timerInd) {
        states[i] = false;
      } else {
        states[i] = !states[i];
      }
    }

    if (states[timerInd]) {
      _clock(timerInd);
    } else {
      notifyListeners();
    }
  }

  void _clock(int timerInd) {
    if (!states[timerInd]) {
      return;
    }

    values[timerInd]++;

    notifyListeners();
    save(DateTime.now(), values);

    Future.delayed(const Duration(seconds: 1), () => _clock(timerInd));
  }

  void _updaterYesterdayValues() {
    load(DateTime.now().subtract(const Duration(days: 1))).then((value) {
      if (value != null) {
        for (int i = 0; i < yesterdayValues.length; i++) {
          yesterdayValues[i] = value[i];
        }

        notifyListeners();
      }
    });

    final int hours = 24 - DateTime.now().hour;
    final int minutes = hours * 60 + 60 - DateTime.now().minute;

    Future.delayed(Duration(minutes: minutes), () => _updaterYesterdayValues());
  }

  void _loadValues() {
    load(DateTime.now()).then((value) {
      if (value != null) {
        for (int i = 0; i < values.length; i++) {
          values[i] = value[i];
        }
      }

      notifyListeners();
    });
  }
}
