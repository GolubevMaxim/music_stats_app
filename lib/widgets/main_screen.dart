import 'package:flutter/material.dart';
import 'package:music_stats_app/models/change_notifier_provider.dart';
import 'package:music_stats_app/models/timers_model.dart';
import 'package:music_stats_app/widgets/statistic_widget.dart';
import 'package:music_stats_app/widgets/timers_widget.dart';

class MainScreen extends StatefulWidget {
  const MainScreen({Key? key}) : super(key: key);

  @override
  MainScreenState createState() => MainScreenState();
}

class MainScreenState extends State<MainScreen> {
  final _model = TimersModel();

  @override
  Widget build(BuildContext context) {
    return SizedBox(
        width: double.infinity,
        child: ChangeNotifierProvider(
          model: _model,
          child: const Column(children: [
            Expanded(flex: 2, child: Timers()),
            Expanded(flex: 1, child: StatisticWidget())
          ]),
        ));
  }
}

class Timers extends StatelessWidget {
  const Timers({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return const TimersWidget(timerParameters: [
      TimerParameters(
          "Repertoire ",
          ButtonStyle(
              backgroundColor: MaterialStatePropertyAll<Color>(
                  Color.fromARGB(255, 244, 53, 53))),
          ButtonStyle(
              backgroundColor: MaterialStatePropertyAll<Color>(
                  Color.fromARGB(255, 85, 26, 26)))),
      TimerParameters(
          "Technic ",
          ButtonStyle(
              backgroundColor: MaterialStatePropertyAll<Color>(
                  Color.fromARGB(255, 53, 244, 148))),
          ButtonStyle(
              backgroundColor: MaterialStatePropertyAll<Color>(
                  Color.fromARGB(255, 33, 109, 33)))),
      TimerParameters(
          "Analysis ",
          ButtonStyle(
              backgroundColor: MaterialStatePropertyAll<Color>(
                  Color.fromARGB(255, 84, 210, 255))),
          ButtonStyle(
              backgroundColor: MaterialStatePropertyAll<Color>(
                  Color.fromARGB(255, 44, 44, 146))))
    ]);
  }
}
