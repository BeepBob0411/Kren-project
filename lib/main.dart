import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:kren/bloc/weather_bloc_bloc.dart';
import 'package:kren/screen/weather/weather_screen.dart';
import 'package:geolocator/geolocator.dart';
import 'package:kren/screen/onboarding/screen_one.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() {
  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({Key? key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: FutureBuilder(
        future: _isFirstTimeUser(),
        builder: (context, snapshot) {
          if (snapshot.hasData && snapshot.data == true) {
            // New user, show onboarding screen
            return OnboardingScreenOne();
          } else {
            // Returning user, determine location and show weather screen
            return FutureBuilder(
              future: _determinePosition(),
              builder: (context, snap) {
                if (snap.hasData) {
                  return BlocProvider<WeatherBlocBloc>(
                    create: (context) => WeatherBlocBloc()
                      ..add(FetchWeather(snap.data as Position)),
                    child: const WeatherScreen(),
                  );
                } else {
                  return const Scaffold(
                    body: Center(
                      child: CircularProgressIndicator(),
                    ),
                  );
                }
              },
            );
          }
        },
      ),
    );
  }

  Future<bool> _isFirstTimeUser() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    bool onboardingSeen = prefs.getBool('onboarding_seen') ?? false;
    return !onboardingSeen;
  }

  /// Determine the current position of the device.
  Future<Position> _determinePosition() async {
    bool serviceEnabled;
    LocationPermission permission;

    // Test if location services are enabled.
    serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      return Future.error('Location services are disabled.');
    }

    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        return Future.error('Location permissions are denied');
      }
    }

    if (permission == LocationPermission.deniedForever) {
      return Future.error(
          'Location permissions are permanently denied, we cannot request permissions.');
    }

    // When we reach here, permissions are granted, and we can
    // continue accessing the position of the device.
    return await Geolocator.getCurrentPosition();
  }
}
