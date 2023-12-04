// lib/pages/mitigasi/longsor.dart

import 'package:flutter/material.dart';

class LongsorPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Mitigasi Longsor'),
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Image.asset(
              'assets/images/longsor.jpg', // Path to the longsor image in your assets folder
              height: 200,
              fit: BoxFit.cover,
            ),
            SizedBox(height: 16.0),
            Text(
              'Menghadapi Ancaman Longsor dengan Tepat',
              style: TextStyle(
                fontSize: 24.0,
                fontWeight: FontWeight.bold,
              ),
              textAlign: TextAlign.center,
            ),
            SizedBox(height: 16.0),
            Text(
              'Longsor adalah bencana alam yang dapat terjadi di daerah pegunungan. '
              'Untuk meminimalkan risiko dan melindungi diri, ada langkah-langkah '
              'mitigasi yang perlu dipahami dan diterapkan dengan baik.',
              style: TextStyle(fontSize: 16.0),
              textAlign: TextAlign.justify,
            ),
            SizedBox(height: 16.0),
            Text(
              'Tips Mitigasi Longsor:',
              style: TextStyle(
                fontSize: 20.0,
                fontWeight: FontWeight.bold,
              ),
              textAlign: TextAlign.left,
            ),
            SizedBox(height: 8.0),
            _buildMitigationTip('1. Hindari Membangun di Lereng Curam'),
            _buildMitigationTip('2. Perkuat Pondasi Bangunan'),
            _buildMitigationTip('3. Tanam Tanaman Penahan Tanah'),
            _buildMitigationTip('4. Pantau Kondisi Tanah Secara Berkala'),
            _buildMitigationTip('5. Bangun Sistem Peringatan Dini'),
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
