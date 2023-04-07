import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../data/tools.dart';

class TimerButton extends StatelessWidget {
  final String text;
  final ValueListenable<int> number;
  final ValueListenable<int> percente;

  const TimerButton(this.text, this.number, this.percente, {super.key});

  @override
  Widget build(BuildContext context) {
    return Row(children: [
      Expanded(
          flex: 2,
          child: Column(children: [
            TextWarp(text: text),
            TextWarp(text: durationFormat(Duration(seconds: number.value)))
          ])),
      Expanded(
          flex: 1,
          child: Text("${percente.value.toString()}%",
              style: GoogleFonts.getFont("Titan One", fontSize: 25)))
    ]);
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
