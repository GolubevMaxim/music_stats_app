import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:music_stats_app/data/data.dart';

import '../data/tools.dart';

class StatisticWidget extends StatefulWidget {
  const StatisticWidget({Key? key}) : super(key: key);

  @override
  State<StatisticWidget> createState() => _StatisticWidgetState();
}

class _StatisticWidgetState extends State<StatisticWidget> {
  int timeSum = 0;
  int percentSum = 0;

  int yestardayTimeSum = 0;

  @override
  void initState() {
    super.initState();

    yestardayUpdater().then((value) => getStats());
  }

  Future<void> yestardayUpdater() async {
    List<int>? yestardayData =
        await load((DateTime.now().subtract(const Duration(days: 1))));

    if (yestardayData != null) {
      yestardayTimeSum = yestardayData.reduce((value, elem) => value + elem);
    }

    final hours = 24 - DateTime.now().hour;
    final minutes = 60 - DateTime.now().minute + hours * 60;

    Future.delayed(Duration(minutes: minutes), () => yestardayUpdater);
  }

  void getStats() {
    load(DateTime.now()).then((date) {
      if (date != null) {
        timeSum = date.reduce((value, element) => value + element);
        percentSum = ((timeSum / yestardayTimeSum - 1) * 100).toInt();
      }
    });

    setState(() {});
    Future.delayed(const Duration(seconds: 1), getStats);
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
        width: double.infinity,
        child: Row(children: [
          TextWarp(
              text: "Total: ${durationFormat(Duration(seconds: timeSum))}"),
          TextWarp(text: "$percentSum%")
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
