import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:weatherappdemo/constants/secrets.dart';
import 'package:weatherappdemo/models/weatheresponsemodel.dart';
import 'package:http/http.dart' as http;

class WeatherServiceProvider extends ChangeNotifier {
  WeatherResponseModel? _weather;

  WeatherResponseModel? get weather => _weather; // getter
  bool _isLoading = false;
  bool get isLoading => _isLoading; // getter

  String _error = '';
  String get error => _error; //getter

  Future<void> fetchWeatherData(String cityName) async {
    _isLoading = true;
    _error = "";
    try {
      final apiUrl =
          "${Secrets.openWeatherBaseUrl}${cityName}&appid=${Secrets.OpenWeatherKey}${Secrets.uint}";

      final response = await http.get(Uri.parse(apiUrl));

      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        print(data);

        _weather = WeatherResponseModel.fromJson(data);
        notifyListeners();
      } else {
        _error = "Failed to load data";
      }
    } catch (e) {
      _error = "An error Occured $e";
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }
}
