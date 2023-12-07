// lib/pages/mitigasi/penyakit.dart

import 'package:flutter/material.dart';

class PenyakitPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Mitigasi Penyakit'),
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Image.asset(
              'assets/images/penyakit.jpg', // Path to the penyakit image in your assets folder
              height: 200,
              fit: BoxFit.cover,
            ),
            SizedBox(height: 16.0),
            Text(
              'Menghindari Penyakit dengan Tindakan Pencegahan',
              style: TextStyle(
                fontSize: 24.0,
                fontWeight: FontWeight.bold,
              ),
              textAlign: TextAlign.center,
            ),
            SizedBox(height: 16.0),
            Text(
              'Penyakit dapat membahayakan kesehatan dan kesejahteraan kita. '
              'Dengan melakukan tindakan pencegahan yang tepat, kita dapat '
              'mengurangi risiko tertular penyakit dan menjaga kebugaran tubuh.',
              style: TextStyle(fontSize: 16.0),
              textAlign: TextAlign.justify,
            ),
            SizedBox(height: 16.0),
            Text(
              'Tips Mitigasi Penyakit:',
              style: TextStyle(
                fontSize: 20.0,
                fontWeight: FontWeight.bold,
              ),
              textAlign: TextAlign.left,
            ),
            SizedBox(height: 8.0),
            _buildMitigationTip('1. Cuci Tangan dengan Rutin'),
            _buildMitigationTip('2. Jaga Kebersihan Lingkungan'),
            _buildMitigationTip('3. Konsumsi Makanan Bergizi'),
            _buildMitigationTip('4. Rutin Berolahraga'),
            _buildMitigationTip('5. Hindari Kontak dengan Orang Sakit'),
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
