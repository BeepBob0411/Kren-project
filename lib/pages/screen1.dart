// screen1.dart
import 'package:flutter/material.dart';

class Screen1 extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Screen 1'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text('Welcome to Screen 1'),
            // Tambahkan widget atau fungsionalitas lain sesuai kebutuhan
          ],
        ),
      ),
    );
  }
}
