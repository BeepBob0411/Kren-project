// screen2.dart
import 'package:flutter/material.dart';

class Screen2 extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Screen 2'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text('This is Screen 2'),
            // Tambahkan widget atau fungsionalitas lain sesuai kebutuhan
          ],
        ),
      ),
    );
  }
}
