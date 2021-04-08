import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:weather/screens/weather_info.dart';
import 'package:weather/server/weather.dart';
import 'package:weather/screens/network_error.dart';

class LoadingScreen extends StatefulWidget {
  @override
  _LoadingScreenState createState() => _LoadingScreenState();
}

class _LoadingScreenState extends State<LoadingScreen> {
  String cityID = '';
  String cityName = '';

  void getCurrentWeatherData() async {
    WeatherModel weatherModel = WeatherModel();

    var locationdata = await weatherModel.getCurrentGeoLocationData();
    if (locationdata == null) {
      Navigator.push(context, MaterialPageRoute(builder: (context) {
        return ErrorScreen();
      }));
    }
    cityID = locationdata['woeid'].toString();
    cityName = locationdata['title'];

    var weatherData = await weatherModel.getLocationWeather(cityID);

    if (weatherData == null) {
      Navigator.push(context, MaterialPageRoute(builder: (context) {
        return ErrorScreen();
      }));
    }

    Navigator.push(context, MaterialPageRoute(builder: (context) {
      return WeatherInfo(
          cityName: cityName, cityID: cityID, weatherData: weatherData);
    }));
  }

  @override
  void initState() {
    super.initState();
    getCurrentWeatherData();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: SpinKitDoubleBounce(
          color: Colors.white,
        ),
      ),
    );
  }
}
