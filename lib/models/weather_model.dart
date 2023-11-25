class WeatherModel {
  final String cityName;
  final double temperature;
  final String mainCondition;
  final String county;
  final String district;

  WeatherModel({
    required this.cityName,
    required this.temperature,
    required this.mainCondition,
    required this.county,
    required this.district,
  });

  factory WeatherModel.fromJson(Map<String, dynamic> json) {
    return WeatherModel(
      cityName: json['name'],
      temperature: (json['main']['temp'] as num).toDouble(),
      mainCondition: json['weather'][0]['main'],
      county: json['name'],
      district: json['name'],
    );
  }
}
