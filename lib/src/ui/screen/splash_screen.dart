import 'dart:async';

import 'package:flutter/material.dart';
import 'package:jobber/src/core/provider/jobs_provider.dart';
import 'package:provider/provider.dart';
import 'package:jobber/src/core/provider/location_provider.dart';

class SplashScreen extends StatefulWidget {
  SplashScreen({Key key}) : super(key: key);

  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  bool isLoading = true;
  LocationProvider locationProvider;
  JobsProvider jobsProvider;

  @override
  void initState() {
    super.initState();

    Future.delayed(Duration.zero, () async {
      locationProvider = Provider.of<LocationProvider>(context, listen: false);
      jobsProvider = Provider.of<JobsProvider>(context, listen: false);
      await locationProvider.initService();
      await locationProvider.refreshLocation();
      if(locationProvider.isServiceOn()) {
        jobsProvider.getJobs(
          latitude: locationProvider.latitude,
          longtitude: locationProvider.longtitude
        );
      } else {
        jobsProvider.getJobs();
      }
      setState(() {
        isLoading = false;
      });
      Navigator.of(context).pushNamed('/');
    });
  }

  @override
  Widget build(BuildContext context) {

    return Scaffold(
        body: Center(
      child: isLoading ? Text('INITIALIZING....') : Text('FINISHED!!!'),
    ));
  }
}
