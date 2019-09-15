import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:weather/app/homepageview.dart';
import 'package:weather/app/model/weatherDataModel.dart';

void main() => runApp(Weather());

class Weather extends StatefulWidget {
  @override
  _WeatherState createState() => _WeatherState();
}

class _WeatherState extends State<Weather> {
  WeatherDataModel _weatherDataModel;
  @override
  void initState() {
    _weatherDataModel = WeatherDataModel();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider<WeatherDataModel>(
          builder: (BuildContext context) {
            return _weatherDataModel;
          },
        )
      ],
      child: MaterialApp(
        title: 'Weather',
        home: HomePageView(weatherDataModel: _weatherDataModel,),
        debugShowCheckedModeBanner: false,
        theme: ThemeData(primarySwatch: Colors.teal),
      ),
    );
  }
}
