// lib/pages/mitigasi/kimia.dart

import 'package:flutter/material.dart';

class KimiaPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Mitigasi Bencana Kimia'),
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Image.asset(
              'assets/images/kimia.jpg', // Path to the kimia image in your assets folder
              height: 200,
              fit: BoxFit.cover,
            ),
            SizedBox(height: 16.0),
            Text(
              'Menghadapi Bencana Kimia dengan Bijak',
              style: TextStyle(
                fontSize: 24.0,
                fontWeight: FontWeight.bold,
              ),
              textAlign: TextAlign.center,
            ),
            SizedBox(height: 16.0),
            Text(
              'Bencana kimia dapat menimbulkan ancaman serius terhadap kesehatan manusia dan lingkungan. '
              'Untuk mengurangi risiko, penting untuk memahami langkah-langkah mitigasi dan tindakan '
              'darurat yang dapat diambil ketika menghadapi bencana kimia.',
              style: TextStyle(fontSize: 16.0),
              textAlign: TextAlign.justify,
            ),
            SizedBox(height: 16.0),
            Text(
              'Tips Mitigasi Bencana Kimia:',
              style: TextStyle(
                fontSize: 20.0,
                fontWeight: FontWeight.bold,
              ),
              textAlign: TextAlign.left,
            ),
            SizedBox(height: 8.0),
            _buildMitigationTip('1. Identifikasi Bahan Kimia Berbahaya di Sekitar'),
            _buildMitigationTip('2. Persiapkan Perlindungan Pribadi'),
            _buildMitigationTip('3. Pelajari Cara Menggunakan Alat Pelindung'),
            _buildMitigationTip('4. Tetap di Tempat Perlindungan Saat Terjadi Bencana'),
            _buildMitigationTip('5. Ikuti Panduan Evakuasi yang Telah Ditentukan'),
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
