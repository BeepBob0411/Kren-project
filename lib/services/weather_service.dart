// weather_service.dart
import 'dart:convert';
import 'package:geolocator/geolocator.dart';
import 'package:http/http.dart' as http;
import 'package:kren/models/weather_model.dart';
import 'package:geocoding/geocoding.dart';

class WeatherService {
  static const BASE_URL = 'https://api.openweathermap.org/data/2.5/weather';
  final String apiKey;

  WeatherService(this.apiKey);

  Future<WeatherModel> getWeatherByCityId(int cityId) async {
    final apiKey = 'c4829a7aa3b361a5740d769b7fda4438';
    final response = await http.get(Uri.parse('$BASE_URL?id=$cityId&appid=$apiKey&units=metric'));
    print('API Response : ${response.body}');

    if (response.statusCode == 200) {
      WeatherModel weather = WeatherModel.fromJson(jsonDecode(response.body));
      return weather;
    } else {
      throw Exception('Failed to load weather data');
    }
  }

  Future<WeatherModel> getWeatherForUserLocation(String cityName) async {
    LocationPermission permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
    }

    Position position = await Geolocator.getCurrentPosition(
      desiredAccuracy: LocationAccuracy.high,
    );

    final apiKey = 'c4829a7aa3b361a5740d769b7fda4438';
    final response = await http.get(Uri.parse('$BASE_URL?lat=${position.latitude}&lon=${position.longitude}&appid=$apiKey&units=metric'));
    print('API Response : ${response.body}');

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
