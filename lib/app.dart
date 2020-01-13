import 'package:flutter/material.dart';
import 'package:jobber/src/ui/screen/home_screen.dart';
import 'package:jobber/src/ui/screen/detail_screen.dart';
import 'package:jobber/src/ui/screen/settings_screen.dart';


class JobberApp extends StatefulWidget {
  JobberApp({Key key}) : super(key: key);

  @override
  _JobberAppState createState() => _JobberAppState();
}

class _JobberAppState extends State<JobberApp> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      initialRoute: '/',
      routes: {
        '/': (context) => HomeScreen(),
        '/detail': (context) => DetailScreen(),
        '/settings': (context) => SettingsScreen(),
      }
    );
  }
}
