import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:music_stats_app/widgets/main_screen.dart';

class App extends StatelessWidget {
  const App({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        theme: ThemeData(fontFamily: GoogleFonts.titanOne().fontFamily),
        home: Scaffold(
          appBar: AppBar(title: const Text("Main screen")),
          body: const MainScreen(),
        ));
  }
}
