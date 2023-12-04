import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:kren/services/weather_service.dart';
import 'package:kren/models/weather_model.dart';
import 'package:lottie/lottie.dart';
import 'package:flutter_neumorphic/flutter_neumorphic.dart';

class Screen2 extends StatefulWidget {
  const Screen2({Key? key}) : super(key: key);

  @override
  State<Screen2> createState() => _Screen2State();
}

class _Screen2State extends State<Screen2> {
  final _weatherService = WeatherService('c4829a7aa3b361a5740d769b7fda4438');
  WeatherModel? _weather;
  List<WeatherModel>? _forecast;
  bool _showFullForecast = false;

  @override
  void initState() {
    super.initState();
    _fetchWeather();
    _fetchForecast();
  }

  _fetchWeather() async {
    try {
      final cityName = await _weatherService.getCurrentCity();
      final weather = await _weatherService.getWeatherForUserLocation(
        cityName: cityName,
      );
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
      backgroundColor = Colors.blueAccent;
    } else if (currentHour >= 12 && currentHour < 18) {
      backgroundColor = Colors.lightBlueAccent;
    } else {
      backgroundColor = Colors.indigoAccent;
    }

    return Scaffold(
      backgroundColor: backgroundColor,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              NeumorphicText(
                _weather != null
                    ? '${_weather?.cityName ?? ""}, ${_weather?.county ??
                    ""}, ${_weather?.district ?? ""}'
                    : 'Loading location...',
                style: NeumorphicStyle(
                  depth: 8,
                  intensity: 0.8,
                  color: Colors.black,
                ),
                textStyle: NeumorphicTextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
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
              NeumorphicText(
                _weather != null
                    ? '${_weather?.temperature.round()}°C'
                    : 'Loading temperature...',
                style: NeumorphicStyle(
                  depth: 8,
                  intensity: 0.8,
                  color: Colors.black,
                ),
                textStyle: NeumorphicTextStyle(
                  fontSize: 34,
                  fontWeight: FontWeight.bold,
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
              _buildWeatherForecastSection(),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildWeatherForecastSection() {
    return Expanded(
      child: ListView(
        children: [
          NeumorphicText(
            'Weather Forecast:',
            style: NeumorphicStyle(
              depth: 8,
              intensity: 0.8,
              color: Colors.black,
            ),
            textStyle: NeumorphicTextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
            ),
          ),
          _forecast != null
              ? _showFullForecast
              ? _buildFullWeatherForecast()
              : _buildShortWeatherForecast()
              : Center(
            child: CircularProgressIndicator(),
          ),
          SizedBox(height: 10),
          TextButton(
            onPressed: () {
              setState(() {
                _showFullForecast = !_showFullForecast;
              });
            },
            child: Text(
              _showFullForecast ? 'Show Less' : 'Read More',
              style: TextStyle(
                color: Colors.black,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildShortWeatherForecast() {
    return _forecast!.isNotEmpty
        ? WeatherForecastCard(forecast: _forecast![0])
        : NeumorphicText(
      'No forecast available.',
      style: NeumorphicStyle(
        depth: 8,
        intensity: 0.8,
        color: Colors.black,
      ),
      textStyle: NeumorphicTextStyle(
        fontSize: 16,
      ),
    );
  }

  Widget _buildFullWeatherForecast() {
    if (_forecast == null) {
      return CircularProgressIndicator();
    }

    Map<String, List<WeatherModel>> groupedForecast = {};

    // Assuming you have grouped the forecast by day
    for (var forecastItem in _forecast!) {
      String day = DateFormat('EEEE, MMM dd').format(forecastItem.dateTime);
      if (!groupedForecast.containsKey(day)) {
        groupedForecast[day] = [];
      }
      groupedForecast[day]!.add(forecastItem);
    }

    return SizedBox(
      height: 600, // Set your preferred height
      child: ListView(
        children: [
          NeumorphicText(
            'Weather Forecast:',
            style: NeumorphicStyle(
              depth: 8,
              intensity: 0.8,
              color: Colors.black,
            ),
            textStyle: NeumorphicTextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
            ),
          ),
          ...groupedForecast.keys.map((day) {
            List<WeatherModel> dailyForecast = groupedForecast[day]!;
            return Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                NeumorphicText(
                  day,
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
                Container(
                  height: 200, // Set a fixed height for the inner ListView
                  child: ListView.builder(
                    shrinkWrap: true,
                    physics: ClampingScrollPhysics(),
                    scrollDirection: Axis.horizontal,
                    itemCount: dailyForecast.length,
                    itemBuilder: (context, index) {
                      final forecastItem = dailyForecast[index];
                      return WeatherForecastCard(forecast: forecastItem);
                    },
                  ),
                ),
                SizedBox(height: 10),
              ],
            );
          }).toList(),
        ],
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
    return Neumorphic(
      style: NeumorphicStyle(
        depth: 8,
        intensity: 0.8,
        boxShape: NeumorphicBoxShape.roundRect(BorderRadius.circular(10)),
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
