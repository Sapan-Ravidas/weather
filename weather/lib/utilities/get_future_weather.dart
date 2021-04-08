import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:weather/utilities/constants.dart';

Widget getFutureWeather(
    {int dayFrom, String iconAbbriviation, int minTemp, int maxTemp}) {
  var nextDays = DateTime.now().add(Duration(days: dayFrom));
  return Padding(
    padding: EdgeInsets.only(left: 15.0),
    child: Container(
      decoration: BoxDecoration(
        color: Color.fromRGBO(205, 212, 2228, 0.2),
        borderRadius: BorderRadius.circular(10.0),
      ),
      child: Padding(
        padding: EdgeInsets.all(15.0),
        child: Column(
          children: <Widget>[
            Text(
              DateFormat.E().format(nextDays),
              style: TextStyle(color: Colors.white, fontSize: 20.0),
            ),
            Padding(
              padding: EdgeInsets.symmetric(vertical: 15.0),
              child: Image.network(
                kWeatherIconUrl + iconAbbriviation + '.png',
                width: 50.0,
              ),
            ),
            Text(
              '$minTemp °C - $maxTemp °C',
              style: TextStyle(
                color: Colors.white,
                fontSize: 20.0,
              ),
            )
          ],
        ),
      ),
    ),
  );
}
