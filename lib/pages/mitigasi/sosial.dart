// lib/pages/mitigasi/sosial.dart

import 'package:flutter/material.dart';

class SosialPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Mitigasi Bencana Sosial'),
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Image.asset(
              'assets/images/sosial.jpg', // Ganti dengan path gambar sosial yang sesuai
              height: 200,
              fit: BoxFit.cover,
            ),
            SizedBox(height: 16.0),
            Text(
              'Mengatasi Bencana Sosial dengan Solidaritas',
              style: TextStyle(
                fontSize: 24.0,
                fontWeight: FontWeight.bold,
              ),
              textAlign: TextAlign.center,
            ),
            SizedBox(height: 16.0),
            Text(
              'Bencana sosial dapat melibatkan berbagai aspek kehidupan masyarakat. '
              'Dalam menghadapi bencana ini, solidaritas dan kerjasama antarindividu '
              'sangat penting untuk membangun kembali komunitas dan memberikan dukungan.',
              style: TextStyle(fontSize: 16.0),
              textAlign: TextAlign.justify,
            ),
            SizedBox(height: 16.0),
            Text(
              'Tips Mitigasi Bencana Sosial:',
              style: TextStyle(
                fontSize: 20.0,
                fontWeight: FontWeight.bold,
              ),
              textAlign: TextAlign.left,
            ),
            SizedBox(height: 8.0),
            _buildMitigationTip('1. Bangun Komunikasi yang Baik'),
            _buildMitigationTip('2. Galang Dana untuk Masyarakat Terdampak'),
            _buildMitigationTip('3. Bantu Masyarakat dalam Pendidikan dan Pelatihan'),
            _buildMitigationTip('4. Gencarkan Kampanye Kesadaran Masyarakat'),
            _buildMitigationTip('5. Dukung Program Reintegrasi Sosial'),
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
