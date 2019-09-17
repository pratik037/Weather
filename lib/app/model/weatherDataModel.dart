import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:weather/app/weatherdata.dart';
import 'package:weather/apikey.dart' as apikey;

class WeatherDataModel extends ChangeNotifier {
  //To make singleton class
  static final WeatherDataModel _weatherDataModel =
      new WeatherDataModel._internal();

  factory WeatherDataModel() {
    return _weatherDataModel;
  }
  WeatherDataModel._internal();
  WeatherData _weather;
  // final apiKey = "<Insert your API Key here>";


  //To fetch the value from API
  Future getWeatherData({@required String city}) async {
    String searchCity = city.toLowerCase();
    final response = await http.get(
        "http://api.openweathermap.org/data/2.5/weather?q=$searchCity&appid=${apikey.apiKey}&units=metric");
    
    //Converting the response body from JSON to Map
    Map responseBody = json.decode(response.body);

    //Assigning the returned value to a WeatherData variable
    _weather = WeatherData.fromJson(responseBody);
  }
  String get cityName => _weather.name;

  String get weatherDescription => _weather.description;

  double get weatherWindSpeed => _weather.windSpeed;

  int get weatherSunriseTime => _weather.sunriseTime;

  int get weatherSunsetTime => _weather.sunsetTime;

  num get weatherTemperature => _weather.temperature;

  int get weatherHumidity => _weather.humidity;

  String get weatherIconLabel => _weather.iconLabel;

  num get weatherWindDirection => _weather.windDirection;
}
