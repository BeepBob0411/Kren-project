import 'package:flutter/material.dart';
import 'package:kren/services/weather_service.dart';
import 'package:kren/models/weather_model.dart';
import 'package:lottie/lottie.dart';

class Screen2 extends StatefulWidget {
  const Screen2({Key? key}) : super(key: key);

  @override
  State<Screen2> createState() => _Screen2State();
}

class _Screen2State extends State<Screen2> {
  final _weatherService = WeatherService('c4829a7aa3b361a5740d769b7fda4438');
  WeatherModel? _weather;

  @override
  void initState() {
    super.initState();
    _fetchWeather();
  }

  _fetchWeather() async {
    try {
      final cityName = await _weatherService.getCurrentCity();
      final weather = await _weatherService.getWeatherForUserLocation(cityName);
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
        return 'assets/animation/rain.json';
      case 'drizzle':
      case 'shower rain':
        return 'assets/animation/rain.json';
      case 'thunderstorm':
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
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                _weather != null
                    ? '${_weather?.cityName ?? ""}, ${_weather?.county ?? ""}, ${_weather?.district ?? ""}'
                    : 'Loading location...',
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                ),
              ),

              SizedBox(height: 20),

              Expanded(
                child: Lottie.asset(getWeatherAnimation(_weather?.mainCondition)),
              ),

              SizedBox(height: 20),

              Text(
                _weather != null
                    ? '${_weather?.temperature.round()}°C'
                    : 'Loading temperature...',
                style: TextStyle(
                  fontSize: 34,
                  fontWeight: FontWeight.bold,
                ),
              ),

              SizedBox(height: 20),

              Text(
                _weather != null
                    ? '${_weather?.mainCondition ?? ""}'
                    : 'Loading condition...',
                style: TextStyle(
                  fontSize: 18,
                  color: Colors.grey[700],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
