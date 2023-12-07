import 'package:flutter/material.dart';
import 'package:kren/screen/onboarding/screen_one.dart';
import 'package:kren/screen/onboarding/screen_two.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:firebase_core/firebase_core.dart';
// import 'package:flutter/services.dart';
// import 'package:flutter/scheduler.dart';
// import 'package:kren/theme/theme_helper.dart';
// import 'package:kren/routes/app_routes.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  final Future<FirebaseApp> _initialization = Firebase.initializeApp();

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: _initialization,
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.done) {
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

        // While waiting for Firebase to initialize, show a loading indicator
        return MaterialApp(
          home: Scaffold(
            body: Center(
              child: CircularProgressIndicator(),
            ),
          ),
        );
      },
    );
  }

  Future<bool> _isFirstTimeUser() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    bool onboardingSeen = prefs.getBool('onboarding_seen') ?? false;
    return !onboardingSeen;
  }
}
