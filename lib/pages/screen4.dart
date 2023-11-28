// lib/pages/screen4.dart

import 'package:flutter/material.dart';
import 'mitigasi/banjir.dart';
import 'mitigasi/gempa.dart';
import 'mitigasi/longsor.dart';
import 'mitigasi/gunung.dart';
import 'mitigasi/penyakit.dart';
import 'mitigasi/teroris.dart';
import 'mitigasi/kimia.dart';
import 'mitigasi/sosial.dart';

void main() => runApp(MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(fontFamily: 'ModernFont'),
      home: Screen4(),
      routes: {
        '/banjir': (context) => BanjirPage(),
        '/gempa': (context) => GempaPage(),
        '/longsor': (context) => LongsorPage(),
        '/gunung': (context) => GunungPage(),
        '/penyakit': (context) => PenyakitPage(),
        '/teroris': (context) => TerorisPage(),
        '/kimia': (context) => KimiaPage(),
        '/sosial': (context) => SosialPage(),
      },
    ));

class Screen4 extends StatefulWidget {
  @override
  _Screen4State createState() => _Screen4State();
}

class _Screen4State extends State<Screen4> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white60,
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Container(
                width: double.infinity,
                padding: EdgeInsets.all(20.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Text(
                      'Panduan',
                      style: TextStyle(color: Colors.black38, fontSize: 25),
                    ),
                    SizedBox(
                      height: 5,
                    ),
                    Text(
                      'Mitigasi',
                      style: TextStyle(
                          color: Colors.orangeAccent,
                          fontSize: 40,
                          fontWeight: FontWeight.bold),
                    ),
                    SizedBox(
                      height: 20,
                    ),
                  ],
                ),
              ),
              SizedBox(
                height: 20,
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    MitigasiSection(
                      title: 'Mitigasi Bencana Alam',
                      promoCards: [
                        promoCard('assets/images/banjir.jpg', '/banjir'),
                        promoCard('assets/images/gempa.jpg', '/gempa'),
                        promoCard('assets/images/longsor.jpg', '/longsor'),
                        promoCard('assets/images/gunung.jpg', '/gunung'),
                      ],
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    MitigasiSection(
                      title: 'Mitigasi Bencana Non Alam',
                      promoCards: [
                        promoCard('assets/images/penyakit.jpg', '/penyakit'),
                        promoCard('assets/images/teroris.jpg', '/teroris'),
                        promoCard('assets/images/kimia.jpg', '/kimia'),
                        promoCard('assets/images/tawuran.jpg', '/sosial'),
                      ],
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    Container(
                      height: 150,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(20),
                        image: DecorationImage(
                          fit: BoxFit.cover,
                          image: AssetImage('assets/images/three.jpg'),
                        ),
                      ),
                      child: Container(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(20),
                        ),
                        child: Align(
                          alignment: Alignment.bottomLeft,
                          child: Padding(
                            padding: const EdgeInsets.all(15.0),
                            child: Text(
                              'Panduan Mitigasi',
                              style: TextStyle(
                                  color: Colors.black,
                                  fontSize: 28,
                                  fontWeight: FontWeight.bold),
                            ),
                          ),
                        ),
                      ),
                    )
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

  Widget promoCard(String image, String routeName) {
    return GestureDetector(
      onTap: () {
        Navigator.push(context, MaterialPageRoute(builder: (context) {
          // Menentukan halaman tujuan berdasarkan rute dinamis
          switch (routeName) {
            case '/banjir':
              return BanjirPage();
            case '/gempa':
              return GempaPage();
            case '/longsor':
              return LongsorPage();
            case '/gunung':
              return GunungPage();
            case '/penyakit':
              return PenyakitPage();
            case '/teroris':
              return TerorisPage();
            case '/kimia':
              return KimiaPage();
            case '/sosial':
              return SosialPage();
            default:
              // Jika rute tidak dikenali, bisa menangani dengan menampilkan halaman default atau memberikan notifikasi kesalahan
              return Scaffold(
                body: Center(
                  child: Text('Halaman tidak ditemukan'),
                ),
              );
          }
        }));
      },
      child: AspectRatio(
        aspectRatio: 2.62 / 3,
        child: Container(
          margin: EdgeInsets.only(right: 15.0),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(20),
            image: DecorationImage(fit: BoxFit.cover, image: AssetImage(image)),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.3),
                spreadRadius: 2,
                blurRadius: 5,
                offset: Offset(0, 3),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class MitigasiSection extends StatelessWidget {
  final String title;
  final List<Widget> promoCards;

  MitigasiSection({required this.title, required this.promoCards});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Text(
          title,
          style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold),
        ),
        SizedBox(
          height: 15,
        ),
        Container(
          height: 200,
          child: ListView(
            scrollDirection: Axis.horizontal,
            children: promoCards,
          ),
        ),
      ],
    );
  }
}
