import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:jobber/src/core/provider/jobs_provider.dart';


class HomeAppBar extends StatelessWidget {
  const HomeAppBar({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {

    final JobsProvider jobsProvider = Provider.of<JobsProvider>(context);

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
            jobsProvider.getJobs();
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
