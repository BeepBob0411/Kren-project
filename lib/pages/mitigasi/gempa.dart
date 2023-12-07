// lib/pages/mitigasi/gempa.dart

import 'package:flutter/material.dart';

class GempaPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Mitigasi Gempa'),
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Image.asset(
              'assets/gempa.jpg', // Path to the gempa image in your assets folder
              height: 200,
              fit: BoxFit.cover,
            ),
            SizedBox(height: 16.0),
            Text(
              'Menghadapi Gempa Bumi dengan Bijak',
              style: TextStyle(
                fontSize: 24.0,
                fontWeight: FontWeight.bold,
              ),
              textAlign: TextAlign.center,
            ),
            SizedBox(height: 16.0),
            Text(
              'Gempa bumi adalah fenomena alam yang sering terjadi di berbagai belahan dunia. '
              'Untuk menjaga keselamatan diri dan orang lain, penting untuk memahami cara '
              'menghadapi gempa bumi dengan bijak dan efektif.',
              style: TextStyle(fontSize: 16.0),
              textAlign: TextAlign.justify,
            ),
            SizedBox(height: 16.0),
            Text(
              'Tips Mitigasi Gempa:',
              style: TextStyle(
                fontSize: 20.0,
                fontWeight: FontWeight.bold,
              ),
              textAlign: TextAlign.left,
            ),
            SizedBox(height: 8.0),
            _buildMitigationTip('1. Cari Tempat Perlindungan'),
            _buildMitigationTip('2. Tetap Tenang dan Jangan Panik'),
            _buildMitigationTip('3. Amankan Barang-Berat di Rumah'),
            _buildMitigationTip('4. Pahami Jalur Evakuasi'),
            _buildMitigationTip('5. Persiapkan Tas Darurat'),
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
