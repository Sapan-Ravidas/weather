import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

const kLocationApiUrl = 'https://www.metaweather.com/api/location';

const kWeatherIconUrl = 'https://www.metaweather.com/static/img/weather/png/';

const kTextFieldInputDecoration = InputDecoration(
  filled: true,
  prefixIcon: Icon(
    Icons.location_city,
    color: Colors.white,
  ),
  hintText: 'Enter city name',
  hintStyle: TextStyle(color: Colors.white, fontSize: 18.00),
  border: OutlineInputBorder(
    borderRadius: BorderRadius.all(
      Radius.circular(10.0),
    ),
    borderSide: BorderSide.none,
  ),
  suffixIcon: Icon(
    FontAwesomeIcons.search,
    color: Colors.white,
  ),
);

const kTemperatureTextStyle = TextStyle(color: Colors.white, fontSize: 100.0);

const kConditionTextStyle = TextStyle(color: Colors.white, fontSize: 30.0);
