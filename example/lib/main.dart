import 'package:example/home_screen.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(CalendarApp());
}

ValueNotifier<bool> darkThemeNotifier = ValueNotifier(false);

class CalendarApp extends StatelessWidget {
  const CalendarApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder(
        valueListenable: darkThemeNotifier,
        builder: (context, value, _) {
          return MaterialApp(
            themeMode: value ? ThemeMode.dark : ThemeMode.light,
            theme: ThemeData(brightness: Brightness.light),
            darkTheme: ThemeData(brightness: Brightness.dark),
            home: HomeScreen(),
          );
        });
  }
}
