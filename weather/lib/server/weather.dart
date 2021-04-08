import 'package:weather/server/location.dart';
import 'package:weather/server/network.dart';
import 'package:weather/utilities/constants.dart';

class WeatherModel {
  String latitude = '';
  String longitude = '';

  Future<dynamic> getCurrentGeoLocationData() async {
    Location location = Location();
    await location.getCurrentGeoLocation();

    try {
      NetworkModel networkModel = NetworkModel(
          url:
              '$kLocationApiUrl/search/?lattlong=${location.latitude},${location.longitude}');
      var locationData = await networkModel.getGeoLocationData();

      return locationData[0];
    } catch (error) {
      print(error);
    }
  }

  Future<dynamic> getLocationWeather(String woeid) async {
    try {
      NetworkModel networkModel = NetworkModel(url: '$kLocationApiUrl/$woeid/');

      var weatherData = await networkModel.getGeoLocationData();

      var data = weatherData['consolidated_weather'];

      return data[0];
    } catch (error) {
      print(error);
    }
  }

  Future<dynamic> getLocationWeatherByLocationIdAndDate(
      String woeid, String date) async {
    try {
      NetworkModel networkModel =
          NetworkModel(url: '$kLocationApiUrl/$woeid/$date');
      var result = await networkModel.getGeoLocationData();

      return result[0];
    } catch (error) {
      print(error);
    }
  }

  Future<dynamic> getWeatherByLocationName(String value) async {
    try {
      NetworkModel networkModel =
          NetworkModel(url: '$kLocationApiUrl/search/?query=$value');

      var result = await networkModel.getGeoLocationData();
      print(result);
      return result[0];
    } catch (error) {
      print(error);
    }
  }
}
