import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:intl/intl.dart';
import 'package:weather/app/model/weatherDataModel.dart';
import 'dart:core';
import 'package:weather/app/widgets/dateTime.dart';
import 'package:weather/app/widgets/loader.dart';
import 'package:weather_icons/weather_icons.dart';

class HomePageView extends StatefulWidget {
  final WeatherDataModel weatherDataModel;

  const HomePageView({Key key, this.weatherDataModel}) : super(key: key);
  @override
  _HomePageViewState createState() => _HomePageViewState();
}

class _HomePageViewState extends State<HomePageView> {
  WeatherDataModel weatherDataModel;
  bool isLoading = false;

  @override
  void initState() {
    weatherDataModel = this.widget.weatherDataModel;
    super.initState();
    Future.delayed(Duration(milliseconds: 100)).whenComplete(() {
      _getWeather();
    });
  }

  void _getWeather() async {
    setState(() {
      isLoading = true;
    });
    await weatherDataModel.getWeatherData();
    setState(() {
      isLoading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.indigoAccent[100],
      appBar: AppBar(
        backgroundColor: Colors.indigoAccent[100],
        elevation: 0,
        centerTitle: true,
        title: Text(
          "WEATHER",
          style: TextStyle(color: Colors.white, letterSpacing: 5, fontSize: 35),
        ),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: <Widget>[
          //SVG Image
          Container(
            margin: EdgeInsets.all(5),
            padding: EdgeInsets.all(2),
            height: MediaQuery.of(context).size.height * 0.35,
            // alignment: Alignment.center,
            child: SvgPicture.asset('assets/images/weather2.svg',
                fit: BoxFit.fitWidth),
          ),

          //Small Divider
          Container(
            color: Colors.grey[300],
            margin: EdgeInsets.all(2),
            height: 3,
            width: MediaQuery.of(context).size.width * 0.20,
          ),
          isLoading
              ? Loader()
              : Column(
                  children: <Widget>[
                    //City Heading
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text(
                        "CHENNAI, TAMIL NADU",
                        style: TextStyle(fontSize: 35, color: Colors.white),
                      ),
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: <Widget>[
                        Expanded(
                          flex: 1,
                          child: Container(
                            margin: EdgeInsets.all(8),
                            height: MediaQuery.of(context).size.height * 0.20,
                            width: MediaQuery.of(context).size.width * 0.30,
                            padding: EdgeInsets.all(8),
                            alignment: Alignment.centerLeft,
                            decoration: BoxDecoration(
                                image: DecorationImage(
                                    fit: BoxFit.cover,
                                    image: NetworkImage(
                                        'http://openweathermap.org/img/wn/${weatherDataModel.weatherIconLabel}@2x.png'))),
                          ),
                        ),
                        Expanded(
                          flex: 2,
                          child: Container(
                            padding: EdgeInsets.all(8),
                            height: MediaQuery.of(context).size.height * 0.20,
                            alignment: Alignment.center,
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: <Widget>[
                                Row(
                                  children: <Widget>[
                                    BoxedIcon(
                                      WeatherIcons.day_sunny_overcast,
                                      color: Colors.black45,
                                    ),
                                    Text(
                                      toBeginningOfSentenceCase(
                                          weatherDataModel.weatherDescription),
                                      style: TextStyle(
                                          color: Colors.white, fontSize: 25),
                                    ),
                                  ],
                                ),
                                Row(
                                  children: <Widget>[
                                    BoxedIcon(
                                      WeatherIcons.thermometer,
                                      color: Colors.black45,
                                    ),
                                    Text(
                                      "Temperature: " +
                                          weatherDataModel.weatherTemperature
                                              .toString() +
                                          "° C",
                                      style: TextStyle(
                                          color: Colors.white, fontSize: 25),
                                    ),
                                  ],
                                ),
                                Row(
                                  children: <Widget>[
                                    BoxedIcon(
                                      WeatherIcons.humidity,
                                      color: Colors.black45,
                                    ),
                                    Text(
                                      "Humidity: " +
                                          weatherDataModel.weatherHumidity
                                              .toString() +
                                          "% hPa",
                                      style: TextStyle(
                                          color: Colors.white, fontSize: 25),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: <Widget>[
                        Expanded(
                          flex: 2,
                          child: Container(
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: <Widget>[
                                BoxedIcon(
                                  WeatherIcons.sunrise,
                                  color: Colors.yellow,
                                ),
                                SizedBox(
                                  width: 15,
                                ),
                                Text(
                                  DateFormat("hh:mm a").format(
                                      DateTime.fromMillisecondsSinceEpoch(
                                          weatherDataModel.weatherSunriseTime ~/
                                              1000)),
                                  style: TextStyle(
                                      fontSize: 20, color: Colors.white),
                                )
                              ],
                            ),
                          ),
                        ),
                        Container(
                          color: Colors.grey[300],
                          margin: EdgeInsets.all(2),
                          height: MediaQuery.of(context).size.height * 0.04,
                          width: 3,
                        ),
                        Expanded(
                          flex: 2,
                          child: Container(
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: <Widget>[
                                BoxedIcon(
                                  WeatherIcons.sunset,
                                  color: Colors.deepOrange,
                                ),
                                SizedBox(
                                  width: 15,
                                ),
                                Text(
                                  DateFormat("hh:mm a").format(
                                      DateTime.fromMillisecondsSinceEpoch(
                                          weatherDataModel.weatherSunsetTime ~/
                                              1000)),
                                  style: TextStyle(
                                      fontSize: 20, color: Colors.white),
                                )
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
          DateTimeBar()
        ],
      ),
    );
  }
}
