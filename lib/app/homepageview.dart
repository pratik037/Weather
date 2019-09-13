import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:intl/intl.dart';
import 'package:weather/app/weatherdata.dart';
import 'dart:core';

class HomePageView extends StatefulWidget {
  @override
  _HomePageViewState createState() => _HomePageViewState();
}

class _HomePageViewState extends State<HomePageView> {
  DateTime current = DateTime.now();
  final apiKey = "c65cfd1d349d708a4c1fba7633d23bed";
  List<String> months = [
    'JANUARY',
    'FEBRUARY',
    'MARCH',
    'APRIL',
    'MAY',
    'JUNE',
    'JULY',
    'AUGUST',
    'SEPTEMBER',
    'OCTOBER',
    'NOVEMBER',
    'DECEMBER'
  ];
  List<String> day = ['MON', 'TUE', 'WED', 'THU', 'FRI', 'SAT', 'SUN'];
  // String iconUrl = "http://openweathermap.org/img/w/03d.png";
  bool isLoading = false;

  @override
  void initState() {
    super.initState();
  }

  Future<WeatherData> getWeatherData() async {
    final response = await http.get(
      "http://api.openweathermap.org/data/2.5/weather?q=chennai&appid=${apiKey}&units=metric",
    );
    Map responseBody = json.decode(response.body);
    return WeatherData.fromJson(responseBody);
  }

  _parseEpoch(dateTime) {
    var time = dateTime.millisecondsSinceEpoch ~/ 1000;
    return time;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white24,
        elevation: 0,
        centerTitle: true,
        title: Text(
          "WEATHER",
          style: TextStyle(color: Colors.black, letterSpacing: 5, fontSize: 35),
        ),
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.refresh),
            color: Colors.black,
            onPressed: getWeatherData,
          )
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          children: <Widget>[
            //SVG Image
            Container(
              margin: EdgeInsets.all(0),
              padding: EdgeInsets.all(4),
              height: 350,
              child: SvgPicture.asset(
                'assets/images/weather2.svg',
                fit: BoxFit.contain,
              ),
            ),

            //Small Divider
            Container(
              color: Colors.grey[200],
              height: 3,
              width: MediaQuery.of(context).size.width * 0.20,
            ),

            //Async
            FutureBuilder<WeatherData>(
              future: getWeatherData(),
              builder: (BuildContext context, AsyncSnapshot snapshot) {
                if (snapshot.hasData) {
                  return Column(
                    children: <Widget>[
                      //City Name
                      Expanded(
                        flex: 1,
                        child: Container(
                          padding: EdgeInsets.all(16),
                          color: Colors.teal,
                          alignment: Alignment.center,
                          child: Text(
                            'CHENNAI, TAMIL NADU',
                            style: TextStyle(
                                fontSize: 25,
                                color: Colors.black,
                                letterSpacing: 2),
                            textAlign: TextAlign.left,
                          ),
                        ),
                      ),

                      //Temperature
                      Expanded(
                        flex: 1,
                        child: Container(
                          child: Text(
                            snapshot.data.temperature + "° C",
                            style: TextStyle(fontSize: 28),
                          ),
                        ),
                      ),

                      //Description
                      Expanded(
                        flex: 1,
                        child: Container(
                          child: Text(
                            toBeginningOfSentenceCase(
                                snapshot.data.description),
                            style: TextStyle(fontSize: 28),
                          ),
                        ),
                      ),

                      //Min and Max Temp
                      Expanded(
                        flex: 1,
                        child: Container(
                          child: Text(
                            "H " +
                                snapshot.data.maxTemp.toString() +
                                "° C " +
                                "/ L " +
                                snapshot.data.minTemp.toString() +
                                "° C",
                            style: TextStyle(fontSize: 28),
                          ),
                        ),
                      ),

                      //Humidity
                      Expanded(
                        flex: 1,
                        child: Container(
                          child: Text(
                            "Humidity " + snapshot.data.humidity + "%",
                            style: TextStyle(fontSize: 28),
                          ),
                        ),
                      ),

                      //Sunrise Time
                      Expanded(
                        flex: 1,
                        child: Container(
                          child: Text(
                            'Sunrise at ' +
                                DateFormat("hh:mm a").format(
                                    _parseEpoch(snapshot.data.sunriseTime)),
                            style: TextStyle(fontSize: 28),
                          ),
                        ),
                      ),

                      //Sunset Time
                      Expanded(
                        flex: 1,
                        child: Container(
                          child: Text(
                            'Sunset at ' +
                                DateFormat("hh:mm a").format(
                                    _parseEpoch(snapshot.data.sunsetTime)),
                            style: TextStyle(fontSize: 28),
                          ),
                        ),
                      ),

                      //WindSpeed
                      Expanded(
                        flex: 1,
                        child: Container(
                          child: Text(
                            snapshot.data.windSpeed.toStringAsFixed(2) +
                                " kmph",
                            style: TextStyle(fontSize: 25),
                          ),
                        ),
                      )
                    ],
                  );
                } else {
                  return Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.end,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: <Widget>[
                        Padding(
                          padding: const EdgeInsets.all(16.0),
                          child: SizedBox(
                            height: 50,
                            child: Text(
                              "LOADING",
                              style: TextStyle(fontSize: 25, letterSpacing: 3),
                            ),
                          ),
                        ),
                        Container(
                          alignment: Alignment.center,
                          width: MediaQuery.of(context).size.width * 0.80,
                          child: LinearProgressIndicator(),
                        ),
                      ],
                    ),
                  );
                }
              },
            ),

            //Prints the day, date and time
            Row(
              crossAxisAlignment: CrossAxisAlignment.end,
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Container(
                  padding: EdgeInsets.all(10),
                  margin: EdgeInsets.all(4),
                  color: Colors.yellow,
                  child: Text(
                    '${day[current.weekday - 1]} | ${months[current.month - 1]} ${current.day}, ${current.year} |  ${DateFormat("hh:mm a").format(current)}',
                    style: TextStyle(fontSize: 24, color: Colors.black38),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
