import 'package:flutter/material.dart';
import 'package:weather/screens/loading_screen.dart';

void main() => runApp(WeatherApp());

class WeatherApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Weather',
      theme: ThemeData.dark(),
      home: LoadingScreen(),
    );
  }
}
