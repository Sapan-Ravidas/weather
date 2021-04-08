import 'package:flutter/material.dart';
import 'package:weather/server/weather.dart';
import 'package:weather/utilities/constants.dart';
import 'package:intl/intl.dart';
import 'package:weather/utilities/get_future_weather.dart';
import 'package:flutter_progress_hud/flutter_progress_hud.dart';
import 'package:weather/screens/network_error.dart';

class WeatherInfo extends StatefulWidget {
  final String cityName;
  final dynamic weatherData;
  final String cityID;
  WeatherInfo({this.cityName, this.cityID, this.weatherData});

  @override
  _WeatherInfoState createState() => _WeatherInfoState();
}

class _WeatherInfoState extends State<WeatherInfo> {
  String locationCity = '';
  String condition = '';
  String weatherIconAbbr;
  String weatherIcon;
  String backgroundImage = 'clear';

  int temperature = 0;
  int minTemperature = 0;
  int maxTemperature = 0;
  String cityLocationID = '44418';

  List<int> minFutureTemperatures = List<int>.filled(7, 0);
  List<int> maxFuturetemperatures = List<int>.filled(7, 0);
  List<String> iconAbbreationList = List<String>.filled(7, 'lc');

  // Update UI function-> will update location, temperature, min-temprature,
  // max-temperature, weather condition, background image

  void updateUI(String location, String id, dynamic weatherData) {
    setState(() {
      locationCity = location;
      cityLocationID = id;
      double temp = weatherData['the_temp'];

      temperature = temp.toInt();
      condition = weatherData['weather_state_name'];
      weatherIconAbbr = weatherData['weather_state_abbr'];

      double minTemp = weatherData['min_temp'];
      double maxTemp = weatherData['max_temp'];
      minTemperature = minTemp.toInt();
      maxTemperature = maxTemp.toInt();

      backgroundImage =
          weatherData['weather_state_name'].replaceAll(' ', '').toLowerCase();
    });
  }

  // it will update ui for weather condition of the next 7 days

  void fetchFutureWeather(int i) async {
    var today = DateTime.now();
    WeatherModel weatherModel = WeatherModel();

    var date =
        DateFormat('y/M/d').format(today.add(Duration(days: i + 1))).toString();
    var result = await weatherModel.getLocationWeatherByLocationIdAndDate(
        cityLocationID, date);

    setState(() {
      minFutureTemperatures[i] = result['min_temp'].round();
      maxFuturetemperatures[i] = result['max_temp'].round();
      iconAbbreationList[i] = result['weather_state_abbr'];
    });
  }

  // when user input a city name

  void onUserInputLocation(String value) async {
    WeatherModel weatherModel = WeatherModel();
    var locationData = await weatherModel.getWeatherByLocationName(value);

    String woeid = locationData['woeid'].toString();

    var data = await weatherModel.getLocationWeather(woeid);
    if (data == null) {
      Navigator.push(context, MaterialPageRoute(builder: (context) {
        return ErrorScreen();
      }));
    }

    if (data != null) {
      for (int i = 0; i < 7; i++) {
        fetchFutureWeather(i);
      }
      updateUI(value, woeid, data);
    }
  }

  @override
  void initState() {
    super.initState();
    for (int i = 0; i < 7; i++) {
      fetchFutureWeather(i);
    }

    updateUI(widget.cityName, widget.cityID, widget.weatherData);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.transparent,
      resizeToAvoidBottomInset: false,
      body: ProgressHUD(
        child: Builder(
          builder: (context) => Container(
            decoration: BoxDecoration(
              image: DecorationImage(
                image: AssetImage('images/$backgroundImage.jpeg'),
                fit: BoxFit.cover,
                alignment: Alignment.center,
                colorFilter: ColorFilter.mode(
                    Colors.black.withOpacity(0.6), BlendMode.dstATop),
              ),
            ),
            child: SafeArea(
              child: Container(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: <Widget>[
                    // search area for location
                    Container(
                      padding: EdgeInsets.symmetric(
                          horizontal: 30.0, vertical: 10.0),
                      child: TextField(
                        style: TextStyle(color: Colors.white),
                        decoration: kTextFieldInputDecoration,
                        onSubmitted: (String value) {
                          final progress = ProgressHUD.of(context);
                          progress?.show();
                          onUserInputLocation(value.toLowerCase());
                          progress?.dismiss();
                        },
                      ),
                    ),

                    // location text
                    Expanded(
                      child: Padding(
                        padding: EdgeInsets.symmetric(vertical: 30.0),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: <Widget>[
                            Center(
                              child: Image.network(
                                kWeatherIconUrl + weatherIconAbbr + '.png',
                                width: 100.0,
                              ),
                            ),
                            Text(
                              locationCity,
                              style: TextStyle(
                                  color: Colors.white, fontSize: 40.0),
                              textAlign: TextAlign.center,
                            ),
                            Text(
                              '$minTemperature °C - $maxTemperature °C',
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 20.0,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),

                    // temperature
                    Padding(
                      padding:
                          EdgeInsets.only(left: 20.0, right: 20.0, top: 15.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        textBaseline: TextBaseline.alphabetic,
                        children: <Widget>[
                          Text(
                            '$temperature °C',
                            style: kTemperatureTextStyle,
                            textAlign: TextAlign.left,
                          ),
                          Expanded(
                              child: Text(
                            condition.toUpperCase(),
                            style: kConditionTextStyle,
                            textAlign: TextAlign.end,
                          ))
                        ],
                      ),
                    ),

                    SingleChildScrollView(
                      scrollDirection: Axis.horizontal,
                      child: Padding(
                        padding: EdgeInsets.only(top: 10.0, bottom: 40.0),
                        child: Row(
                          children: <Widget>[
                            for (int i = 0; i < 7; i++)
                              getFutureWeather(
                                dayFrom: i + 1,
                                iconAbbriviation: iconAbbreationList[i],
                                minTemp: minFutureTemperatures[i],
                                maxTemp: maxFuturetemperatures[i],
                              ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
