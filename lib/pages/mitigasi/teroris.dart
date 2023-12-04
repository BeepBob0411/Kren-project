// lib/pages/mitigasi/teroris.dart

import 'package:flutter/material.dart';

class TerorisPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Mitigasi Teroris'),
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Image.asset(
              'assets/images/teroris.jpg', // Path to the teroris image in your assets folder
              height: 200,
              fit: BoxFit.cover,
            ),
            SizedBox(height: 16.0),
            Text(
              'Menghadapi Ancaman Teroris dengan Bijak',
              style: TextStyle(
                fontSize: 24.0,
                fontWeight: FontWeight.bold,
              ),
              textAlign: TextAlign.center,
            ),
            SizedBox(height: 16.0),
            Text(
              'Ancaman teroris adalah situasi yang memerlukan kewaspadaan tinggi. '
              'Untuk melindungi diri dan masyarakat, penting untuk memahami langkah-langkah '
              'mitigasi teroris dengan bijak dan efektif.',
              style: TextStyle(fontSize: 16.0),
              textAlign: TextAlign.justify,
            ),
            SizedBox(height: 16.0),
            Text(
              'Tips Mitigasi Teroris:',
              style: TextStyle(
                fontSize: 20.0,
                fontWeight: FontWeight.bold,
              ),
              textAlign: TextAlign.left,
            ),
            SizedBox(height: 8.0),
            _buildMitigationTip('1. Tingkatkan Kewaspadaan di Tempat Publik'),
            _buildMitigationTip('2. Pahami Prosedur Evakuasi'),
            _buildMitigationTip('3. Laporkan Aktivitas Mencurigakan'),
            _buildMitigationTip('4. Ikuti Petunjuk Otoritas Keamanan'),
            _buildMitigationTip('5. Terlibat dalam Program Keselamatan Komunitas'),
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
