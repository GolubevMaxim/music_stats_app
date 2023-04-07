import 'package:flutter/material.dart';
import 'package:music_stats_app/models/change_notifier_provider.dart';
import 'package:music_stats_app/models/timers_model.dart';
import 'package:music_stats_app/widgets/timer_button.dart';

class TimerParameters {
  final String text;
  final ButtonStyle activeColor;
  final ButtonStyle inactiveColor;

  const TimerParameters(
    this.text,
    this.activeColor,
    this.inactiveColor,
  );
}

class TimersWidget extends StatelessWidget {
  final List<TimerParameters> timerParameters;

  const TimersWidget({Key? key, required this.timerParameters})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    List<TimerButton> timerButtons = [];
    List<Widget> timerButtonContainers = [const SizedBox(height: 5)];

    for (int i = 0; i < timerParameters.length; i++) {
      timerButtons.add(TimerButton(
          i,
          ChangeNotifierProvider.read<TimersModel>(context)
              ?.changeStateBuilder(i),
          timerParameters[i]));
    }

    for (int i = 0; i < timerButtons.length; i++) {
      timerButtonContainers.add(_TimerButtonContainer(child: timerButtons[i]));
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
