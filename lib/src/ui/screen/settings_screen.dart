import 'package:flutter/material.dart';

class SettingsScreen extends StatefulWidget {
  SettingsScreen({Key key}) : super(key: key);

  @override
  _SettingsScreenState createState() => _SettingsScreenState();
}

class UserLocation {
  final double latitude;
  final double longitude;

  UserLocation({
    this.latitude,
    this.longitude,
  });
}

class _SettingsScreenState extends State<SettingsScreen> {
  var dummyUserLocation =
      UserLocation(latitude: 37.566536, longitude: 126.977966);

  bool isSwitchOn = false;

  @override
  Widget build(BuildContext context) {
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
              onChanged: (setting) {
                setState(() {
                  isSwitchOn = !isSwitchOn;
                });
              }
            ),
          const Divider(),
        ],
      ),
    );
  }
}
