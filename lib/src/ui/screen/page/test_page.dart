import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:location/location.dart';



class TestPage extends StatefulWidget {
  TestPage({Key key}) : super(key: key);

  @override
  _TestPageState createState() => _TestPageState();
}

class _TestPageState extends State<TestPage> {
  LocationData _currentLocation;

  Location _locationService = new Location();
  bool _permission = false;

  double latitude;
  double longtitude;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    latitude = 0;
    longtitude = 0;
    initPlatformState();
  }

  initPlatformState() async {
    await _locationService.changeSettings(
        accuracy: LocationAccuracy.HIGH, interval: 1000);
    LocationData location;
    try {
      bool serviceStatus = await _locationService.serviceEnabled();
      print("Service status: $serviceStatus");
      if (serviceStatus) {
        _permission = await _locationService.requestPermission();
        print("Permission: $_permission");

        if (_permission) {
          location = await _locationService.getLocation();
          print('LOCATION LATITUDE: ${location.latitude}');
          print('LOCATION LONGTITUDE: ${location.longitude}');
          latitude = location.latitude;
          longtitude = location.longitude;
        }
      } else {}
    } catch (e) {
      print('ERROR: ${e}');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        floatingActionButton: FloatingActionButton(
          child: Icon(Icons.ac_unit),
          onPressed: () async {
            var location = await _locationService.getLocation();
            setState(() {
              this.latitude = location.latitude;
              this.longtitude = location.longitude;
            
            });
          },
        ),
        body: Center(
            child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: <Widget>[
            Text('LATITUDE: ${this.latitude}'), 
            Text('LONGTITUDE: ${this.longtitude}')
          ],
        )));
  }
}
