// screen2.dart
import 'package:flutter/material.dart';
import 'package:kren/services/weather_service.dart';
import 'package:kren/models/weather_model.dart';
import 'package:lottie/lottie.dart'; // Import Weather model

class Screen2 extends StatefulWidget {
  const Screen2({Key? key}) : super(key: key);

  @override
  State<Screen2> createState() => _Screen2State();
}

class _Screen2State extends State<Screen2> {
  final _weatherService = WeatherService('c4829a7aa3b361a5740d769b7fda4438');
  WeatherModel? _weather; // Use WeatherModel instead of Weather

  @override
  void initState() {
    super.initState();
    _fetchWeather();
  }

  _fetchWeather() async {
    String cityName = await _weatherService.getCurrentCity();
    print('City Name: Balige');

    try {
      final weather = await _weatherService.getWeather(cityName);
      setState(() {
        _weather = weather;
      });
    } catch (e) {
      print(e);
    }
  }

  String getWeatherAnimation(String? mainCondition) {
    if (mainCondition == null) return 'assets/animation/sunny.json';

    switch (mainCondition.toLowerCase()) {
      case 'clouds':
      case 'mist':
      case 'smoke':
      case 'haze':
      case 'dust':
      case 'fog':
        return 'assets/animation/cloud.json';
      case 'rain':
      case 'drizzle':
      case 'shower rain':
        return 'assets/animation/rain.json';
      case 'thunderstrom':
        return 'assets/animation/thunder.json';
      case 'clear':
        return 'assets/animation/sunny.json';
      default:
        return 'assets/animation/sunny.json';
    }
  }


  @override
  Widget build(BuildContext context) {
    print(_weather?.temperature);
    return Scaffold(
      body: Center(
        child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(_weather?.cityName ?? "Loading city..."),

          Lottie.asset(getWeatherAnimation(_weather?.mainCondition)),
          // Use the getWeatherAnimation method

          Text('${_weather?.temperature.round()}°C'),

          Text('${_weather?.mainCondition ?? ""}'),
          // Add a closing quote

        ],
      ),
      ),
    );
  }
}
