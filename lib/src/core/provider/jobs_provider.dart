import 'package:flutter/material.dart';
import 'package:http/http.dart';
import 'dart:convert';

class JobsProvider extends ChangeNotifier {
  final _client = Client();
  final _baseUrl = 'https://jobs.github.com';

  int page = 0;

  bool _isLoading = false;

  get isLoading => _isLoading;
  get jobs => _jobs;

  List<dynamic> _jobs = [];

  void getJobs({String location}) async {
    // _isLoading = true;
    // notifyListeners();
    Response response;

    if (location != null) {
      try {
        response = await _client.get('$_baseUrl/positions.json?location=${location}');
      } catch (e) {
        print('Failed to get jobs from location: $e');
        _jobs = [];
      }
    } else {
      try {
        response = await _client.get('$_baseUrl/positions.json');
      } catch (e) {
        print('Failed to get jobs: $e');
        _jobs = [];
      }
    }

    _handleResponse(response).forEach((job) {
      _jobs.add(job);
    });
    // _isLoading = false;
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
