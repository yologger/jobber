import 'package:flutter/material.dart';
import 'package:jobber/src/ui/screen/home_screen.dart';
import 'package:jobber/src/ui/screen/detail_screen.dart';
import 'package:jobber/src/ui/screen/settings_screen.dart';
import 'package:jobber/src/ui/theme/theme.dart';
import 'package:provider/provider.dart';
import 'package:jobber/src/core/provider/jobs_provider.dart';

class JobberApp extends StatefulWidget {
  JobberApp({Key key}) : super(key: key);

  @override
  _JobberAppState createState() => _JobberAppState();
}

class _JobberAppState extends State<JobberApp> {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
        providers: [
          ChangeNotifierProvider(
            create: (_) {
              print('app.dart');
              return JobsProvider()..loadJobs();
            }
          ),
        ],
        child: MaterialApp(theme: buildTheme(), initialRoute: '/', routes: {
          '/': (context) => HomeScreen(),
          '/detail': (context) => DetailScreen(),
          '/settings': (context) => SettingsScreen(),
        }));
  }
}
