import 'dart:io';
import 'dart:typed_data';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:image/image.dart' as img;
import 'package:kren/constants/location_picker_map.dart'; // Update with the correct path
import 'package:google_maps_flutter/google_maps_flutter.dart' show LatLng;
import 'package:firebase_storage/firebase_storage.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(LaporkanKejadian());
}

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
  JenisBencana? _selectedJenisBencana;
  bool _isSubmitting = false;
  LatLng? _selectedLocation;

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: Text("Laporkan Kejadian"),
        ),
        body: Padding(
          padding: const EdgeInsets.all(16.0),
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
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
                SizedBox(height: 16.0),
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
                        _selectedJenisBencana = value;
                      });
                    },
                  ),
                ),
                SizedBox(height: 16.0),
                Container(
                  padding: EdgeInsets.symmetric(horizontal: 12.0),
                  decoration: BoxDecoration(
                    border: Border.all(color: Colors.grey),
                    borderRadius: BorderRadius.circular(8.0),
                  ),
                  child: TextField(
                    controller: _namaBencanaController,
                    decoration: InputDecoration(
                      labelText: "Nama Bencana",
                    ),
                  ),
                ),
                SizedBox(height: 16.0),
                Container(
                  padding: EdgeInsets.symmetric(horizontal: 12.0),
                  decoration: BoxDecoration(
                    border: Border.all(color: Colors.grey),
                    borderRadius: BorderRadius.circular(8.0),
                  ),
                  child: TextField(
                    controller: _lokasiBencanaController,
                    readOnly: true,
                    onTap: () => _pickLocation(context),
                    decoration: InputDecoration(
                      labelText: "Lokasi Bencana",
                    ),
                  ),
                ),
                SizedBox(height: 16.0),
                if (_selectedLocation != null)
                  Text(
                    "Selected Location: Lat: ${_selectedLocation!.latitude}, Lng: ${_selectedLocation!.longitude}",
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                SizedBox(height: 16.0),
                Container(
                  padding: EdgeInsets.symmetric(horizontal: 12.0),
                  decoration: BoxDecoration(
                    border: Border.all(color: Colors.grey),
                    borderRadius: BorderRadius.circular(8.0),
                  ),
                  child: TextField(
                    controller: _keteranganBencanaController,
                    decoration: InputDecoration(
                      labelText: "Keterangan Bencana",
                    ),
                  ),
                ),
                SizedBox(height: 16.0),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    _image != null
                        ? FutureBuilder(
                      future: compressImage(_image!.path),
                      builder: (BuildContext context,
                          AsyncSnapshot<List<int>> snapshot) {
                        if (snapshot.connectionState ==
                            ConnectionState.done) {
                          return AspectRatio(
                            aspectRatio: 4 / 3,
                            child: Image.memory(
                              Uint8List.fromList(snapshot.data!),
                              fit: BoxFit.cover,
                            ),
                          );
                        } else {
                          return CircularProgressIndicator();
                        }
                      },
                    )
                        : SizedBox(height: 8.0),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        TextButton(
                          onPressed: () async {
                            final ImageSource source = ImageSource.camera;
                            final XFile? image = await ImagePicker()
                                .pickImage(source: source);

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
                  ],
                ),
                SizedBox(height: 16.0),
                ElevatedButton(
                  onPressed: _isSubmitting ? null : () => _submitReport(),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.blue,
                    padding: EdgeInsets.all(16.0),
                  ),
                  child: _isSubmitting
                      ? CircularProgressIndicator(color: Colors.white)
                      : Text(
                    'Lapor',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 18,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Future<void> _pickLocation(BuildContext context) async {
    LatLng? pickedLocation = await Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => LocationPickerMap(),
      ),
    );

    if (pickedLocation != null) {
      setState(() {
        _selectedLocation = pickedLocation;
        _lokasiBencanaController.text =
        "Lat: ${pickedLocation.latitude}, Lng: ${pickedLocation.longitude}";
      });
    }
  }

  Future<List<int>> compressImage(String imagePath) async {
    File file = File(imagePath);
    List<int> imageBytes = await file.readAsBytes();
    img.Image image = img.decodeImage(Uint8List.fromList(imageBytes))!;

    int targetWidth = 400;
    int targetHeight = (targetWidth * image.height ~/ image.width);

    img.Image resizedImage =
    img.copyResize(image, width: targetWidth, height: targetHeight);

    return img.encodeJpg(resizedImage, quality: 94);
  }

  void _submitReport() async {
    if (_validateForm()) {
      setState(() {
        _isSubmitting = true;
      });

      try {
        File file = _image!;
        String uniqueFileName =
        DateTime.now().millisecondsSinceEpoch.toString();

        Reference referenceRoot = FirebaseStorage.instance.ref();
        Reference referenceDirImages = referenceRoot.child('images');

        Reference referenceImageToUpload =
        referenceDirImages.child(uniqueFileName);
        await referenceImageToUpload.putFile(File(file.path));
        String imageUrl = await referenceImageToUpload.getDownloadURL();

        List<int> compressedImage = await compressImage(_image!.path);

        await FirebaseFirestore.instance.collection('reports').add({
          'jenisBencana': _selectedJenisBencana!.name,
          'namaBencana': _namaBencanaController.text,
          'lokasiBencana': _lokasiBencanaController.text,
          'keteranganBencana': _keteranganBencanaController.text,
          'imageUrl': imageUrl,
          'image': compressedImage,
        });

        _resetForm();
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text("Laporan berhasil dikirim"),
          ),
        );
      } catch (e) {
        print("Error submitting report: $e");
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text("Terjadi kesalahan. Harap coba lagi."),
          ),
        );
      }
    }
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

  void _resetForm() {
    setState(() {
      _isSubmitting = false;
      _selectedJenisBencana = null;
      _namaBencanaController.clear();
      _lokasiBencanaController.clear();
      _keteranganBencanaController.clear();
      _image = null;
      _selectedLocation = null;
    });
  }
}
