import 'dart:convert';
import 'package:geolocator/geolocator.dart';
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

  Future<String> getUserCityName() async {
    print('getting user position');
    String cityName = '';
    Position position = await Geolocator()
        .getCurrentPosition(desiredAccuracy: LocationAccuracy.high);

    if (position != null) {
      List<Placemark> results = await Geolocator()
          .placemarkFromCoordinates(position.latitude, position.longitude)
          .catchError((e, stacktrace) {
        print(e);
        print(stacktrace);
      });

      if (results != null && results.length > 0) {
        Placemark placemark = results[0];
        cityName = placemark.subAdministrativeArea;
      }
    }

    return cityName;
  }

  //To fetch the value from API
  Future getWeatherData({@required String city}) async {
    print('getting weather data');
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
