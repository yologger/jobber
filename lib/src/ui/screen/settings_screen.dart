import 'package:flutter/material.dart';
import 'package:jobber/src/core/provider/jobs_provider.dart';
import 'package:jobber/src/core/provider/location_provider.dart';
import 'package:location/location.dart';
import 'package:provider/provider.dart';

class SettingsScreen extends StatefulWidget {
  SettingsScreen({Key key}) : super(key: key);

  @override
  _SettingsScreenState createState() => _SettingsScreenState();
}

class _SettingsScreenState extends State<SettingsScreen> {
  // SettingsScreen({Key key}) : super(key: key);

  @override
  _SettingsScreenState createState() => _SettingsScreenState();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }


  @override
  Widget build(BuildContext context) {
    
    LocationProvider locationProvider = Provider.of<LocationProvider>(context);
    JobsProvider jobsProvider = Provider.of<JobsProvider>(context);

    return Scaffold(
      appBar: AppBar(
        title: Text('Settings'),
      ),
      body: ListView(
        children: <Widget>[
          ListTile(
            title: Text(
              'Positions',
              style: Theme.of(context).textTheme.subtitle,
            ),
          ),
          SwitchListTile.adaptive(
              activeColor: Theme.of(context).colorScheme.secondary,
              title: Text('Use location'),
              subtitle:
                  Text('Positions will be filtered by the your location.'),
              value: locationProvider.isServiceOn(),
              onChanged: (setting) async {
                if(locationProvider.isServiceOn()) {
                  locationProvider.disposeService();
                  jobsProvider.clearJobs();
                  jobsProvider.getJobs();
                } else {
                  locationProvider.initService();
                  locationProvider.refreshLocation();
                  print('LATITUDE: ${locationProvider.latitude}');
                  print('LATITUDE: ${locationProvider.longtitude}');
                  jobsProvider.clearJobs();
                  jobsProvider.getJobs(
                    latitude: locationProvider.latitude,
                    longtitude: locationProvider.longtitude,
                  );
                }
              }),
          const Divider(),
        ],
      ),
    );
  }
}
