import 'package:flutter/material.dart';

class TimersModel extends ChangeNotifier {
  List<bool> states = [false, false, false];
  List<int> values = [0, 0, 0];

  void changeState(int timerInd) {
    for (int i = 0; i < states.length; i++) {
      if (i != timerInd) {
        states[i] = false;
      } else {
        states[i] = !states[i];
      }
    }
  }

  void Function() changeStateBuilder(int timerInd) {
    void func() {
      changeState(timerInd);
    }

    return func;
  }

  void clock(int timerInd) {
    if (!states[timerInd]) {
      return;
    }

    values[timerInd]++;
    notifyListeners();

    Future.delayed(const Duration(seconds: 1), () => clock(timerInd));
  }
}
