import 'package:flutter/material.dart';
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

  LocationData _currentLocation;

  Location _locationService = new Location();
  bool _permission = false;

  double latitude = 0;
  double longtitude = 0;

  bool isSwitchOn = false;
  String error = '';

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    latitude = 0;
    longtitude = 0;
    initPlatformState();
  }

  initPlatformState() async {

    await _locationService.changeSettings(accuracy: LocationAccuracy.HIGH, interval: 1000);
    LocationData location;

    try {
      bool serviceStatus = await _locationService.serviceEnabled();
      print("Service status: $serviceStatus");
      if (serviceStatus) {
        _permission = await _locationService.requestPermission();
        print("Permission: $_permission");
        if (_permission) {
          location = await _locationService.getLocation();
          latitude = location.latitude;
          longtitude = location.longitude;
        } else {
          
        }
      } else {
        print("Service Can't not be used.");
      }
    } catch (e) {
      print(e);
      if (e.code == 'PERMISSION_DENIED') {
        error = e.message;
      } else if (e.code == 'SERVICE_STATUS_ERROR') {
        error = e.message;
      }
      location = null;
    }
  }


  @override
  Widget build(BuildContext context) {

    LocationProvider locationProvider = Provider.of<LocationProvider>(context);

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
              value: isSwitchOn,
              onChanged: (setting) async {
                if (isSwitchOn) {
                  locationProvider.latitude = 0.0;
                  locationProvider.longtitude = 0.0;
                  setState(() {
                    this.isSwitchOn = false;
                  });
                } else {
                  locationProvider.refreshLocation();
                  setState(() {
                    this.isSwitchOn = true;
                  });
                }
              }),
          const Divider(),
          ListTile(
            title: Text(
              'Latitude: ${locationProvider.latitude}',
              style: Theme.of(context).textTheme.subtitle,
            ),
          ),
          ListTile(
            title: Text(
              'Latitude: ${locationProvider.longtitude}',
              style: Theme.of(context).textTheme.subtitle,
            ),
          ),
        ],
      ),
    );
  }
}
