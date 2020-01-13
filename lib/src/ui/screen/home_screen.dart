import 'package:flutter/material.dart';
import 'package:jobber/src/ui/widget/home_app_bar.dart';
import 'package:jobber/src/core/model/screen_arguments.dart';

class HomeScreen extends StatefulWidget {
  HomeScreen({Key key}) : super(key: key);

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        body: NestedScrollView(
          headerSliverBuilder: (context, innerBoxScrolled) => [HomeAppBar()],
          body: TabBarView(
            children: <Widget>[
              AnimatedList(
                initialItemCount: 5,
                itemBuilder: (context, index, animation) {
                  return Column(
                    children: <Widget>[
                      ListTile(
                        title: Text('Title'),
                        subtitle: Text('Subtitle'),
                        onTap: () {
                          print('${index} item tapped.!');
                          Navigator.pushNamed(context, '/detail',
                              arguments: ScreenArguments(
                                  index: index, message: 'data from ${index}'));
                        },
                      ),
                      Divider(height: 1.0),
                    ],
                  );
                },
              ),
              AnimatedList(
                initialItemCount: 5,
                itemBuilder: (context, index, animation) {
                  return Column(
                    children: <Widget>[
                      ListTile(
                        title: Text('Title'),
                        subtitle: Text('Subtitle'),
                        onTap: () {
                          print('${index} item tapped.!');
                          Navigator.pushNamed(context, '/detail',
                              arguments: ScreenArguments(
                                  index: index, message: 'data from ${index}'));
                        },
                      ),
                      Divider(height: 1.0),
                    ],
                  );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
