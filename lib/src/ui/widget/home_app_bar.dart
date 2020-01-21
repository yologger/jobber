import 'package:flutter/material.dart';
import 'package:jobber/src/core/provider/location_provider.dart';
import 'package:provider/provider.dart';
import 'package:jobber/src/core/provider/jobs_provider.dart';

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
              LocationProvider locationProvider =
                  Provider.of<LocationProvider>(context, listen: false);
              JobsProvider jobsProvider =
                  Provider.of<JobsProvider>(context, listen: false);

              if (locationProvider.isServiceOn()) {
                jobsProvider.clearJobs();
                locationProvider.refreshLocation();
                jobsProvider.getJobs(
                  latitude: locationProvider.latitude,
                  longtitude: locationProvider.longtitude,
                );
              } else {
                locationProvider.disposeService();
                locationProvider.initService();
                jobsProvider.clearJobs();
                locationProvider.refreshLocation();
                jobsProvider.getJobs();
              }
            }),
      ],
      bottom: TabBar(
        indicatorColor: Theme.of(context).accentColor,
        tabs: <Widget>[
          Tab(text: 'Near', icon: Icon(Icons.home)),
          Tab(text: 'Bookmark', icon: Icon(Icons.bookmark)),
        ],
      ),
    );
  }
}
