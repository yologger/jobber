import 'package:flutter/material.dart';

class HomeAppBar extends StatelessWidget {
  const HomeAppBar({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SliverAppBar(
      floating: true,
      pinned: true,
      snap: true,
      forceElevated: true,
      title: Text('Jobber'),
      leading: IconButton(
        icon: Icon(Icons.settings),
        tooltip: 'Settings',
        onPressed: () => Navigator.of(context).pushNamed('/settings'),
      ),
      actions: <Widget>[
        IconButton(
          icon: Icon(Icons.refresh),
          onPressed: () {
            print('REFRESH!!!');
          },
        ),
      ],
      bottom: TabBar(
        indicatorColor: Theme.of(context).accentColor,
        tabs: <Widget>[
          Tab(text: 'Near Me', icon: Icon(Icons.home)),
          Tab(text: 'Saved', icon: Icon(Icons.star)),
          Tab(text: 'Test', icon: Icon(Icons.ac_unit)),
        ],
      ),
    );
  }
}
