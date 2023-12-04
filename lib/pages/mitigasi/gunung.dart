// lib/pages/mitigasi/gunung.dart

import 'package:flutter/material.dart';

class GunungPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Mitigasi Gunung Berapi'),
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Image.asset(
              'assets/images/gunung.jpg', // Ganti dengan path gambar gunung yang sesuai
              height: 200,
              fit: BoxFit.cover,
            ),
            SizedBox(height: 16.0),
            Text(
              'Menghadapi Ancaman Gunung Berapi',
              style: TextStyle(
                fontSize: 24.0,
                fontWeight: FontWeight.bold,
              ),
              textAlign: TextAlign.center,
            ),
            SizedBox(height: 16.0),
            Text(
              'Gunung berapi merupakan ancaman alam yang serius dan bisa menimbulkan dampak '
              'luas terhadap kehidupan dan lingkungan sekitarnya. Oleh karena itu, pengetahuan '
              'tentang mitigasi gunung berapi sangat penting untuk keselamatan kita.',
              style: TextStyle(fontSize: 16.0),
              textAlign: TextAlign.justify,
            ),
            SizedBox(height: 16.0),
            Text(
              'Tips Mitigasi Gunung Berapi:',
              style: TextStyle(
                fontSize: 20.0,
                fontWeight: FontWeight.bold,
              ),
              textAlign: TextAlign.left,
            ),
            SizedBox(height: 8.0),
            _buildMitigationTip('1. Ketahui Zona Rawan Gunung Berapi'),
            _buildMitigationTip('2. Pahami Prosedur Evakuasi'),
            _buildMitigationTip('3. Persiapkan Barang Darurat'),
            _buildMitigationTip('4. Ikuti Arahan Pihak Berwenang'),
            _buildMitigationTip('5. Sediakan Tempat Berteduh yang Aman'),
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
