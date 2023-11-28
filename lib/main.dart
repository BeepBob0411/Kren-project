import 'package:flutter/material.dart';
import 'package:kren/nav.dart';
import 'package:kren/screen/onboarding/screen_one.dart';
import 'package:kren/screen/onboarding/screen_two.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:firebase_core/firebase_core.dart';
import 'firebase_options.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: FutureBuilder(
        future: _isUserLoggedIn(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.done) {
            bool isLoggedIn = snapshot.data as bool;

            if (isLoggedIn) {
              // User is logged in, navigate to the home screen
              return NavPages();
            } else {
              // User is not logged in, check onboarding status
              return FutureBuilder(
                future: _isFirstTimeUser(),
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.done) {
                    bool isFirstTimeUser = snapshot.data as bool;

                    if (isFirstTimeUser) {
                      // New user, show onboarding screen one
                      return OnboardingScreenOne();
                    } else {
                      // Returning user, show onboarding screen two
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
              );
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

  Future<bool> _isUserLoggedIn() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    bool isLoggedIn = prefs.getBool('is_logged_in') ?? false;
    return isLoggedIn;
  }
}
