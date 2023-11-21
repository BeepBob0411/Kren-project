// screen3.dart Untuk halaman Lapor
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:image_picker/image_picker.dart';

enum JenisBencana { alam, nonAlam }

extension JenisBencanaExtension on JenisBencana {
  String get name {
    switch (this) {
      case JenisBencana.alam:
        return 'Alam';
      case JenisBencana.nonAlam:
        return 'Non Alam';
      default:
        return null;
    }
  }
}

class LaporkanKejadian extends StatefulWidget {
  @override
  _LaporkanKejadianState createState() => _LaporkanKejadianState();
}

class _LaporkanKejadianState extends State<LaporkanKejadian> {
  final _jenisBencanaController = TextEditingController();
  final _namaBencanaController = TextEditingController();
  final _lokasiBencanaController = TextEditingController();
  final _keteranganBencanaController = TextEditingController();
  File _image;
  Position _currentPosition;

  @override
  void initState() {
    super.initState();
    // Mendapatkan lokasi pengguna secara realtime
    _getCurrentLocation();
  }

  void _getCurrentLocation() async {
    // Mendapatkan lokasi pengguna
    final position = await Geolocator.getCurrentPosition(desiredAccuracy: LocationAccuracy.high);
    // Menyimpan lokasi pengguna ke variabel
    setState(() {
      _currentPosition = position;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Laporkan Kejadian"),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            // Jenis bencana
            DropdownButtonFormField(
              value: JenisBencana.alam,
              items: JenisBencana.values.map((e) => DropdownMenuItem(value: e, child: Text(e.name))).toList(),
              onChanged: (value) {
                setState(() {
                  _jenisBencanaController.text = value.name;
                });
              },
            ),
            // Nama bencana
            TextFormField(
              controller: _namaBencanaController,
              decoration: InputDecoration(
                labelText: "Nama Bencana",
              ),
              validator: (value) {
                if (value.isEmpty) {
                  return 'Nama Bencana tidak boleh kosong';
                }
                return null;
              },
            ),
            // Lokasi bencana
            TextFormField(
              controller: _lokasiBencanaController,
              decoration: InputDecoration(
                labelText: "Lokasi Bencana",
              ),
              validator: (value) {
                if (value.isEmpty) {
                  return 'Lokasi Bencana tidak boleh kosong';
                }
                return null;
              },
            ),
            // Keterangan bencana
            TextFormField(
              controller: _keteranganBencanaController,
              decoration: InputDecoration(
                labelText: "Keterangan Bencana",
              ),
              validator: (value) {
                if (value.isEmpty) {
                  return 'Keterangan Bencana tidak boleh kosong';
                }
                return null;
              },
            ),
            // Gambar
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                // Tombol pilih gambar dari kamera
                TextButton(
                  onPressed: () async {
                    // Pilih gambar dari kamera
                    final ImageSource source = ImageSource.camera;

                    // Unggah gambar ke server
                    final image = await ImagePicker.pickImage(source: source);

                    if (image != null) {
                      setState(() {
                        _image = image;
                      });
                    }
                  },
                  child: Text("Pilih Gambar dari Kamera"),
                ),
              ],
            ),
            _image != null
                ? Image.file(
                    _image,
                    width: 200,
                    height: 200,
                  )
                : Container(),
            // Tombol Lapor
            ElevatedButton(
              onPressed: () {
                if (_validateForm()) {
                  _submitReport();
                }
              },
              style: ElevatedButton.styleFrom(
                primary: Colors.blue, // Warna latar belakang tombol
              ),
              child: Text(
                'Lapor',
                style: TextStyle(
                  color: Colors.white, // Warna teks tombol
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  bool _validateForm() {
    if (_jenisBencanaController.text.isEmpty ||
        _namaBencanaController.text.isEmpty ||
        _lokasiBencanaController.text.isEmpty ||
        _keteranganBencanaController.text.isEmpty ||
        _image == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text("Harap lengkapi semua field dan pilih gambar"),
        ),
      );
      return false;
    }
    return true;
  }

  void _submitReport() {
    // Logika pengiriman laporan ke server
    print('Data Terkirim!');
  }
}

class Screen3 extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Screen 3'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text('This is Screen 3'),
            LaporkanKejadian(), // Tambahkan widget LaporkanKejadian
          ],
        ),
      ),
    );
  }
}

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'My App',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: Screen3(),
    );
  }
}




