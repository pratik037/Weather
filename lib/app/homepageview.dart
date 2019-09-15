import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:intl/intl.dart';
import 'package:weather/app/model/weatherDataModel.dart';
import 'dart:core';
import 'package:weather/app/widgets/dateTime.dart';
import 'package:weather/app/widgets/loader.dart';
import 'package:weather_icons/weather_icons.dart';
import 'package:auto_size_text/auto_size_text.dart';

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
        actions: <Widget>[
          IconButton(
            icon: Icon(
              Icons.refresh,
              color: Colors.black,
            ),
            onPressed: _getWeather,
          )
        ],
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: <Widget>[
          //Top SVG Image
          Container(
            margin: EdgeInsets.all(5),
            padding: EdgeInsets.all(2),
            height: MediaQuery.of(context).size.height * 0.35,
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

          //Asynchronous Code Begins.
          isLoading
              ? Loader()
              : Column(
                  children: <Widget>[
                    //City Heading
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text(
                        "Chennai, TN",
                        style: TextStyle(fontSize: 35, color: Colors.white),
                      ),
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: <Widget>[
                        Expanded(
                          flex: 1,
                          // child: Container(
                            // color: Colors.yellow,
                            child: Column(
                              children: <Widget>[
                                Container(
                                  // margin: EdgeInsets.all(2),
                                  height:
                                      MediaQuery.of(context).size.height * 0.10,
                                  width:
                                      MediaQuery.of(context).size.width * 0.25,
                                  padding: EdgeInsets.all(8),
                                  
                                  decoration: BoxDecoration(
                                      // color: Colors.red,
                                      image: DecorationImage(
                                          fit: BoxFit.cover,
                                          image: NetworkImage(
                                              'http://openweathermap.org/img/wn/${weatherDataModel.weatherIconLabel}@2x.png'))),
                                ),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: <Widget>[
                                    WindIcon(
                                      degree:
                                          weatherDataModel.weatherWindDirection,
                                      color: Colors.white,
                                      size: 30,
                                    ),
                                    AutoSizeText(
                                      weatherDataModel.weatherWindSpeed
                                              .toStringAsFixed(0) +
                                          " kmph",
                                      style: TextStyle(
                                          fontSize: 20, color: Colors.white),
                                    )
                                  ],
                                )
                              ],
                            ),
                          // ),
                        ),

                        //Right side column
                        Expanded(
                          flex: 2,
                          child: Container(
                            
                            margin: EdgeInsets.all(4),
                            padding: EdgeInsets.all(4),
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
                                    AutoSizeText(
                                      toBeginningOfSentenceCase(
                                          weatherDataModel.weatherDescription),
                                      style: TextStyle(color: Colors.white),
                                      maxLines: 1,
                                      minFontSize: 18,
                                      maxFontSize: 25,
                                    ),
                                  ],
                                ),
                                Row(
                                  children: <Widget>[
                                    BoxedIcon(
                                      WeatherIcons.thermometer,
                                      color: Colors.black45,
                                    ),
                                    AutoSizeText(
                                      "Temperature: " +
                                          weatherDataModel.weatherTemperature
                                              .toString() +
                                          "° C",
                                      style: TextStyle(
                                          color: Colors.white, fontSize: 25),
                                      maxLines: 1,
                                      maxFontSize: 25,
                                      minFontSize: 18,
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

                        //Sunrise Time
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
                                  //weatherDataModel.weatherSunriseTime.toString(),
                                  DateFormat("hh:mm a").format(
                                      DateTime.fromMillisecondsSinceEpoch(
                                          weatherDataModel.weatherSunriseTime *
                                              1000)),
                                  style: TextStyle(
                                      fontSize: 20, color: Colors.white),
                                )
                              ],
                            ),
                          ),
                        ),
                        //Divider between the times
                        Container(
                          color: Colors.grey[300],
                          margin: EdgeInsets.all(2),
                          height: MediaQuery.of(context).size.height * 0.04,
                          width: 3,
                        ),

                        //Sunset time
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
                                  //weatherDataModel.weatherSunsetTime.toString(),
                                  DateFormat("hh:mm a").format(
                                      DateTime.fromMillisecondsSinceEpoch(
                                          weatherDataModel.weatherSunsetTime *
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
