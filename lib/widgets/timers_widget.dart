import 'dart:async';

import 'package:flutter/material.dart';
import 'package:music_stats_app/data/data.dart';
import 'package:music_stats_app/widgets/timer_button.dart';

class TimersWidget extends StatefulWidget {
  const TimersWidget({Key? key}) : super(key: key);

  @override
  State<TimersWidget> createState() => _TimersWidgetState();
}

class _TimersWidgetState extends State<TimersWidget> {
  final List<bool> _timerState = [false, false, false];

  final List<String> _timerText = ["Repertorie ", "Technic ", "Analysis "];

  final List<ButtonStyle> _buttonStyle = [
    ElevatedButton.styleFrom(backgroundColor: Colors.red),
    ElevatedButton.styleFrom(backgroundColor: Colors.green),
    ElevatedButton.styleFrom(backgroundColor: Colors.blue)
  ];

  final List<int> _yestardayTime = [0, 0, 0];

  final List<ValueNotifier<int>> _timerValues = [
    ValueNotifier(0),
    ValueNotifier(0),
    ValueNotifier(0)
  ];

  final List<ValueNotifier<int>> _percents = [
    ValueNotifier(0),
    ValueNotifier(0),
    ValueNotifier(0)
  ];

  void _saveValues() {
    save(DateTime.now(), _timerValues[0].value, _timerValues[1].value,
        _timerValues[2].value);
  }

  Future<void> _loadValues() async {
    List<int>? data = await load(DateTime.now());

    if (data != null) {
      for (int i = 0; i < _timerValues.length; i++) {
        _timerValues[i].value = data[i];
        if (_yestardayTime[i] != 0) {
          _percents[i].value =
              ((data[i] / _yestardayTime[i] - 1) * 100).toInt();
        }
      }
    }
    setState(() {});
  }

  void onPress(int buttonNumber) {
    for (int i = 0; i < _timerState.length; i++) {
      if (i != buttonNumber) {
        _timerState[i] = false;
      } else {
        _timerState[i] = !_timerState[i];
      }
    }

    if (_timerState[buttonNumber]) {
      Timer periodicTimer = Timer.periodic(
        const Duration(seconds: 1),
        (timer) {
          if (!_timerState[buttonNumber]) {
            timer.cancel();
          }
          _timerValues[buttonNumber].value += 1;
          if (_yestardayTime[buttonNumber] != 0) {
            _percents[buttonNumber].value = ((_timerValues[buttonNumber].value /
                            _yestardayTime[buttonNumber] -
                        1) *
                    100)
                .toInt();
          }

          _saveValues();
          setState(() {});
        },
      );
    }
  }

  void Function() warpOnPress(int i) {
    void func() {
      onPress(i);
    }

    return func;
  }

  @override
  void initState() {
    super.initState();

    yestardayUpdater().then((value) => _loadValues());
  }

  @override
  void dispose() {
    _saveValues();
    super.dispose();
  }

  Future<void> yestardayUpdater() async {
    List<int>? yestardayData =
        await load((DateTime.now().subtract(const Duration(days: 1))));

    if (yestardayData != null) {
      for (int i = 0; i < _yestardayTime.length; i++) {
        _yestardayTime[i] = yestardayData[i];
      }
    }

    final hours = 24 - DateTime.now().hour;
    final minutes = 60 - DateTime.now().minute + hours * 60;

    Future.delayed(Duration(minutes: minutes), () => yestardayUpdater);
  }

  @override
  Widget build(BuildContext context) {
    List<TimerButton> timerButtons = [];
    List<Widget> timerButtonContainers = [const SizedBox(height: 5)];

    for (int i = 0; i < _timerText.length; i++) {
      timerButtons
          .add(TimerButton(_timerText[i], _timerValues[i], _percents[i]));
    }

    for (int i = 0; i < timerButtons.length; i++) {
      timerButtonContainers.add(_TimerButtonContainer(
          child: ElevatedButton(
              style: _buttonStyle[i],
              onPressed: warpOnPress(i),
              child: timerButtons[i])));
    }

    return SizedBox(
        width: double.infinity, child: Column(children: timerButtonContainers));
  }
}

class _TimerButtonContainer extends StatelessWidget {
  final Widget child;

  const _TimerButtonContainer({Key? key, required this.child})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Expanded(
        child: Padding(
            padding: const EdgeInsets.fromLTRB(5, 0, 5, 5),
            child: SizedBox(width: double.infinity, child: child)));
  }
}
