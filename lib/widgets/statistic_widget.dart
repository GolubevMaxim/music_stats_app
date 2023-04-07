import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../data/tools.dart';
import '../models/change_notifier_provider.dart';
import '../models/timers_model.dart';

class StatisticWidget extends StatelessWidget {
  const StatisticWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
        width: double.infinity,
        child: Row(children: [
          TextWarp(
              text:
                  "Total: ${durationFormat(Duration(seconds: ChangeNotifierProvider.watch<TimersModel>(context)?.getTotalTime() ?? 0))}"),
          TextWarp(
              text:
                  "${ChangeNotifierProvider.watch<TimersModel>(context)?.getTotalPercent() ?? 0}%")
        ]));
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
                alignment: Alignment.topCenter,
                child: Text(text,
                    style: GoogleFonts.getFont("Titan One", fontSize: 25)))));
  }
}
