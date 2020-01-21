import 'package:flutter/material.dart';
import 'package:location/location.dart';

class LocationProvider extends ChangeNotifier {

  Location _locationService;
  LocationData _location;
  double _latitude;
  double _longtitude;

  get latitude => _latitude;
  get longtitude => _longtitude;

  Future<bool> initService() async {
    try {
       _locationService = new Location();
       await _locationService.changeSettings(accuracy: LocationAccuracy.HIGH, interval: 1000);
       await _locationService.serviceEnabled();
       await _locationService.requestPermission();
       notifyListeners();

    } catch (e) {
      print(e);
      return false;
    }
  }

  void disposeService() {
    _locationService = null;
  }

  bool isServiceOn() {
    return _locationService != null;
  }

  void refreshLocation() async {
    if(isServiceOn()) {
      _location = await _locationService.getLocation();
      _latitude = _location.latitude;
      _longtitude = _location.longitude;
      notifyListeners();
    } else {
      throw('LocationServiceOffException');
    }
  }


//   Location _locationService;
//   LocationData location;
//   bool _isServiceOn = false;
//   double _latitude;
//   double _longtitude;

//   get latitude => _latitude;
//   get longtitude => _longtitude;

//   set latitude(value) => _latitude = value;
//   set longtitude(value) => _longtitude = value;


//   Future<bool> initService() async {
//     try {
//       _locationService = new Location();
//       await _locationService.changeSettings(accuracy: LocationAccuracy.HIGH, interval: 1000);
//       await _locationService.serviceEnabled();
//       await _locationService.requestPermission();
//       print('isServiceOn!');
//       notifyListeners();
//     } catch (e) {
//       print(e);
//     }
//   }

//   disposeService() {
//     _locationService = null;
//     notifyListeners();
//   }

//   bool isServiceOn() {
//     return _locationService != null;
//   }

//   void getLocation() {
//     // print('getLocation');
//     // try {
//     //   location = await _locationService.getLocation();
//     //   _latitude = location.latitude;
//     //   _longtitude = location.latitude;
//     //   notifyListeners();
//     // } catch(e) {
//     //   print(e);
//     // }
//   }

//   void disposeService() {
//     _locationService = null;
//     location = null;
//     _latitude = null;
//     _longtitude = null;
//     _isServiceOn = false;
//     notifyListeners();
//   }

// }

}
