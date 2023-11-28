import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
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
  List<WeatherModel>? _forecast;

  @override
  void initState() {
    super.initState();
    _fetchWeather();
    _fetchForecast();
  }

  _fetchWeather() async {
    try {
      final cityName = await _weatherService.getCurrentCity();
      final weather = await _weatherService.getWeatherForUserLocation(cityName: cityName);
      setState(() {
        _weather = weather;
      });
    } catch (e) {
      print(e);
    }
  }

  _fetchForecast() async {
    try {
      final forecast = await _weatherService.getForecastForUserLocation();
      setState(() {
        _forecast = forecast;
      });
    } catch (e) {
      print('Error fetching forecast: $e');
    }
  }

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
    DateTime currentTime = DateTime.now();
    int currentHour = currentTime.hour;
    Color backgroundColor;

    if (currentHour >= 6 && currentHour < 12) {
      backgroundColor = Colors.yellow[100]!;
    } else if (currentHour >= 12 && currentHour < 18) {
      backgroundColor = Colors.yellow[300]!;
    } else {
      backgroundColor = Colors.blueGrey[900]!;
    }

    return Scaffold(
      backgroundColor: backgroundColor,
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
                  color: Colors.black,
                ),
              ),
              SizedBox(height: 10),
              Expanded(
                child: Lottie.asset(
                  getWeatherAnimation(mainCondition: _weather?.mainCondition),
                  repeat: true,
                  reverse: false,
                ),
              ),
              SizedBox(height: 20),
              Text(
                _weather != null
                    ? '${_weather?.temperature.round()}°C'
                    : 'Loading temperature...',
                style: TextStyle(
                  fontSize: 34,
                  fontWeight: FontWeight.bold,
                  color: Colors.black,
                ),
              ),
              SizedBox(height: 10),
              WeatherInfo(
                icon: Icons.wb_sunny,
                label: 'Condition',
                value: _weather?.mainCondition ?? 'Loading condition...',
              ),
              SizedBox(height: 10),
              WeatherInfo(
                icon: Icons.thermostat,
                label: 'Wind Speed',
                value: _weather?.windSpeed != null
                    ? '${_weather!.windSpeed} m/s Wind'
                    : 'Loading wind speed...',
              ),
              SizedBox(height: 20),
              if (_forecast != null)
                WeatherForecast(forecast: _forecast!),
              if (_forecast == null)
                Center(
                  child: CircularProgressIndicator(),
                ),
            ],
          ),
        ),
      ),
    );
  }
}

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
        Text(
          value,
          style: TextStyle(
            fontSize: 18,
            color: Colors.black,
          ),
        ),
      ],
    );
  }
}

class WeatherForecast extends StatelessWidget {
  final List<WeatherModel> forecast;

  WeatherForecast({
    required this.forecast,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text(
          'Weather Forecast:',
          style: TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.bold,
            color: Colors.black,
          ),
        ),
        if (forecast.isNotEmpty)
          Container(
            height: 200,
            child: ListView.builder(
              scrollDirection: Axis.horizontal,
              itemCount: forecast.length,
              itemBuilder: (context, index) {
                final forecastItem = forecast[index];
                return WeatherForecastCard(forecast: forecastItem);
              },
            ),
          ),
        if (forecast.isEmpty)
          Text(
            'No forecast available.',
            style: TextStyle(
              fontSize: 16,
              color: Colors.black,
            ),
          ),
      ],
    );
  }
}

class WeatherForecastCard extends StatelessWidget {
  final WeatherModel forecast;

  WeatherForecastCard({
    required this.forecast,
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
    return Card(
      elevation: 4,
      margin: EdgeInsets.all(8),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10.0),
      ),
      child: Padding(
        padding: const EdgeInsets.all(12.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              '${DateFormat('EEEE, MMM dd').format(forecast.dateTime)}, ${forecast.dateTime.hour}:00',
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: 5),
            Text(
              '${forecast.temperature.round()}°C, ${forecast.mainCondition}, ${forecast.windSpeed} m/s Wind',
              style: TextStyle(
                fontSize: 14,
              ),
            ),
            SizedBox(height: 10),
            Lottie.asset(
              getWeatherAnimation(mainCondition: forecast.mainCondition),
              height: 50,
            ),
          ],
        ),
      ),
    );
  }
}
