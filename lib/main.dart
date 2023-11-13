import 'package:flutter/material.dart';
import 'package:kren/screen/onboarding/screen_one.dart';
import 'package:kren/login.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Pelaporan Bencana Alam Daerah',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: FutureBuilder(
        future: _isFirstTimeUser(),
        builder: (context, snapshot) {
          if (snapshot.hasData && snapshot.data == true) {
            // Pengguna baru, tampilkan onboarding screen
            return OnboardingScreenOne();
          } else {
            // Pengguna tidak baru, tampilkan halaman login
            return LoginPage();
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
}
