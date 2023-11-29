import 'package:flutter/material.dart';

class WeatherModel {
  final String cityName;
  final double temperature;
  final String mainCondition;
  final String county;
  final String district;
  final double windSpeed;
  final DateTime dateTime;

  WeatherModel({
    required this.cityName,
    required this.temperature,
    required this.mainCondition,
    required this.county,
    required this.district,
    required this.windSpeed,
    required this.dateTime,
  });

  factory WeatherModel.fromJson(Map<String, dynamic> json) {
    try {
      return WeatherModel(
        cityName: json['name'] ?? "",
        temperature: (json['main']['temp'] as num?)?.toDouble() ?? 0.0,
        mainCondition: json['weather'][0]['main'] ?? "",
        county: json['name'] ?? "",
        district: json['name'] ?? "",
        windSpeed: (json['wind']['speed'] as num?)?.toDouble() ?? 0.0,
        dateTime: DateTime.now(),
      );
    } catch (e) {
      print('Error parsing weather data: $e');
      throw Exception('Failed to parse weather data');
    }
  }

  factory WeatherModel.fromForecastJson(Map<String, dynamic> json) {
    try {
      return WeatherModel(
        cityName: json['name'] ?? "",
        temperature: (json['main']['temp'] as num?)?.toDouble() ?? 0.0,
        mainCondition: json['weather'][0]['main'] ?? "",
        county: json['name'] ?? "",
        district: json['name'] ?? "",
        windSpeed: (json['wind']['speed'] as num?)?.toDouble() ?? 0.0,
        dateTime: DateTime.fromMillisecondsSinceEpoch(
          json['dt'] * 1000,
          isUtc: false,
        ),
      );
    } catch (e) {
      print('Error parsing forecast data: $e');
      throw Exception('Failed to parse forecast data');
    }
  }
}

class WeatherForecast extends StatelessWidget {
  final List<WeatherModel> weatherData;

  WeatherForecast({required this.weatherData});

  Map<String, List<WeatherModel>> groupWeatherByDay() {
    Map<String, List<WeatherModel>> groupedForecast = {};

    for (var forecastItem in weatherData) {
      // Extracting day from DateTime and using it as a key
      String day = forecastItem.dateTime.toLocal().toIso8601String().split('T')[0];

      if (!groupedForecast.containsKey(day)) {
        groupedForecast[day] = [];
      }

      groupedForecast[day]!.add(forecastItem);
    }

    return groupedForecast;
  }

  @override
  Widget build(BuildContext context) {
    Map<String, List<WeatherModel>> groupedForecast = groupWeatherByDay();

    return Scaffold(
      appBar: AppBar(
        title: Text('Weather Forecast'),
      ),
      body: ListView.builder(
        itemCount: groupedForecast.length,
        itemBuilder: (context, index) {
          String day = groupedForecast.keys.elementAt(index);
          List<WeatherModel> dayForecast = groupedForecast[day]!;

          return Card(
            margin: EdgeInsets.all(8.0),
            child: Padding(
              padding: EdgeInsets.all(8.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    day,
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 18.0,
                    ),
                  ),
                  for (var forecastItem in dayForecast)
                    ListTile(
                      title: Text(forecastItem.mainCondition),
                      subtitle: Text(
                        '${forecastItem.temperature}°C, ${forecastItem.windSpeed} m/s',
                      ),
                    ),
                  Divider(),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}

void main() {
  // Example usage
  List<WeatherModel> weatherData = [
    WeatherModel(
      cityName: 'City 1',
      temperature: 25.0,
      mainCondition: 'Sunny',
      county: 'County 1',
      district: 'District 1',
      windSpeed: 5.0,
      dateTime: DateTime.now(),
    ),
    WeatherModel(
      cityName: 'City 2',
      temperature: 22.0,
      mainCondition: 'Cloudy',
      county: 'County 2',
      district: 'District 2',
      windSpeed: 3.0,
      dateTime: DateTime.now().add(Duration(days: 1)),
    ),
    // Add more weather data as needed
  ];

  runApp(MaterialApp(
    home: WeatherForecast(weatherData: weatherData),
  ));
}
