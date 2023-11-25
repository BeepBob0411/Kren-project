import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';

enum JenisBencana { alam, nonAlam }

extension JenisBencanaExtension on JenisBencana {
  String get name {
    switch (this) {
      case JenisBencana.alam:
        return 'Alam';
      case JenisBencana.nonAlam:
        return 'Non Alam';
      default:
        throw ArgumentError('Unsupported JenisBencana: $this');
    }
  }
}

class LaporkanKejadian extends StatefulWidget {
  @override
  _LaporkanKejadianState createState() => _LaporkanKejadianState();
}

class _LaporkanKejadianState extends State<LaporkanKejadian> {
  final _namaBencanaController = TextEditingController();
  final _lokasiBencanaController = TextEditingController();
  final _keteranganBencanaController = TextEditingController();
  File? _image;
  Position? _currentPosition;
  JenisBencana? _selectedJenisBencana;

  @override
  void initState() {
    super.initState();
    // Mendapatkan lokasi pengguna secara realtime
    _getCurrentLocation();
  }

  void _getCurrentLocation() async {
    try {
      // Mendapatkan lokasi pengguna
      final position = await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.high,
      );
      // Menyimpan lokasi pengguna ke variabel
      setState(() {
        _currentPosition = position;
      });
    } catch (e) {
      print("Error getting location: $e");
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Laporkan Kejadian"),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              // Teks "Laporkan Kejadian" dan "Bencana" dengan gaya yang diinginkan
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "Laporkan Kejadian",
                    style: TextStyle(
                      fontSize: 20,
                      color: Colors.black,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Text(
                    "Bencana",
                    style: TextStyle(
                      fontSize: 20,
                      color: Colors.orange,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
              SizedBox(height: 16.0), // Jarak antara teks dan dropdown

              // Jenis bencana
              Container(
                padding: EdgeInsets.symmetric(horizontal: 12.0),
                decoration: BoxDecoration(
                  border: Border.all(color: Colors.grey),
                  borderRadius: BorderRadius.circular(8.0),
                ),
                child: DropdownButtonFormField(
                  value: _selectedJenisBencana,
                  hint: Text("Pilih Jenis Bencana"),
                  items: JenisBencana.values
                      .map((e) => DropdownMenuItem(
                            value: e,
                            child: Text(e.name),
                          ))
                      .toList(),
                  onChanged: (value) {
                    setState(() {
                      _selectedJenisBencana = value as JenisBencana?;
                    });
                  },
                ),
              ),
              SizedBox(height: 16.0), // Jarak antara dropdown dan textfield

              // Nama bencana
              Container(
                padding: EdgeInsets.symmetric(horizontal: 12.0),
                decoration: BoxDecoration(
                  border: Border.all(color: Colors.grey),
                  borderRadius: BorderRadius.circular(8.0),
                ),
                child: TextFormField(
                  controller: _namaBencanaController,
                  decoration: InputDecoration(
                    labelText: "Nama Bencana",
                  ),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Nama Bencana tidak boleh kosong';
                    }
                    return null;
                  },
                ),
              ),
              SizedBox(height: 16.0), // Jarak antara textfield dan textfield berikutnya

              // Lokasi bencana
              Container(
                padding: EdgeInsets.symmetric(horizontal: 12.0),
                decoration: BoxDecoration(
                  border: Border.all(color: Colors.grey),
                  borderRadius: BorderRadius.circular(8.0),
                ),
                child: TextFormField(
                  controller: _lokasiBencanaController,
                  decoration: InputDecoration(
                    labelText: "Lokasi Bencana",
                  ),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Lokasi Bencana tidak boleh kosong';
                    }
                    return null;
                  },
                ),
              ),
              SizedBox(height: 16.0), // Jarak antara textfield dan textfield berikutnya

              // Keterangan bencana
              Container(
                padding: EdgeInsets.symmetric(horizontal: 12.0),
                decoration: BoxDecoration(
                  border: Border.all(color: Colors.grey),
                  borderRadius: BorderRadius.circular(8.0),
                ),
                child: TextFormField(
                  controller: _keteranganBencanaController,
                  decoration: InputDecoration(
                    labelText: "Keterangan Bencana",
                  ),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Keterangan Bencana tidak boleh kosong';
                    }
                    return null;
                  },
                ),
              ),
              SizedBox(height: 16.0), // Jarak antara textfield dan textfield berikutnya

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
                      final XFile? image =
                          await ImagePicker().pickImage(source: source);

                      if (image != null) {
                        setState(() {
                          _image = File(image.path);
                        });
                      }
                    },
                    child: Text("Pilih Gambar dari Kamera"),
                  ),
                ],
              ),
              _image != null
                  ? Image.file(
                      _image!,
                      width: 200,
                      height: 200,
                    )
                  : Container(),
              SizedBox(height: 16.0), // Jarak antara gambar dan tombol Lapor

              // Tombol Lapor
              ElevatedButton(
                onPressed: () {
                  if (_validateForm()) {
                    _submitReport();
                  }
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.blue, // Use backgroundColor instead of primary
                  padding: EdgeInsets.all(16.0), // Perbesar tombol
                ),
                child: Text(
                  'Lapor',
                  style: TextStyle(
                    color: Colors.white, // Warna teks tombol
                    fontSize: 18, // Perbesar teks tombol
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  bool _validateForm() {
    if (_selectedJenisBencana == null ||
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
