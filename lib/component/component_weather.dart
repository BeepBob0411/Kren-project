// component_weather.dart
import 'package:flutter/material.dart';
import 'package:flutter_neumorphic/flutter_neumorphic.dart';
import 'package:lottie/lottie.dart';
import 'package:kren/models/weather_model.dart';

class WeatherInfo extends StatelessWidget {
  final IconData icon;
  final String label;
  final String value;

  WeatherInfo({
    required this.icon,
    required this.label,
    required this.value,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Icon(
          icon,
          color: Colors.black,
          size: 18,
        ),
        SizedBox(width: 5),
        NeumorphicText(
          value,
          style: NeumorphicStyle(
            depth: 8,
            intensity: 0.8,
            color: Colors.black,
          ),
          textStyle: NeumorphicTextStyle(
            fontSize: 18,
          ),
        ),
      ],
    );
  }
}

class WeatherForecastCard extends StatelessWidget {
  final WeatherModel forecast;
  final VoidCallback? onTap;
  final bool isExpanded;
  final Color backgroundColor; // Add this line

  WeatherForecastCard({
    required this.forecast,
    this.onTap,
    this.isExpanded = false,
    required this.backgroundColor, // Add this line
  });

  String getWeatherAnimation({String? mainCondition}) {
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
    return Neumorphic(
      style: NeumorphicStyle(
        depth: 8,
        intensity: 0.8,
        boxShape: NeumorphicBoxShape.roundRect(BorderRadius.circular(10)),
        color: backgroundColor, // Add this line
      ),
      child: Padding(
        padding: const EdgeInsets.all(12.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            NeumorphicText(
              '${forecast.dateTime.hour}:00',
              style: NeumorphicStyle(
                depth: 8,
                intensity: 0.8,
                color: Colors.black,
              ),
              textStyle: NeumorphicTextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: 5),
            NeumorphicText(
              '${forecast.temperature.round()}°C, ${forecast.mainCondition}, ${forecast.windSpeed} m/s Wind',
              style: NeumorphicStyle(
                depth: 8,
                intensity: 0.8,
                color: Colors.black,
              ),
              textStyle: NeumorphicTextStyle(
                fontSize: 14,
              ),
            ),
            SizedBox(height: 10),
            Lottie.asset(
              getWeatherAnimation(mainCondition: forecast.mainCondition),
              height: 50,
            ),
            SizedBox(height: 10),
          ],
        ),
      ),
    );
  }
}
