import 'package:flutter/material.dart';
import 'package:weather/app/homepageview.dart';

void main() => runApp(Weather());


class Weather extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Weather',
      home: HomePageView(),
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.teal
      ),

      
    );
  }
}