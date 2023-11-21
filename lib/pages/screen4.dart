// screen4.dart
import 'package:flutter/material.dart';

class Screen4 extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Screen 4'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text('This is Screen 4'),
            // Tambahkan widget atau fungsionalitas lain sesuai kebutuhan
          ],
        ),
      ),
    );
  }
}
