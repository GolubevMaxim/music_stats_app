import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:music_stats_app/models/change_notifier_provider.dart';
import 'package:music_stats_app/models/timers_model.dart';
import 'package:music_stats_app/widgets/timers_widget.dart';

import '../data/tools.dart';

class TimerButton extends StatelessWidget {
  final int timerInd;
  final void Function()? onPressed;

  final TimerParameters parameters;

  const TimerButton(this.timerInd, this.onPressed, this.parameters,
      {super.key});

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      style: {
        true: parameters.activeColor,
        false: parameters.inactiveColor
      }[ChangeNotifierProvider.watch<TimersModel>(context)?.states[timerInd] ??
          false],
      onPressed: onPressed,
      child: Row(children: [
        Expanded(
            flex: 2,
            child: Column(children: [
              TextWarp(text: parameters.text),
              TextWarp(
                  text: durationFormat(Duration(
                      seconds:
                          ChangeNotifierProvider.watch<TimersModel>(context)
                                  ?.values[timerInd] ??
                              0)))
            ])),
        Expanded(
            flex: 1,
            child: Text(
                "${ChangeNotifierProvider.watch<TimersModel>(context)?.getPercent(timerInd) ?? 0}%",
                style: GoogleFonts.getFont("Titan One", fontSize: 25)))
      ]),
    );
  }
}

class TextWarp extends StatelessWidget {
  const TextWarp({
    super.key,
    required this.text,
  });

  final String text;

  @override
  Widget build(BuildContext context) {
    return Expanded(
        child: SizedBox(
            width: double.infinity,
            child: Align(
                alignment: Alignment.centerLeft,
                child: Text(text,
                    style: GoogleFonts.getFont("Titan One", fontSize: 25)))));
  }
}
