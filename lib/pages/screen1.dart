import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Berita App',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: Screen1(),
    );
  }
}

class Screen1 extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Beranda'),
      ),
      body: Column(
        children: [
          Container(
            padding: EdgeInsets.all(16.0),
            color: Colors.red,
            child: Text(
              'Peringatan: "Peringatan Dini Gempa Bumi: Gempa terjadi, segera lindungi diri di bawah meja atau keluar rumah ke tempat terbuka."',
              style: TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          Expanded(
            child: ListView.builder(
              itemCount: 2, // Ganti dengan jumlah berita yang ada
              itemBuilder: (context, index) {
                return BeritaItem(
                  judul: 'Gempa Bumi Guncang Wilayah Simasom', // Ganti dengan judul berita yang sesuai
                  isi: 'Sebuah gempa bumi dengan kekuatan 9,5 Maglitudo mengguncang wilayah Simasom pada 17 Agustus 1945. Guncangan terasa kuat dan menyebabkan kepanikan di kalangan penduduk setempat. Meskipun belum ada laporan resmi mengenai kerusakan atau korban jiwa, pihak berwenang sedang melakukan evaluasi dampak gempa ini. Warga diminta untuk tetap waspada dan mengikuti petunjuk evakuasi yang telah disediakan. Tim penyelamat dan relawan sedang bergerak cepat untuk memberikan bantuan dan pertolongan di daerah terdampak.',
                  pengirim: 'Kim Naldo',
                  waktu: '2 jam yang lalu',
                  fotoPengirim: 'assets/images/kimnaldo.jpg',
                  gambarBerita: 'assets/images/gambar_berita1.jpg',
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}

class BeritaItem extends StatelessWidget {
  final String judul;
  final String isi;
  final String pengirim;
  final String waktu;
  final String fotoPengirim;
  final String gambarBerita;

  BeritaItem({
    required this.judul,
    required this.isi,
    required this.pengirim,
    required this.waktu,
    required this.fotoPengirim,
    required this.gambarBerita,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: EdgeInsets.symmetric(vertical: 8.0, horizontal: 16.0),
      child: Padding(
        padding: EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              judul,
              style: TextStyle(
                fontSize: 18.0,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: 8.0),
            Image.asset(
              gambarBerita,
              fit: BoxFit.cover,
              height: 200.0, // Atur tinggi gambar sesuai kebutuhan
            ),
            SizedBox(height: 8.0),
            Text(isi),
            SizedBox(height: 8.0),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  children: [
                    CircleAvatar(
                      backgroundImage: AssetImage(fotoPengirim),
                    ),
                    SizedBox(width: 8.0),
                    Text(
                      pengirim,
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                  ],
                ),
                Text(waktu),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
