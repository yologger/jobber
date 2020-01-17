import 'package:flutter/material.dart';
import 'package:location/location.dart';

class LocationProvider extends ChangeNotifier {

  Location _locationService = new Location();

  LocationData location;
  double _latitude = 40;
  double _longtitude = 60;

  get latitude => _latitude;
  get longtitude => _longtitude;

  set latitude(value) => _latitude = value;
  set longtitude(value) => _longtitude = value;

  Future<bool> isServiceEnabled() async {
    bool serviceStatus = await _locationService.serviceEnabled();
    return serviceStatus;
  }

  Future<bool> checkAndRequestPermission() async {
    try {
      await isServiceEnabled();
      return await _locationService.requestPermission();
    } catch(e) {
      print('ERROR: {e}');
      return Future.value(false);
    }
  }

  /// isServiceEnabled(), checkAndRequestPermission() must be called before this method.
  void refreshLocation() async {
    location = await _locationService.getLocation();
    _latitude = location.latitude;
    _longtitude = location.latitude;
    notifyListeners();
  }
}