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
        brightness: Brightness.light,
        backgroundColor: Colors.white,
        scaffoldBackgroundColor: Colors.white,
      ),
      home: Screen1(),
    );
  }
}

class Screen1 extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
              itemCount: 2,
              itemBuilder: (context, index) {
                return BeritaItem(
                  judul: 'Gempa Bumi Guncang Wilayah Simasom',
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

class BeritaItem extends StatefulWidget {
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
  _BeritaItemState createState() => _BeritaItemState();
}

class _BeritaItemState extends State<BeritaItem> {
  bool isExpanded = false;

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 4.0,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12.0),
      ),
      margin: EdgeInsets.symmetric(vertical: 8.0, horizontal: 16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          GestureDetector(
            onTap: () {
              setState(() {
                isExpanded = !isExpanded;
              });
            },
            child: Column(
              children: [
                ClipRRect(
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(12.0),
                    topRight: Radius.circular(12.0),
                  ),
                  child: Image.asset(
                    widget.gambarBerita,
                    fit: BoxFit.cover,
                    height: 150.0,
                    width: double.infinity,
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Text(
                    widget.judul,
                    style: TextStyle(
                      fontSize: 20.0,
                      fontWeight: FontWeight.bold,
                      color: Colors.blue,
                    ),
                  ),
                ),
              ],
            ),
          ),
          Visibility(
            visible: isExpanded,
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    widget.isi,
                    style: TextStyle(
                      color: Colors.black87,
                      fontSize: 16.0,
                    ),
                  ),
                  SizedBox(height: 8.0),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Row(
                        children: [
                          CircleAvatar(
                            backgroundImage: AssetImage(widget.fotoPengirim),
                          ),
                          SizedBox(width: 8.0),
                          Text(
                            widget.pengirim,
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 14.0,
                            ),
                          ),
                        ],
                      ),
                      Text(
                        widget.waktu,
                        style: TextStyle(
                          fontSize: 12.0,
                          color: Colors.grey,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
