// lib/pages/mitigasi/banjir.dart

import 'package:flutter/material.dart';

class BanjirPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Mitigasi Banjir'),
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Image.network(
              'https://example.com/banjir_image.jpg', 
              height: 200,
              fit: BoxFit.cover,
            ),
            SizedBox(height: 16.0),
            Text(
              'Mengatasi Banjir dengan Bijak',
              style: TextStyle(
                fontSize: 24.0,
                fontWeight: FontWeight.bold,
              ),
              textAlign: TextAlign.center,
            ),
            SizedBox(height: 16.0),
            Text(
              'Banjir adalah bencana alam yang dapat merugikan banyak orang. '
              'Penting bagi kita untuk memahami dan mengatasi banjir dengan bijak '
              'agar dampaknya dapat diminimalkan.',
              style: TextStyle(fontSize: 16.0),
              textAlign: TextAlign.justify,
            ),
            SizedBox(height: 16.0),
            Text(
              'Tips Mitigasi Banjir:',
              style: TextStyle(
                fontSize: 20.0,
                fontWeight: FontWeight.bold,
              ),
              textAlign: TextAlign.left,
            ),
            SizedBox(height: 8.0),
            _buildMitigationTip('1. Bangun Tanggul Perlindungan'),
            _buildMitigationTip('2. Identifikasi Jalur Evakuasi'),
            _buildMitigationTip('3. Persiapkan Perlengkapan Darurat'),
            _buildMitigationTip('4. Perhatikan Sistem Drainase'),
            _buildMitigationTip('5. Bangun Kesadaran Masyarakat'),
          ],
        ),
      ),
    );
  }

  Widget _buildMitigationTip(String tip) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 4.0),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Icon(
            Icons.check_circle,
            color: Colors.green,
          ),
          SizedBox(width: 8.0),
          Expanded(
            child: Text(tip, style: TextStyle(fontSize: 16.0)),
          ),
        ],
      ),
    );
  }
}
