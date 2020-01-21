import 'package:flutter/material.dart';
import 'package:http/http.dart';
import 'dart:convert';

import 'package:jobber/src/core/model/screen_arguments.dart';
import 'package:jobber/src/core/provider/location_provider.dart';
import 'package:location/location.dart';
import 'package:provider/provider.dart';

class JobsProvider extends ChangeNotifier {

  final _client = Client();
  final _baseUrl = 'https://jobs.github.com';
  List<dynamic> _jobs = [];
  List<dynamic> _bookmarked = [];
  int page = 1;
  bool _isMoreData = true;
  bool isLoading = false;
  bool isFirst = true;

  get jobs => _jobs;
  get isMoreData => _isMoreData;

  void clearJobs() {
    _jobs = [];
    page = 1;
    _isMoreData = true;
    notifyListeners();
  }

  void getJobs({double latitude, double longtitude}) async {

    Response response;
    String url;

    isLoading = true;
    notifyListeners();

    if (latitude != null && longtitude != null) {
      print('LOCATION ON!');
      url = "${_baseUrl}/positions.json?markdown=true&lat=40.711432&long=-74.006931&page=${page}";
    } else {
      print('LOCATION OFF!');
      url = "${_baseUrl}/positions.json?markdown=true&page=${page}";
    }

    try {
      response = await _client.get(url);
      var result = _handleResponse(response);
      print('RESULT_LENGTH: ${result.length}');
      if (result.length != 0) {
        result.forEach((job) {
          _jobs.add(job);
        });
        page = page + 1;
      } else {
        _isMoreData = false;
      }
      isLoading = false;
      notifyListeners();
    } catch (e) {
      print('Failed to get jobs from location: $e');
      _isMoreData = false;
      isLoading = true;
      notifyListeners();
      _jobs = [];
    } finally {
      print('LENGTH: ${jobs.length}');
    }
  }
  


  // final _client = Client();
  // final _baseUrl = 'https://jobs.github.com';
  // final LocationProvider locationProvider = LocationProvider();
  // int page = 1;
  // bool _isInitialLoading = true;
  // bool _isMoreData = true;
  // bool _isLoading = false;
  // List<dynamic> _jobs = [];
  // List<dynamic> _saved = [];

  // get isMoreData => _isMoreData;
  // get isLoading => _isLoading;
  // get isInitialLoading => _isInitialLoading;
  // get jobs => _jobs;
  // get saved => _saved;

  // void clearJobs() {
  //   page = 1;
  //   _isInitialLoading = true;
  //   _isMoreData = true;
  //   _isLoading = false;
  //   List<dynamic> _jobs = [];
  //   List<dynamic> _saved = [];
  // }

  // void getJobs({double latitude, double longtitude}) async {
  //   Response response;
  //   String url;

  //   _isLoading = true;
  //   notifyListeners();

  //   if (locationProvider.isServiceOn) {
  //     print('LOCATION ON!');
  //     url =
  //         "${_baseUrl}/positions.json?markdown=true&lat=40.711432&long=-74.006931&page=${page}";
  //   } else {
  //     print('LOCATION OFF!');
  //     url = "${_baseUrl}/positions.json?markdown=true&page=${page}";
  //   }

  //   try {
  //     response = await _client.get(url);
  //     var result = _handleResponse(response);
  //     print('RESULT_LENGTH: ${result.length}');
  //     if (result.length != 0) {
  //       result.forEach((job) {
  //         _jobs.add(job);
  //       });
  //       page = page + 1;
  //     } else {
  //       _isMoreData = false;
  //     }
  //     _isLoading = false;
  //     if (_isInitialLoading) {
  //       _isInitialLoading = false;
  //     }
  //     notifyListeners();
  //   } catch (e) {
  //     print('Failed to get jobs from location: $e');
  //     _jobs = [];
  //   }
  // }

  // bool containItem(ScreenArguments arguments) {
  //   return _saved.contains(arguments);
  // }

  // bool findItemById(String id) {
  //   for (var item in _saved) {
  //     if (item.id == id) {
  //       return true;
  //     }
  //   }
  //   return false;
  // }

  // void save(ScreenArguments arguments) {
  //   _saved.add(arguments);
  //   print(_saved);
  //   notifyListeners();
  // }

  // void remove(String id) {
  //   var newSaved;
  //   newSaved = _saved.where((item) => item.id != id).toList();
  //   _saved = newSaved;
  //   print(_saved);
  //   notifyListeners();
  // }

  dynamic _handleResponse(Response response, {String error}) {
    if (response.statusCode == 200) {
      return json.decode(response.body);
    } else {
      throw error ?? 'Failed to get positions';
    }
  }
}
