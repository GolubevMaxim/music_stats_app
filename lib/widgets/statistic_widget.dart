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
  @override
  Widget build(BuildContext context) {
    return SizedBox(
        width: double.infinity,
        child: Row(children: [
          TextWarp(text: "Total: ${durationFormat(Duration(seconds: 0))}"),
          TextWarp(text: "xxx%")
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
