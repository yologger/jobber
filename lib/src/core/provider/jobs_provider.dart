import 'package:flutter/material.dart';
import 'package:http/http.dart';
import 'dart:convert';

import 'package:jobber/src/core/model/screen_arguments.dart';

class JobsProvider extends ChangeNotifier {
  
  final _client = Client();
  final _baseUrl = 'https://jobs.github.com';

  int page = 1;

  bool _isLoading = false;
  bool _isMoreData = true;

  get isMoreData => _isMoreData;
  get isLoading => _isLoading;
  get jobs => _jobs;
  get saved => _saved;

  List<dynamic> _jobs = [];
  List<dynamic> _saved = [];


  void loadJobs({String location}) async {

    _isLoading = true;

    notifyListeners();
    Response response;

    if (location != null) {
      try {
        response = await _client.get('$_baseUrl/positions.json?markdown=true&location=${location}');
      } catch (e) {
        print('Failed to get jobs from location: $e');
        _jobs = [];
      }
    } else {
      try {
        response = await _client.get('$_baseUrl/positions.json?markdown=true&page=${page}');
      } catch (e) {
        print('Failed to get jobs: $e');
        _jobs = [];
      }
    }

    var result = _handleResponse(response);
    print('RESULT_LENGTH: ${result}');
    if(result.length != 0) {
      result.forEach((job) {
        _jobs.add(job);
      });
      page = page +1;
    } else {
      _isMoreData = false;
    }
    _isLoading = false;
    notifyListeners();
  }


  void getJobs({String location}) async {

    if(!_isMoreData) {
      return ;
    }

    // _isLoading = true;
    // notifyListeners();
    Response response;

    if (location != null) {
      try {
        response = await _client.get('$_baseUrl/positions.json?markdown=true&location=${location}');
      } catch (e) {
        print('Failed to get jobs from location: $e');
        _jobs = [];
      }
    } else {
      try {
        response = await _client.get('$_baseUrl/positions.json?markdown=true&page=${page}');
      } catch (e) {
        print('Failed to get jobs: $e');
        _jobs = [];
      }
    }
    
    var result = _handleResponse(response);

    if(result.length != 0) {
      result.forEach((job) {
        _jobs.add(job);
      });
      page = page +1;
    } else {
      _isMoreData = false;
    }
    _isLoading = false;
    notifyListeners();
  }

  bool containItem(ScreenArguments arguments) {
    return _saved.contains(arguments);
  }

  bool findItemById(String id) {
    for(var item in _saved) {
      if(item.id == id) {
        return true;
      } 
    }
    return false;
  }

  void save(ScreenArguments arguments) {
    _saved.add(arguments);
    print(_saved);
    notifyListeners();
  }

  void remove(String id) {
    var newSaved;
    newSaved = _saved.where((item) => item.id != id).toList(); 
    _saved = newSaved;
    print(_saved);
    notifyListeners();
  }

  dynamic _handleResponse(Response response, {String error}) {
    if (response.statusCode == 200) {
      return json.decode(response.body);
    } else {
      throw error ?? 'Failed to get positions';
    }
  }
}

