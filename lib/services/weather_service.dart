// weather_service.dart
import 'dart:convert';
import 'package:geolocator/geolocator.dart';
import 'package:http/http.dart' as http;
import 'package:kren/models/weather_model.dart';
import 'package:geocoding/geocoding.dart';

class WeatherService {
  static const String _baseUrl = 'https://api.openweathermap.org/data/2.5/weather';
  static const String _forecastUrl = 'https://api.openweathermap.org/data/2.5/forecast';

  final String apiKey;

  WeatherService(this.apiKey);

  Future<List<WeatherModel>> getForecastForUserLocation() async {
    try {
      LocationPermission permission = await Geolocator.checkPermission();
      if (permission == LocationPermission.denied) {
        permission = await Geolocator.requestPermission();
      }

      Position position = await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.high,
      );

      final response = await http.get(Uri.parse(
          '$_forecastUrl?lat=${position.latitude}&lon=${position.longitude}&appid=$apiKey&units=metric'));

      print('Forecast API Response: ${response.statusCode}');
      print('Forecast API Body: ${response.body}');

      if (response.statusCode == 200) {
        List<dynamic> forecastData = jsonDecode(response.body)['list'];
        List<WeatherModel> forecastList = forecastData
            .map((data) => WeatherModel.fromForecastJson(data))
            .toList();
        return forecastList;
      } else {
        print('Error fetching forecast data: ${response.statusCode}');
        throw Exception('Failed to load forecast data');
      }
    } catch (e) {
      print('Error fetching forecast data: $e');
      throw Exception('Failed to load forecast data');
    }
  }

  Future<WeatherModel> getWeatherForUserLocation({required String cityName}) async {
    LocationPermission permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
    }

    Position position = await Geolocator.getCurrentPosition(
      desiredAccuracy: LocationAccuracy.high,
    );

    final response = await http.get(Uri.parse(
        '$_baseUrl?lat=${position.latitude}&lon=${position.longitude}&appid=$apiKey&units=metric'));
    print('API Response: ${response.body}');

    if (response.statusCode == 200) {
      WeatherModel weather = WeatherModel.fromJson(jsonDecode(response.body));
      return weather;
    } else {
      throw Exception('Failed to load weather data');
    }
  }

  Future<String> getCurrentCity() async {
    LocationPermission permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
    }

    Position position = await Geolocator.getCurrentPosition(
      desiredAccuracy: LocationAccuracy.high,
    );

    List<Placemark> placemarks = await placemarkFromCoordinates(position.latitude, position.longitude);

    if (placemarks.isNotEmpty) {
      String county = placemarks[0].subAdministrativeArea ?? "";
      String district = placemarks[0].administrativeArea ?? "";

      return "$district, $county";
    } else {
      return "";
    }
  }
}
