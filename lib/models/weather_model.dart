// weather_model.dart
class WeatherModel {
  final String cityName;
  final double temperature;
  final String mainCondition;
  final String county;
  final String district;
  final double windSpeed;
  final DateTime dateTime; // Added dateTime property

  WeatherModel({
    required this.cityName,
    required this.temperature,
    required this.mainCondition,
    required this.county,
    required this.district,
    required this.windSpeed,
    required this.dateTime, // Added dateTime parameter
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
        dateTime: DateTime.now(), // Set a default value for dateTime
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
          json['dt'] * 1000, // Convert timestamp to DateTime
          isUtc: false,
        ),
      );
    } catch (e) {
      print('Error parsing forecast data: $e');
      throw Exception('Failed to parse forecast data');
    }
  }
}
