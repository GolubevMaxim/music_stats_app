import 'package:flutter/material.dart';
import 'package:music_stats_app/widgets/statistic_widget.dart';
import 'package:music_stats_app/widgets/timers_widget.dart';

class MainScreen extends StatelessWidget {
  const MainScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const SizedBox(
        width: double.infinity,
        child: Column(children: [
          Expanded(flex: 2, child: TimersWidget()),
          Expanded(flex: 1, child: StatisticWidget())
        ]));
  }
}
