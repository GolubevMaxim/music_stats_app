import 'package:flutter/material.dart';
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

  @override
  Widget build(BuildContext context) {
    List<TimerButton> timerButtons = [];
    List<Widget> timerButtonContainers = [const SizedBox(height: 5)];

    for (int i = 0; i < _timerText.length; i++) {
      timerButtons.add(TimerButton(_timerText[i]));
    }

    for (int i = 0; i < timerButtons.length; i++) {
      timerButtonContainers.add(_TimerButtonContainer(
          child: ElevatedButton(
              style: _buttonStyle[i],
              onPressed: () {},
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
