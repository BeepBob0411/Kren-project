import 'package:flutter/material.dart';
import 'package:kren/screen/onboarding/screen_one.dart';
import 'package:kren/screen/onboarding/screen_two.dart';
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
          if (snapshot.connectionState == ConnectionState.done) {
            bool isFirstTimeUser = snapshot.data as bool;

            if (isFirstTimeUser) {
              // New user, show onboarding screen one
              return OnboardingScreenOne();
            } else {
              // Returning user, navigate to screen two
              return OnboardingScreenTwo();
            }
          } else {
            return const Scaffold(
              body: Center(
                child: CircularProgressIndicator(),
              ),
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
}
